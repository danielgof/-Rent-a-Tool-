package controller

import (
	db "RentRequest/config"
	"RentRequest/model"
	"github.com/gin-gonic/gin"
)

func GetRequest(c *gin.Context) {
	requests := []model.Request{}
	db.DB.Find(&requests)
	c.JSON(200, &requests)
}

func CreateRequest(c *gin.Context) {
	var request model.Request
	c.BindJSON(&request)
	db.DB.Create(&request)
	c.JSON(200, &request)
}

func DeleteRequest(c *gin.Context) {
	var request model.Request
	db.DB.Where("id = ?", c.Param("id")).Delete(&request)
	c.JSON(200, &request)
}

func UpdateRequest(c *gin.Context) {
	var request model.Request
	db.DB.Where("id = ?", c.Param("id")).First(&request)
	c.BindJSON(&request)
	db.DB.Save(&request)
	c.JSON(200, &request)
}
