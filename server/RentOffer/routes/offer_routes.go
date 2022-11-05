package routes

import (
	"RentOffer/controller"
	"github.com/gin-gonic/gin"
)

func OfferRoute(router *gin.Engine) {
	router.GET(
		"/api/offers/all", controller.GetOffers)
	router.POST(
		"/api/offers/new", controller.CreateOffer)
	router.DELETE(
		"/api/offers/del/:id", controller.DeleteOffer)
	router.PUT(
		"/api/offers/offers/upd/:id", controller.UpdateOffer)
}
