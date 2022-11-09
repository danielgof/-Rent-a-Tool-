package model

import "gorm.io/gorm"

type Offer struct {
	gorm.Model
	Id          int    `json:"id" gorm:"primary_key"`
	Tool        string `json:"name"`
	ToolName    string `json:"Tool_Name"`
	Location    string `json:"Location"`
	OwnerName   string `json:"owner_name"`
	PhoneNumber string `json:"phone_number"`
}
