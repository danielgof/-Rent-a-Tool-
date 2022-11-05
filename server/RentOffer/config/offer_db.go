package config

import (
	"RentOffer/model"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

var DB *gorm.DB

func Connect() {
	db, err := gorm.Open(postgres.Open("host=localhost user=daniel password=admin database=usersdata port=5432"), &gorm.Config{})
	if err != nil {
		panic(err)
	}
	db.AutoMigrate(&model.Offer{})
	DB = db
}
