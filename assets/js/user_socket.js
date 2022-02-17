// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// Bring in Phoenix channels client library:
import { Socket } from "phoenix"


// And connect to the path in "lib/moles_web/endpoint.ex". We pass the
// token for authentication. Read below how it should be used.
let socket = new Socket("/socket", { params: { token: window.userToken } })

socket.connect()

// Now that you are connected, you can join channels with a topic.
// Let's assume you have a channel with a topic named `room` and the
// subtopic is its id - in this case 42:
let channel = socket.channel("resume:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("presence_state", (users) => {
  for (let userId in users) {
    addUser(userId, users[userId].user.username)
  }
})

function removeUser(userId) {
  document.getElementById(`user-${userId}`)?.remove()
}

function addUser(userId, username) {
  removeUser(userId)
  let userList = document.getElementById("user-list")
  let user = document.createElement("li")
    user.innerText = username
    user.id = `user-${userId}`
    userList.appendChild(user)
}

channel.on("presence_diff", ({joins, leaves}) => {
  for (let userId in joins) {
    addUser(userId, joins[userId].user.username)
  }
  for (let userId in leaves) {
    removeUser(userId)
  }
})

export default socket
