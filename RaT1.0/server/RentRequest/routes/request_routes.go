package routes

import (
	"RentRequest/controller"
	"github.com/gin-gonic/gin"
)

func RequestRoute(router *gin.Engine) {
	router.GET(
		"/api/offers/all", controller.GetRequest)
	router.POST(
		"/api/offers/new", controller.CreateRequest)
	router.DELETE(
		"/api/offers/del/:id", controller.DeleteRequest)
	router.PUT(
		"/api/offers/offers/upd/:id", controller.UpdateRequest)
}
