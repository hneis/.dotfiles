package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"gopkg.in/yaml.v2"
)

type Config struct {
	Export struct {
		Url      string `yaml:"url"`
		Partners []struct {
			City        string `yaml:"city"`
			Id          string `yaml:"id"`
			Aggregators []struct {
				Name string `yaml:"name"`
				Id   string `yaml:"id"`
			} `yaml:"aggregators"`
		} `yaml:"partners"`
	} `yaml:"export"`
}

func ReadYAML(configPath string, configPointer interface{}) error {
	file, err := os.Open(configPath)
	if err != nil {
		return err
	}
	defer file.Close()

	d := yaml.NewDecoder(file)

	if err := d.Decode(configPointer); err != nil {
		return err
	}

	return nil
}

func ValidateConfigPath(path string) error {
	s, err := os.Stat(path)
	if err != nil {
		return err
	}

	if s.IsDir() {
		return fmt.Errorf("'%s' is a directory, not normal file", path)
	}

	return nil
}

func ParseFlags() (string, error) {
	var configPath string

	flag.StringVar(&configPath, "config", "./config.yml", "path to config file")
	flag.Parse()

	if err := ValidateConfigPath(configPath); err != nil {
		return "", err
	}

	return configPath, nil
}

func main() {
	cfgPath, err := ParseFlags()
	if err != nil {
		log.Fatal(err)
	}
	config := &Config{}

	if err = ReadYAML(cfgPath, &config); err != nil {
		log.Fatal(err)
	}

	for _, p := range config.Export.Partners {
		fmt.Printf("%s:\n", p.City)
		for _, a := range p.Aggregators {
			fmt.Printf("\t%s: %s\n", a.Name, a.Id)
		}
	}
}
