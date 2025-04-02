using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using VC_Studio_Server;
using System.Threading.Tasks;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Start WebSocket server on a separate thread
Task.Run(() => new WebSocketServer("http://localhost:8080/").StartAsync());

// Enable serving static files from wwwroot
app.UseStaticFiles();

app.UseRouting();

// Configure MVC Routes
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
