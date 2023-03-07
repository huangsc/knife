package project

import (
	"github.com/spf13/cobra"
)

type ServiceType string
type FileType string

const (
	serviceTypeMono  ServiceType = "mono"
	serviceTypeMicro ServiceType = "micro"

	fileTypeApp    FileType = "app"
	fileTypeEntity FileType = "entity"
	fileTypeRepo   FileType = "repo"
	fileTypeStorage   FileType = "storage"
	fileTypePersistence   FileType = "persistence"
	fileTypeHandler   FileType = "handler"
	fileTypeMiddleware   FileType = "middle"
	fileTypeMain   FileType = "main"
)

// projectCmd represents the project command
var (
	serviceType string
	Cmd         = &cobra.Command{
		Use:   "project",
		Short: "initial a project",
		RunE:  gen,
	}
)

func init() {
	Cmd.Flags().StringVarP(&serviceType, "service type", "t", "mono", "specify the service type, supported values: [mono, micro]")
}
