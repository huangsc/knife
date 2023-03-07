package project

import (
	"os"
	"path/filepath"
	"text/template"
)

type tplPrams struct {
	ProjectName  string
	AppName      string
	AppNameUpper string
}

func genFile(path string, fileType FileType, tplParams tplPrams, tplContent string) error {
	var (
		file        *os.File
		err         error
		tmplContent string
		fileName    string
	)

	tmpl := template.New("file")
	fileName = tplParams.AppName
	switch fileType {
	case fileTypeApp:
		tmplContent = appTemplate
	case fileTypeEntity:
		tmplContent = entityTemplate
	case fileTypeRepo:
		tmplContent = repositoryTemplate
	case fileTypeStorage:
		tmplContent = storageTemplate
		fileName = "storage"
	case fileTypePersistence:
		tmplContent = persistenceMysqlTemplate
	case fileTypeHandler:
		tmplContent = handlerTemplate
	case fileTypeMiddleware:
		tmplContent = middlewareTemplate
		fileName = "middleware"
	case fileTypeMain:
		tmplContent = mainTemplate
		fileName = "main"
	}

	tmpl, err = tmpl.Parse(tmplContent)
	if err != nil {
		return err
	}

	file, err = os.Create(filepath.Join(path, fileName+".go"))
	if err != nil {
		return err
	}

	defer file.Close()

	return tmpl.Execute(file, tplParams)
}
