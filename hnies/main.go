package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"gopkg.in/yaml.v2"
)

type Partner struct {
	City        string         `yaml:"city"`
	Id          string         `yaml:"id"`
	Aggregators AggregatorList `yaml:"aggregators"`
}

type PartnerList []Partner

func (l PartnerList) find(name string) (*Partner, bool) {
	for _, p := range l {
		if p.City == name {
			return &p, true
		}
	}

	return nil, false
}

type Aggregator struct {
	Name string `yaml:"name"`
	Id   string `yaml:"id"`
}

type AggregatorList []Aggregator

func (l AggregatorList) find(name string) (*Aggregator, bool) {
	for _, a := range l {
		if a.Name == name {
			return &a, true
		}
	}

	return nil, false
}

type Config struct {
	Export struct {
		Url      string      `yaml:"url"`
		Partners PartnerList `yaml:"partners"`
	} `yaml:"export"`
}

func (c Config) partner(partnerName string) (*Partner, error) {
	partner, ok := c.Export.Partners.find(partnerName)
	if !ok {
		return nil, fmt.Errorf("Partner '%s' not exists", partnerName)
	}

	return partner, nil
}

func (c Config) aggregator(partnerName string, aggName string) (*Aggregator, error) {
	partner, err := c.partner(partnerName)
	if err != nil {
		return nil, err
	}

	agg, ok := partner.Aggregators.find(aggName)
	if !ok {
		return nil, fmt.Errorf("Aggregator '%s' not exists in partner '%s'", aggName, partnerName)
	}

	return agg, nil
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

type Flags struct {
	configPath  string
	partnerName string
	aggName     string
}

func (f *Flags) ValidateConfigPath(path string) error {
	s, err := os.Stat(path)
	if err != nil {
		return err
	}

	if s.IsDir() {
		return fmt.Errorf("'%s' is a directory, not normal file", path)
	}

	return nil
}

func ParseFlags() (*Flags, error) {
	flags := &Flags{}
	flag.StringVar(&flags.configPath, "config", "./config.yml", "path to config file")
	flag.StringVar(&flags.partnerName, "partner", "", "--partner partner name")
	flag.StringVar(&flags.aggName, "agg", "", "--agg agg name")
	flag.Parse()

	if err := flags.ValidateConfigPath(flags.configPath); err != nil {
		return nil, err
	}

	return flags, nil
}

func main() {
	flags, err := ParseFlags()
	if err != nil {
		log.Fatal(err)
	}
	config := &Config{}

	if err = ReadYAML(flags.configPath, &config); err != nil {
		log.Fatal(err)
	}
	agg, err := config.aggregator(flags.partnerName, flags.aggName)

	if err != nil {
		fmt.Println(err)
	}
	_ = agg

	// for _, p := range config.Export.Partners {
	// 	fmt.Printf("%s:\n", p.City)
	// 	for _, a := range p.Aggregators {
	// 		fmt.Printf("\t%s: %s\n", a.Name, a.Id)
	// 	}
	// }
}
