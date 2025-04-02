using System.Collections.Concurrent;
using System.Net.WebSockets;
using System.Net;
using System.Text;

namespace VC_Studio_Server
{
    public class WebSocketServer
    {
        private readonly HttpListener _listener;
        private readonly ConcurrentDictionary<string, ConcurrentBag<WebSocket>> _rooms = new ConcurrentDictionary<string, ConcurrentBag<WebSocket>>();
        private readonly ConcurrentDictionary<string, HashSet<string>> _roomUsers = new ConcurrentDictionary<string, HashSet<string>>();

        public WebSocketServer(string uriPrefix)
        {
            _listener = new HttpListener();
            _listener.Prefixes.Add(uriPrefix);
        }

        public async Task StartAsync()
        {
            _listener.Start();
            Console.WriteLine("WebSocket server started.");

            while (true)
            {
                var context = await _listener.GetContextAsync();

                if (context.Request.IsWebSocketRequest)
                {
                    HandleWebSocketRequest(context);
                }
                else
                {
                    context.Response.StatusCode = 400;
                    context.Response.Close();
                }
            }
        }

        private async void HandleWebSocketRequest(HttpListenerContext context)
        {
            var wsContext = await context.AcceptWebSocketAsync(null);
            var webSocket = wsContext.WebSocket;

            await ProcessClient(webSocket);
        }

        private async Task ProcessClient(WebSocket webSocket)
        {
            var buffer = new byte[1024];
            string currentRoom = null;

            try
            {
                while (webSocket.State == WebSocketState.Open)
                {
                    var result = await webSocket.ReceiveAsync(new ArraySegment<byte>(buffer), CancellationToken.None);

                    if (result.MessageType == WebSocketMessageType.Text)
                    {
                        string message = Encoding.UTF8.GetString(buffer, 0, result.Count);

                        if (message.StartsWith("JOIN:"))
                        {
                            currentRoom = message.Split(':')[1].Trim();

                            // Add WebSocket to the room
                            if (!_rooms.ContainsKey(currentRoom))
                                _rooms[currentRoom] = new ConcurrentBag<WebSocket>();

                            _rooms[currentRoom].Add(webSocket);
                            _roomUsers.TryAdd(currentRoom, new HashSet<string>());

                            Console.WriteLine($"Client joined room {currentRoom}");
                        }
                        else if (message.StartsWith("Email:"))
                        {
                            if (currentRoom != null && _roomUsers.ContainsKey(currentRoom))
                            {
                                var email = message.Replace("Email:", "").Trim();
                                _roomUsers[currentRoom].Add(email);

                                // Broadcast updated user list
                                await BroadcastUserList(currentRoom);
                            }
                        }
                        else
                        {
                            // Broadcast message to all clients in the same room
                            if (currentRoom != null && _rooms.ContainsKey(currentRoom))
                            {
                                foreach (var client in _rooms[currentRoom])
                                {
                                    if (client != webSocket && client.State == WebSocketState.Open)
                                    {
                                        try
                                        {
                                            await client.SendAsync(
                                                new ArraySegment<byte>(Encoding.UTF8.GetBytes(message)),
                                                WebSocketMessageType.Text,
                                                true,
                                                CancellationToken.None
                                            );
                                        }
                                        catch (Exception ex)
                                        {
                                            Console.WriteLine($"Error broadcasting message: {ex.Message}");
                                        }
                                    }
                                }
                            }
                        }
                    }
                    else if (result.MessageType == WebSocketMessageType.Close)
                    {
                        if (currentRoom != null && _rooms.ContainsKey(currentRoom))
                        {
                            _rooms[currentRoom].TryTake(out webSocket);
                        }

                        await webSocket.CloseAsync(WebSocketCloseStatus.NormalClosure, "Closing", CancellationToken.None);
                        Console.WriteLine($"Client disconnected from room {currentRoom}");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
            }
            finally
            {
                if (currentRoom != null && _rooms.ContainsKey(currentRoom))
                {
                    _rooms[currentRoom].TryTake(out webSocket);
                }
            }
        }

        private async Task BroadcastUserList(string room)
        {
            if (_roomUsers.ContainsKey(room))
            {
                var userList = string.Join(",", _roomUsers[room]);
                foreach (var client in _rooms[room])
                {
                    if (client.State == WebSocketState.Open)
                    {
                        try
                        {
                            await client.SendAsync(
                                new ArraySegment<byte>(Encoding.UTF8.GetBytes($"USERS:{userList}")),
                                WebSocketMessageType.Text,
                                true,
                                CancellationToken.None
                            );
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine($"Error broadcasting user list: {ex.Message}");
                        }
                    }
                }
            }
        }
    }
}
