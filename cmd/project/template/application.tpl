package application

import (
	"{{.ProjectName}}/domain/entity"
	"{{.ProjectName}}/domain/repository"
)

type {{.AppName}}App struct {
	fr repository.{{.AppNameUpper}}Repository
}


var _ {{.AppNameUpper}}AppInterface = &{{.AppName}}App{}

type {{.AppNameUpper}}AppInterface interface {
	Save{{.AppNameUpper}}(*entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string)
	GetAll{{.AppNameUpper}}() ([]entity.{{.AppNameUpper}}, error)
	Get{{.AppNameUpper}}(uint64) (*entity.{{.AppNameUpper}}, error)
	Update{{.AppNameUpper}}(*entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string)
	Delete{{.AppNameUpper}}(uint64) error
}

func (f *{{.AppName}}App) Save{{.AppNameUpper}}({{.AppName}} *entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string) {
	return f.fr.Save{{.AppNameUpper}}({{.AppName}})
}

func (f *{{.AppName}}App) GetAll{{.AppNameUpper}}() ([]entity.{{.AppNameUpper}}, error) {
	return f.fr.GetAll{{.AppNameUpper}}()
}

func (f *{{.AppName}}App) Get{{.AppNameUpper}}({{.AppName}}Id uint64) (*entity.{{.AppNameUpper}}, error) {
	return f.fr.Get{{.AppNameUpper}}({{.AppName}}Id)
}

func (f *{{.AppName}}App) Update{{.AppNameUpper}}({{.AppName}} *entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string) {
	return f.fr.Update{{.AppNameUpper}}({{.AppName}})
}

func (f *{{.AppName}}App) Delete{{.AppNameUpper}}({{.AppName}}Id uint64) error {
	return f.fr.Delete{{.AppNameUpper}}({{.AppName}}Id)
}