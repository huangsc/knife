package entity

import (
	"time"
)

type {{.AppNameUpper}} struct {
	ID          uint64     `gorm:"primary_key;auto_increment" json:"id"`
	Filed1      uint64     `gorm:"size:100;not null;" json:"filed1"`
	Filed2      string     `gorm:"size:100;not null;unique" json:"filed2"`
	Filed3      string     `gorm:"text;not null;" json:"filed3"`
	CreatedAt   time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"created_at"`
	UpdatedAt   time.Time  `gorm:"default:CURRENT_TIMESTAMP" json:"updated_at"`
	DeletedAt   *time.Time `json:"deleted_at"`
}