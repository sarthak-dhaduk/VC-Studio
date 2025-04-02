// DOM Elements
const createRoomButton = document.getElementById("createRoom");
const joinRoomButton = document.getElementById("joinRoom");
const roomIdInput = document.getElementById("roomId");
const languageDropdown = document.getElementById("languageDropdown");
const stdinBox = document.getElementById("stdinBox");
const outputBox = document.getElementById("outputBox");
const userListDiv = document.getElementById("memberCollapse");
const userEmail = document.getElementById("lblUserEmail").innerText;
const roomIdInputCopy = document.getElementById("roomIdInput");
const txtInputTitle = document.getElementById("txtInputTitle");
const postCode = document.getElementById("postCode");
const activeCode = document.getElementById("MainContent_activeCode");
const postLanguageGet = document.getElementById("postLanguage");
const activeLanguage = document.getElementById("MainContent_activeLanguage");
const historyCode = document.getElementById("historyCode");
const historyLanguage = document.getElementById("historyLanguage");
const historyid = document.getElementById("historyId");
const workspaceLinks = document.querySelectorAll("#workspaceList a");
const insideSave = document.querySelector('#insideSave a');

document.getElementById('btnLogout').addEventListener('click', function () {
    localStorage.clear();
});

document.addEventListener("DOMContentLoaded", function () {
    const joinModal = document.getElementById("joinmodal");

    // Ensure Bootstrap removes the modal correctly
    joinModal.addEventListener("hidden.bs.modal", function () {
        const backdrop = document.querySelector(".modal-backdrop");
        if (backdrop) {
            backdrop.remove(); // Remove leftover backdrop
        }

        // Ensure body scrolling is restored
        document.body.classList.remove("modal-open");
        document.body.style.overflow = "auto";
    });
});


let editor;
let ws;
let suppressEditorChanges = false; // To avoid recursive updates
let currentRoomId = localStorage.getItem("currentRoomId");
let firsttime = localStorage.getItem("firsttime");
let postLanguage = "python";
let setHistoryID;
let setCode;


// Check if there's a room already stored in localStorage and auto-join
if (currentRoomId && firsttime == "true") {
    localStorage.setItem("firsttime", "false");
    roomIdInput.value = currentRoomId;
    roomIdInputCopy.value = currentRoomId;
    connectToServer(currentRoomId);  // Reconnect using the stored room ID
    const createRoomModal = new bootstrap.Modal(document.getElementById('create-room-modal'), {
        keyboard: false // Optional: prevents closing the modal by pressing ESC
    });

    createRoomModal.show();
}

// Initialize Monaco Editor
require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min/vs' } });
require(['vs/editor/editor.main'], function () {
    editor = monaco.editor.create(document.getElementById("codeEditor"), {
        language: 'python',
        theme: 'vs-dark',
        automaticLayout: true,
        //readOnly: true
    });

    if (historyid.value) {
        setupHiddenFieldListeners();
    }
    // Handle editor input changes for live collaboration
    editor.onDidChangeModelContent(() => {
        if (!suppressEditorChanges && ws && ws.readyState === WebSocket.OPEN) {
            const content = editor.getValue();
            ws.send(content); // Send editor content to server
        }
    });
});

if (languageDropdown) {
    // Change language dynamically based on selection
    languageDropdown.addEventListener("change", function () {
        const selectedLanguage = this.value;
        postLanguage = selectedLanguage;
        postLanguageGet.value = postLanguage;
        monaco.editor.setModelLanguage(editor.getModel(), selectedLanguage);
    });
}

if (txtInputTitle) {
    // Change language dynamically based on selection
    txtInputTitle.addEventListener("change", function () {
        const postCodeGet = editor.getValue();
        postCode.value = postCodeGet;
        postLanguageGet.value = postLanguage;
    });
}

// Generate unique Room ID
function generateRoomId() {
    return Math.random().toString(36).substr(2, 8).toUpperCase();
}

if (createRoomButton) {
    // Create Room Button Click
    createRoomButton.addEventListener("click", () => {
        currentRoomId = generateRoomId();
        roomIdInput.value = currentRoomId;
        localStorage.clear();
        localStorage.setItem("currentRoomId", currentRoomId);
        localStorage.setItem("firsttime", "true");
        connectToServer(currentRoomId);
        roomIdInputCopy.value = currentRoomId;
        postLanguageGet.value = postLanguage;
        const postCodeGet = editor.getValue();
        postCode.value = postCodeGet;

    });
}

if (insideSave) {
    insideSave.onclick = function (event) {
        try {
            const postCodeGet = editor.getValue();
            activeCode.value = postCodeGet;
            activeLanguage.value = postLanguage;
            historyCode.value = postCodeGet;
            historyLanguage.value = postLanguage;
            alert("Changes done");

        } catch (error) {
            console.error("Client-side script failed:", error);
            alert("Failed to execute client-side logic. Aborting...");
        }
    };
}


workspaceLinks.forEach((link) => {
    link.addEventListener("click", (event) => {
        setupHiddenFieldListeners();

        const fullId = link.id;
        const roomId = fullId.split("_")[1];

        console.log("Room ID:", roomId);

        currentRoomId = roomId;
        roomIdInput.value = currentRoomId;
        localStorage.clear();
        localStorage.setItem("currentRoomId", currentRoomId);
        localStorage.setItem("firsttime", "true");
        connectToServer(currentRoomId); // Call your server connection function
        console.log("Connected to room:", currentRoomId);
        roomIdInputCopy.value = currentRoomId;
    });
});

function setupHiddenFieldListeners() {
    setCode = historyCode.value;
    languageDropdown.value = historyLanguage.value; // Set the value of the dropdown
    if (historyCode && historyCode.value && typeof editor !== "undefined") {
        editor.setValue(String(setCode)); // Set the value in the editor
    }
}

if (document.getElementById('joinWorkSpace')) {
    document.getElementById('joinWorkSpace').addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default behavior (e.g., page reload)
        const joinModal = new bootstrap.Modal(document.getElementById('joinmodal')); // Initialize modal
        joinModal.show(); // Show modal programmatically
    });
}

if (joinRoomButton) {
    // Join Room Button Click
    joinRoomButton.addEventListener("click", () => {
        const roomId = roomIdInput.value;
        if (!roomId) {
            alert("Please enter a valid Room ID.");
            return;
        }

        currentRoomId = roomId;  // Save room ID to localStorage
        connectToServer(currentRoomId);
    });
}

// Connect to WebSocket Server
function connectToServer(roomId) {
    //if (ws) {
    //    ws.close();  // Close any existing WebSocket connection before creating a new one
    //}

    ws = new WebSocket("ws://localhost:8080/ws/");

    ws.onopen = () => {
        ws.send(`JOIN:${roomId}`);
        ws.send(`Email:${userEmail}`);
    };

    ws.onmessage = (event) => {
        const message = event.data;

        if (message.startsWith("USERS:")) {
            const usersList = message.replace("USERS:", "").split(",");

            userListDiv.innerHTML = ""; // Clear existing list

            usersList.forEach((user) => {
                const userItem = document.createElement("li");
                userItem.className = "nav-item"; // Apply the appropriate class
                userItem.innerHTML = `
        <a class="nav-link text-light d-flex align-items-center collapsed" href="#">
            <svg class="icon-shadow" width="20" height="20" viewBox="0 0 20 20" fill="none"
                xmlns="http://www.w3.org/2000/svg">
                <path
                    d="M15 17.5V17C15 15.3431 13.6569 14 12 14H8C6.34315 14 5 15.3431 5 17V17.5M13 8C13 9.65685 11.6569 11 10 11C8.34315 11 7 9.65685 7 8C7 6.34315 8.34315 5 10 5C11.6569 5 13 6.34315 13 8ZM19 10C19 14.9706 14.9706 19 10 19C5.02944 19 1 14.9706 1 10C1 5.02944 5.02944 1 10 1C14.9706 1 19 5.02944 19 10Z"
                    stroke="#686B6E" stroke-width="1.5" stroke-linecap="round"
                    stroke-linejoin="round" />
            </svg>
            <span class="ms-2">${user.trim()}</span>
        </a>
    `;
                userListDiv.appendChild(userItem);
            });
        } else {
            suppressEditorChanges = true;

            // Update editor content if it differs
            if (editor && message && editor.getValue() !== message) {
                editor.setValue(message);
            }

            suppressEditorChanges = false;
        }
    };
}


// Run Code Button Functionality
if (document.getElementById('showRunButton')) {
    document.getElementById('showRunButton').addEventListener('click', function (event) {
        event.preventDefault(); // Prevent default behavior (e.g., page reload)

        const sourceCode = editor.getValue();
        const userInput = stdinBox.value;

        const requestBody = {
            language: languageDropdown.value,
            version: '*',
            files: [
                { content: sourceCode }
            ],
            stdin: userInput || ""
        };

        fetch('https://emkc.org/api/v2/piston/execute', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestBody)
        })
            .then(response => response.json())
            .then(data => {
                if (data.run && data.run.stdout) {
                    outputBox.value = data.run.stdout;
                } else if (data.run && data.run.stderr) {
                    outputBox.value = "Error: " + data.run.stderr;
                } else {
                    outputBox.value = "Unknown error occurred.";
                }
            })
            .catch(error => {
                console.error('Error executing code:', error);
                outputBox.value = "API request failed.";
            });
    });
}






////////////////////////////////////////////////////////////////////////////////////////////////////////////////////







const copyButton = document.getElementById("copyButton");
const copyButtonText = document.getElementById("copyButtonText");


if (copyButton) {
    copyButton.addEventListener("click", () => {
        roomIdInputCopy.select();
        roomIdInputCopy.setSelectionRange(0, 99999);
        navigator.clipboard.writeText(roomIdInputCopy.value)
            .then(() => {
                copyButtonText.textContent = "Copied";

                setTimeout(() => {
                    copyButtonText.textContent = "Copy Link";
                }, 2000);
            })
            .catch((err) => {
                console.error("Failed to copy: ", err);
            });
    });
}


document.addEventListener('DOMContentLoaded', function () {
    const dropdownItems = document.querySelectorAll('.dropdown-item-contact');

    dropdownItems.forEach(item => {
        item.addEventListener('click', function () {
            const selectedValue = item.getAttribute('data-value');
            const button = document.querySelector('.custom-select-button');
            button.textContent = selectedValue;
        });
    });
});
document.addEventListener('DOMContentLoaded', function () {
    const dropdownItems = document.querySelectorAll('.dropdown-menu .dropdown-item');

    dropdownItems.forEach(item => {
        item.addEventListener('click', function () {
            const selectedValue = item.textContent.trim();
            const dropdownToggle = document.querySelector('.dropdown-toggle');
            dropdownToggle.textContent = selectedValue;
        });
    });
});

if (VanillaTilt) {
    VanillaTilt.init(document.querySelectorAll('.tilt'), {
        max: 10,
        speed: 400
    });
}
document.addEventListener('DOMContentLoaded', function () {
    var cards = document.querySelectorAll('.tilt-effect');
    VanillaTilt.init(cards, {
        max: 10,
        speed: 400,
        glare: true,
        'max-glare': 0.5
    });
});

if (document.getElementById('showRunButton')) {
    document.getElementById('showRunButton').addEventListener('click', function () {
        document.getElementById('hideThisDiv').classList.remove('d-none');
        document.getElementById('codeInput').style.minHeight = '18rem';
    });
}

if (document.getElementById('closeButton')) {
    document.getElementById('closeButton').addEventListener('click', function () {
        document.getElementById('hideThisDiv').classList.add('d-none');
        document.getElementById('codeInput').style.minHeight = '40.4rem';
    });
}

(function () {
    "use strict";
    /**
     * Easy selector helper function
     */
    const select = (el, all = false) => {
        el = el.trim()
        if (all) {
            return [...document.querySelectorAll(el)]
        } else {
            return document.querySelector(el)
        }
    }

    /**
     * Easy event listener function
     */
    const on = (type, el, listener, all = false) => {
        if (all) {
            select(el, all).forEach(e => e.addEventListener(type, listener))
        } else {
            select(el, all).addEventListener(type, listener)
        }
    }

    /**
     * Easy on scroll event listener 
     */
    const onscroll = (el, listener) => {
        el.addEventListener('scroll', listener)
    }

    /**
     * Sidebar toggle
     */
    if (select('.toggle-sidebar-btn')) {
        // Click event for the toggle button
        on('click', '.toggle-sidebar-btn', function (e) {
            e.preventDefault();

            const body = select('body');
            const toggleButtonIcon = select('.toggle-sidebar-btn i'); // Icon inside the button

            body.classList.toggle('toggle-sidebar'); // Toggle sidebar visibility

            // Change the button icon dynamically
            if (body.classList.contains('toggle-sidebar')) {
                toggleButtonIcon.classList.remove('bi-layout-sidebar-inset');
                toggleButtonIcon.classList.add('bi-layout-sidebar-inset-reverse');
            } else {
                toggleButtonIcon.classList.remove('bi-layout-sidebar-inset-reverse');
                toggleButtonIcon.classList.add('bi-layout-sidebar-inset');
            }
        });

        // Ensure the initial icon reflects the sidebar state on load
        const body = select('body');
        const toggleButtonIcon = select('.toggle-sidebar-btn i');
        if (body.classList.contains('toggle-sidebar')) {
            toggleButtonIcon.classList.remove('bi-layout-sidebar-inset');
            toggleButtonIcon.classList.add('bi-layout-sidebar-inset-reverse');
        } else {
            toggleButtonIcon.classList.remove('bi-layout-sidebar-inset-reverse');
            toggleButtonIcon.classList.add('bi-layout-sidebar-inset');
        }
    }



    /**
     * Search bar toggle
     */
    if (select('.search-bar-toggle')) {
        on('click', '.search-bar-toggle', function (e) {
            select('.search-bar').classList.toggle('search-bar-show')
        })
    }

    /**
     * Navbar links active state on scroll
     */
    let navbarlinks = select('#navbar .scrollto', true)
    const navbarlinksActive = () => {
        let position = window.scrollY + 200
        navbarlinks.forEach(navbarlink => {
            if (!navbarlink.hash) return
            let section = select(navbarlink.hash)
            if (!section) return
            if (position >= section.offsetTop && position <= (section.offsetTop + section.offsetHeight)) {
                navbarlink.classList.add('active')
            } else {
                navbarlink.classList.remove('active')
            }
        })
    }
    window.addEventListener('load', navbarlinksActive)
    onscroll(document, navbarlinksActive)

    /**
     * Toggle .header-scrolled class to #header when page is scrolled
     */
    let selectHeader = select('#header')
    if (selectHeader) {
        const headerScrolled = () => {
            if (window.scrollY > 100) {
                selectHeader.classList.add('header-scrolled')
            } else {
                selectHeader.classList.remove('header-scrolled')
            }
        }
        window.addEventListener('load', headerScrolled)
        onscroll(document, headerScrolled)
    }

    /**
     * Back to top button
     */
    let backtotop = select('.back-to-top')
    if (backtotop) {
        const toggleBacktotop = () => {
            if (window.scrollY > 100) {
                backtotop.classList.add('active')
            } else {
                backtotop.classList.remove('active')
            }
        }
        window.addEventListener('load', toggleBacktotop)
        onscroll(document, toggleBacktotop)
    }

    let scrollToDivButton = document.querySelector('.run-btn');
    if (scrollToDivButton) {
        const toggleScrollToDivButton = () => {
            if (window.scrollY > 100) {
                scrollToDivButton.classList.add('active'); // Show button when scrolled down
            } else {
                scrollToDivButton.classList.remove('active'); // Hide button when at the top
            }
        }

        window.addEventListener('load', toggleScrollToDivButton);
        window.addEventListener('scroll', toggleScrollToDivButton);

        // Scroll to the target div when the button is clicked
        scrollToDivButton.addEventListener('click', () => {
            const targetDiv = document.querySelector('#hideThisDiv'); // Change to your div's ID
            if (targetDiv) {
                targetDiv.scrollIntoView({ behavior: 'smooth' }); // Scroll smoothly to the div
            }
        });
    }



    /**
     * Initiate tooltips
     */
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl)
    })

    /**
     * Initiate quill editors
     */
    if (select('.quill-editor-default')) {
        new Quill('.quill-editor-default', {
            theme: 'snow'
        });
    }

    if (select('.quill-editor-bubble')) {
        new Quill('.quill-editor-bubble', {
            theme: 'bubble'
        });
    }

    if (select('.quill-editor-full')) {
        new Quill(".quill-editor-full", {
            modules: {
                toolbar: [
                    [{
                        font: []
                    }, {
                        size: []
                    }],
                    ["bold", "italic", "underline", "strike"],
                    [{
                        color: []
                    },
                    {
                        background: []
                    }
                    ],
                    [{
                        script: "super"
                    },
                    {
                        script: "sub"
                    }
                    ],
                    [{
                        list: "ordered"
                    },
                    {
                        list: "bullet"
                    },
                    {
                        indent: "-1"
                    },
                    {
                        indent: "+1"
                    }
                    ],
                    ["direction", {
                        align: []
                    }],
                    ["link", "image", "video"],
                    ["clean"]
                ]
            },
            theme: "snow"
        });
    }

    /**
     * Initiate TinyMCE Editor
     */

    const useDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const isSmallScreen = window.matchMedia('(max-width: 1023.5px)').matches;

    /**
     * Initiate Bootstrap validation check
     */
    var needsValidation = document.querySelectorAll('.needs-validation')

    Array.prototype.slice.call(needsValidation)
        .forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) {
                    event.preventDefault()
                    event.stopPropagation()
                }

                form.classList.add('was-validated')
            }, false)
        })

    /**
     * Initiate Datatables
     */
    const datatables = select('.datatable', true)
    datatables.forEach(datatable => {
        new simpleDatatables.DataTable(datatable, {
            perPageSelect: [5, 10, 15, ["All", -1]],
            columns: [{
                select: 2,
                sortSequence: ["desc", "asc"]
            },
            {
                select: 3,
                sortSequence: ["desc"]
            },
            {
                select: 4,
                cellClass: "green",
                headerClass: "red"
            }
            ]
        });
    })

    /**
     * Autoresize echart charts
     */
    const mainContainer = select('#main');
    if (mainContainer) {
        setTimeout(() => {
            new ResizeObserver(function () {
                select('.echart', true).forEach(getEchart => {
                    echarts.getInstanceByDom(getEchart).resize();
                })
            }).observe(mainContainer);
        }, 200);
    }

})();