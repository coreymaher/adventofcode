package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
)

func main() {
	file, err := os.Open("../input")
	if err != nil {
		panic("failed to open input")
	}
	defer file.Close()

	total := 0
	scanner := bufio.NewScanner(file)
	regex := regexp.MustCompile(`\d`)
	for scanner.Scan() {
		text := scanner.Text()
		matches := regex.FindAllString(text, -1)

		if len(matches) > 0 {
			num := matches[0] + matches[len(matches)-1]
			val, err := strconv.Atoi(num)
			if err == nil {
				total += val
			}
		}
	}

	fmt.Printf("Total: %d\n", total)
}
