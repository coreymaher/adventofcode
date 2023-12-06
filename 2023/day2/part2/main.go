package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("../input")
	if err != nil {
		panic("failed to open input")
	}
	defer file.Close()

	total := 0

	scanner := bufio.NewScanner(file)
	lineRegex := regexp.MustCompile(`^Game (\d+): (.+)$`)
	turnRegex := regexp.MustCompile(`(\d+) (\w+)`)

	for scanner.Scan() {
		line := scanner.Text()
		lineMatches := lineRegex.FindStringSubmatch(line)

		if len(lineMatches) != 3 {
			continue
		}

		max := map[string]int{
			"red":   0,
			"green": 0,
			"blue":  0,
		}

		turns := strings.Split(lineMatches[2], ";")
		for _, turn := range turns {
			current := map[string]int{
				"red":   0,
				"green": 0,
				"blue":  0,
			}

			drawMatches := turnRegex.FindAllStringSubmatch(turn, -1)
			for _, draw := range drawMatches {
				if len(draw) != 3 {
					continue
				}

				valStr := draw[1]
				color := draw[2]

				val, err := strconv.Atoi(valStr)
				if err != nil {
					continue
				}

				if current[color] < val {
					current[color] = val
				}
			}

			for color := range current {
				if max[color] < current[color] {
					max[color] = current[color]
				}
			}
		}

		power := 1
		for color := range max {
			if max[color] > 0 {
				power *= max[color]
			}
		}

		total += power
	}

	fmt.Printf("Total: %d\n", total)
}
