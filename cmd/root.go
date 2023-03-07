package cmd

import (
	"os"

	"github.com/huangsc/knife/cmd/project"
	"github.com/spf13/cobra"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "knife",
	Short: "A tool to make develop faster",
	Long: `quickly to generate:
	1. project
	2. api
	3. rpc
	4. model`,
	// Run: func(cmd *cobra.Command, args []string) { },
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		os.Exit(1)
	}
}

func init() {
	rootCmd.AddCommand(project.Cmd)

	rootCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}


