package model

import "gorm.io/gorm"

type Request struct {
	gorm.Model
	Id          int    `json:"id" gorm:"primary_key"`
	Tool        string `json:"name"`
	ToolName    string `json:"Tool_Name"`
	Price       string `json:"price"`
	OwnerName   string `json:"owner_name"`
	PhoneNumber string `json:"phone_number"`
}
