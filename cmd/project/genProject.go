package project

import (
	_ "embed"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/spf13/cobra"
)

var (
	//go:embed template/application.tpl
	appTemplate string
	//go:embed template/entity.tpl
	entityTemplate string
	//go:embed template/repository.tpl
	repositoryTemplate string
	//go:embed template/storage.tpl
	storageTemplate string
	//go:embed template/persistence_mysql.tpl
	persistenceMysqlTemplate string
	//go:embed template/handler.tpl
	handlerTemplate string
	//go:embed template/middleware.tpl
	middlewareTemplate string
	//go:embed template/main.tpl
	mainTemplate string

	projectName string
	projectPath string
	appName     string = "example"
)

func gen(cmd *cobra.Command, args []string) error {
	if len(args) == 0 {
		return errors.New("project name should not be empty")
	}

	rootPath, err := os.Getwd()
	if err != nil {
		return err
	}

	projectName = args[0]
	projectPath = filepath.Join(rootPath, projectName)

	if _, err = os.Stat(projectPath); err == nil {
		return fmt.Errorf("dir %s  is already exist", projectName)
	}

	if err = os.MkdirAll(projectPath, os.ModePerm); err != nil {
		return err
	}

	switch ServiceType(serviceType) {
	case serviceTypeMono:
		return createMonoProject(projectPath)
	case serviceTypeMicro:
		return createMicroProject(projectPath)
	default:
		return errors.New("invalid service type")
	}
}

func createMonoProject(workDir string) error {
	applicationDir := filepath.Join(workDir, "application")
	domainDir := filepath.Join(workDir, "domain")
	infrastructureDir := filepath.Join(workDir, "infrastructure")
	interfaceDir := filepath.Join(workDir, "interface")

	os.Mkdir(applicationDir, os.ModePerm)
	genFile(applicationDir, fileTypeApp, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, appTemplate)

	os.Mkdir(domainDir, os.ModePerm)
	entityDir := filepath.Join(domainDir, "entity")
	repositoryDir := filepath.Join(domainDir, "repository")
	os.Mkdir(entityDir, os.ModePerm)
	os.Mkdir(repositoryDir, os.ModePerm)
	genFile(entityDir, fileTypeEntity, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, entityTemplate)
	genFile(repositoryDir, fileTypeRepo, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, repositoryTemplate)

	os.Mkdir(infrastructureDir, os.ModePerm)
	persistenceDir := filepath.Join(infrastructureDir, "persistence")
	os.Mkdir(persistenceDir, os.ModePerm)
	genFile(persistenceDir, fileTypeStorage, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, storageTemplate)
	genFile(persistenceDir, fileTypePersistence, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, persistenceMysqlTemplate)

	os.Mkdir(interfaceDir, os.ModePerm)
	genFile(interfaceDir, fileTypeHandler, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:],
	}, handlerTemplate)

	middlewareDir := filepath.Join(interfaceDir, "middleware")
	os.Mkdir(middlewareDir, os.ModePerm)
	genFile(middlewareDir, fileTypeMiddleware, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:]},
		middlewareTemplate)

	genFile(workDir, fileTypeMain, tplPrams{
		ProjectName:  projectName,
		AppName:      appName,
		AppNameUpper: strings.ToUpper(appName[:1]) + appName[1:]},
		mainTemplate)

	return nil
}

func createMicroProject(workDir string) error {
	return nil
}

// func execCommand(dir, arg string, envArgs ...string) int {
// 	cmd := exec.Command("sh", "-c", arg)
// 	env := append([]string(nil), os.Environ()...)
// 	env = append(env, envArgs...)
// 	cmd.Env = env
// 	cmd.Dir = dir
// 	cmd.Stdout = os.Stdout
// 	cmd.Stderr = os.Stderr
// 	_ = cmd.Run()
// 	return cmd.ProcessState.ExitCode()
// }

// func goStart(dir string) {
// 	execCommand(dir, "go run .")
// }

// func goModInit(dir string) int {
// 	return execCommand(dir, "go mod init", projectName)
// }

// func goModTidy(dir string) int {
// 	return execCommand(dir, "go mod tidy")
// }
