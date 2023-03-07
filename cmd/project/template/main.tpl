package main

import (
	"{{.ProjectName}}/infrastructure/persistence"
	"{{.ProjectName}}/interface"
	"{{.ProjectName}}/interface/middleware"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"log"
	"os"
)

func init() {
	if err := godotenv.Load(); err != nil {
		log.Println("no env gotten")
	}
}

func main() {

	dbdriver := os.Getenv("DB_DRIVER")
	host := os.Getenv("DB_HOST")
	password := os.Getenv("DB_PASSWORD")
	user := os.Getenv("DB_USER")
	dbname := os.Getenv("DB_NAME")
	port := os.Getenv("DB_PORT")

	services, err := persistence.NewRepositories(dbdriver, user, password, port, host, dbname)
	if err != nil {
		panic(err)
	}
	defer services.Close()
	services.Automigrate()

	{{.AppName}}s := interfaces.New{{.AppNameUpper}}(services.{{.AppNameUpper}})

	r := gin.Default()
	r.Use(middleware.CORSMiddleware()) //For CORS

	//post routes
	r.POST("/{{.AppName}}", middleware.AuthMiddleware(), middleware.MaxSizeAllowed(8192000), {{.AppName}}s.Save{{.AppNameUpper}})
	r.PUT("/{{.AppName}}/:{{.AppName}}_id", middleware.AuthMiddleware(), middleware.MaxSizeAllowed(8192000), {{.AppName}}s.Update{{.AppNameUpper}})
	r.GET("/{{.AppName}}/:{{.AppName}}_id", {{.AppName}}s.Get{{.AppNameUpper}})
	r.DELETE("/{{.AppName}}/:{{.AppName}}_id", middleware.AuthMiddleware(), {{.AppName}}s.Delete{{.AppNameUpper}})
	r.GET("/{{.AppName}}", {{.AppName}}s.GetAll{{.AppNameUpper}})

	app_port := os.Getenv("PORT")
	if app_port == "" {
		app_port = "8080"
	}
	log.Fatal(r.Run(":"+app_port))
}