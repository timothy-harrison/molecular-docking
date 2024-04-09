package main

import (
	"log"
	"os"
	"slices"
	"fmt"
)



func main() {
	var variants []string
  var acids []string = []string{"A", "R", "N", "D", "C", "Q", "E", "G", "H", "I", "L", "K", "M", "F", "P", "S", "T", "W", "Y", "V"}
	var argLength int = len(os.Args[1:])

	if argLength == 0 {
		log.Fatal("Not enough arguments are given")
	}
	if argLength >= 2 {
		log.Fatal("There are too many arguments")
	}

	for i, letter := range os.Args[1] {
		if !slices.Contains(acids, string(letter)) {
			log.Fatalf("Amino acid sequence contains a non-amino asid %s at position %d", string(letter), i)
		}
		for _, acid := range acids {
			if string(letter) != string(acid) {
				variants = append(variants, fmt.Sprintf("%sA%d%s;\n", string(letter), (i+1), string(acid)))
			}
		}
	}
	for _, alteration := range variants {
		fmt.Print(alteration)
	}
}
