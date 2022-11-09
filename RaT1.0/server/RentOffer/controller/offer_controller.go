package controller

import (
	db "RentOffer/config"
	"RentOffer/model"
	"github.com/gin-gonic/gin"
)

func GetOffers(c *gin.Context) {
	offers := []model.Offer{}
	db.DB.Find(&offers)
	c.JSON(200, &offers)
}

func CreateOffer(c *gin.Context) {
	var offer model.Offer
	c.BindJSON(&offer)
	db.DB.Create(&offer)
	c.JSON(200, &offer)
}

func DeleteOffer(c *gin.Context) {
	var offer model.Offer
	db.DB.Where("id = ?", c.Param("id")).Delete(&offer)
	c.JSON(200, &offer)
}

func UpdateOffer(c *gin.Context) {
	var offer model.Offer
	db.DB.Where("id = ?", c.Param("id")).First(&offer)
	c.BindJSON(&offer)
	db.DB.Save(&offer)
	c.JSON(200, &offer)
}
