package interfaces

import (
	"fmt"
	"{{.ProjectName}}/application"
	"{{.ProjectName}}/domain/entity"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
	"time"
)

type {{.AppNameUpper}} struct {
	{{.AppName}}App    application.{{.AppNameUpper}}AppInterface
}

func New{{.AppNameUpper}}({{.AppName}}App application.{{.AppNameUpper}}AppInterface) *{{.AppNameUpper}} {
	return &{{.AppNameUpper}}{
		{{.AppName}}App:    {{.AppName}}App,
	}
}

func (a *{{.AppNameUpper}}) Save{{.AppNameUpper}}(c *gin.Context) {

	Filed3 := c.PostForm("Filed3")
	if fmt.Sprintf("%T", Filed3) != "string" {
		c.JSON(http.StatusUnprocessableEntity, gin.H{
			"invalid_json": "Invalid json",
		})
		return
	}

	empty{{.AppNameUpper}} := entity.{{.AppNameUpper}}{}
	empty{{.AppNameUpper}}.Filed3 = Filed3


	var {{.AppName}} = entity.{{.AppNameUpper}}{}
	{{.AppName}}.Filed3 = Filed3

	saved{{.AppNameUpper}}, saveErr := a.{{.AppName}}App.Save{{.AppNameUpper}}(&{{.AppName}})
	if saveErr != nil {
		c.JSON(http.StatusInternalServerError, saveErr)
		return
	}
	c.JSON(http.StatusCreated, saved{{.AppNameUpper}})
}

func (a *{{.AppNameUpper}}) Update{{.AppNameUpper}}(c *gin.Context) {

	{{.AppName}}Id, err := strconv.ParseUint(c.Param("{{.AppName}}_id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, "invalid request")
		return
	}

	filed1 := c.PostForm("filed1")
	Filed3 := c.PostForm("Filed3")
	if fmt.Sprintf("%T", filed1) != "string" || fmt.Sprintf("%T", Filed3) != "string" {
		c.JSON(http.StatusUnprocessableEntity, "Invalid json")
	}

	empty{{.AppNameUpper}} := entity.{{.AppNameUpper}}{}
	empty{{.AppNameUpper}}.Filed3 = Filed3


	{{.AppName}}, err := a.{{.AppName}}App.Get{{.AppNameUpper}}({{.AppName}}Id)
	if err != nil {
		c.JSON(http.StatusNotFound, err.Error())
		return
	}

	{{.AppName}}.Filed3 = Filed3
	{{.AppName}}.UpdatedAt = time.Now()
	updated{{.AppNameUpper}}, dbUpdateErr := a.{{.AppName}}App.Update{{.AppNameUpper}}({{.AppName}})
	if dbUpdateErr != nil {
		c.JSON(http.StatusInternalServerError, dbUpdateErr)
		return
	}
	c.JSON(http.StatusOK, updated{{.AppNameUpper}})
}

func (a *{{.AppNameUpper}}) GetAll{{.AppNameUpper}}(c *gin.Context) {
	all{{.AppName}}, err := a.{{.AppName}}App.GetAll{{.AppNameUpper}}()
	if err != nil {
		c.JSON(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, all{{.AppName}})
}

func (a *{{.AppNameUpper}}) Get{{.AppNameUpper}}(c *gin.Context) {
	{{.AppName}}Id, err := strconv.ParseUint(c.Param("{{.AppName}}_id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, "invalid request")
		return
	}

	{{.AppName}}, err := a.{{.AppName}}App.Get{{.AppNameUpper}}({{.AppName}}Id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, err.Error())
		return
	}

	c.JSON(http.StatusOK, {{.AppName}})
}

func (a *{{.AppNameUpper}}) Delete{{.AppNameUpper}}(c *gin.Context) {
	{{.AppName}}Id, err := strconv.ParseUint(c.Param("{{.AppName}}_id"), 10, 64)
	if err != nil {
		c.JSON(http.StatusBadRequest, "invalid request")
		return
	}

	err = a.{{.AppName}}App.Delete{{.AppNameUpper}}({{.AppName}}Id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, "{{.AppName}} deleted")
}