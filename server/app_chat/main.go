// main.go
package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	socketio "github.com/googollee/go-socket.io"
)

func main() {
	r := gin.Default()

	// Create a new Socket.IO server
	server := socketio.NewServer(nil)

	// Define the connection event handler
	server.OnConnect("/", func(so socketio.Conn) error {
		log.Println("New user connected")
		return nil
	})

	// Define the disconnection event handler
	server.OnDisconnect("/", func(so socketio.Conn, reason string) {
		log.Println("User disconnected:", reason)
	})

	// Mount the Socket.IO server on the route "/socket.io/"
	r.GET("/socket.io/*any", gin.WrapH(server))

	// Serve the frontend or static files (Optional if you have a frontend)
	r.StaticFile("/", "./index.html")

	// Start the server on localhost:8080
	log.Println("Server started at http://localhost:8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
