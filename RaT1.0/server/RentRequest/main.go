package main

import (
	db "RentRequest/config"
	"RentRequest/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.New()
	db.Connect()
	routes.RequestRoute(router)
	router.Run(":8002")
}
