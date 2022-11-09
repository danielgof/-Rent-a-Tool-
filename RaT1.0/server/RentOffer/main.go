package main

import (
	db "RentOffer/config"
	"RentOffer/routes"
	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.New()
	db.Connect()
	routes.OfferRoute(router)
	router.Run(":8003")
}
