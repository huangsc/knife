package persistence

import (
	"errors"
	"{{.ProjectName}}/domain/entity"
	"{{.ProjectName}}/domain/repository"
	"github.com/jinzhu/gorm"
	"strings"
)


type {{.AppNameUpper}}Repo struct {
	db *gorm.DB
}

func New{{.AppNameUpper}}Repository(db *gorm.DB) *{{.AppNameUpper}}Repo {
	return &{{.AppNameUpper}}Repo{db}
}

//{{.AppNameUpper}}Repo implements the repository.{{.AppNameUpper}}Repository interface
var _ repository.{{.AppNameUpper}}Repository = &{{.AppNameUpper}}Repo{}

func (r *{{.AppNameUpper}}Repo) Save{{.AppNameUpper}}({{.AppName}} *entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string) {
	dbErr := map[string]string{}

	err := r.db.Debug().Create(&{{.AppName}}).Error
	if err != nil {
		//since our title is unique
		if strings.Contains(err.Error(), "duplicate") || strings.Contains(err.Error(), "Duplicate") {
			dbErr["unique_title"] = "{{.AppName}} title already taken"
			return nil, dbErr
		}
		//any other db error
		dbErr["db_error"] = "database error"
		return nil, dbErr
	}
	return {{.AppName}}, nil
}

func (r *{{.AppNameUpper}}Repo) Get{{.AppNameUpper}}(id uint64) (*entity.{{.AppNameUpper}}, error) {
	var {{.AppName}} entity.{{.AppNameUpper}}
	err := r.db.Debug().Where("id = ?", id).Take(&{{.AppName}}).Error
	if err != nil {
		return nil, errors.New("database error, please try again")
	}
	if gorm.IsRecordNotFoundError(err) {
		return nil, errors.New("{{.AppName}} not found")
	}
	return &{{.AppName}}, nil
}

func (r *{{.AppNameUpper}}Repo) GetAll{{.AppNameUpper}}() ([]entity.{{.AppNameUpper}}, error) {
	var {{.AppName}}s []entity.{{.AppNameUpper}}
	err := r.db.Debug().Limit(100).Order("created_at desc").Find(&{{.AppName}}s).Error
	if err != nil {
		return nil, err
	}
	if gorm.IsRecordNotFoundError(err) {
		return nil, errors.New("user not found")
	}
	return {{.AppName}}s, nil
}

func (r *{{.AppNameUpper}}Repo) Update{{.AppNameUpper}}({{.AppName}} *entity.{{.AppNameUpper}}) (*entity.{{.AppNameUpper}}, map[string]string) {
	dbErr := map[string]string{}
	err := r.db.Debug().Save(&{{.AppName}}).Error
	if err != nil {
		//since our title is unique
		if strings.Contains(err.Error(), "duplicate") || strings.Contains(err.Error(), "Duplicate") {
			dbErr["unique_title"] = "title already taken"
			return nil, dbErr
		}
		//any other db error
		dbErr["db_error"] = "database error"
		return nil, dbErr
	}
	return {{.AppName}}, nil
}

func (r *{{.AppNameUpper}}Repo) Delete{{.AppNameUpper}}(id uint64) error {
	var {{.AppName}} entity.{{.AppNameUpper}}
	err := r.db.Debug().Where("id = ?", id).Delete(&{{.AppName}}).Error
	if err != nil {
		return errors.New("database error, please try again")
	}
	return nil
}