package repository

import "{{.ProjectName}}/domain/entity"

type {{.AppNameUpper}}Repository interface {
	Save{{.AppNameUpper}}(*entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string)
	Get{{.AppNameUpper}}(uint64) (*entity.{{.AppNameUpper}}, error)
	GetAll{{.AppNameUpper}}() ([]entity.{{.AppNameUpper}}, error)
	Update{{.AppNameUpper}}(*entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string)
	Delete{{.AppNameUpper}}(uint64) error
}