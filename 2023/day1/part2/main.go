package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	file, err := os.Open("../input")
	if err != nil {
		panic("failed to open input")
	}
	defer file.Close()

	needles := map[string]string{
		"1":     "1",
		"2":     "2",
		"3":     "3",
		"4":     "4",
		"5":     "5",
		"6":     "6",
		"7":     "7",
		"8":     "8",
		"9":     "9",
		"one":   "1",
		"two":   "2",
		"three": "3",
		"four":  "4",
		"five":  "5",
		"six":   "6",
		"seven": "7",
		"eight": "8",
		"nine":  "9",
	}

	total := 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		text := scanner.Text()

		numbers := map[int]string{}
		for needle, value := range needles {
			for _, position := range getAllIndexes(text, needle) {
				numbers[position] = value
			}
		}

		positions := keys(numbers)
		min, max := minMax(positions)
		num := numbers[min] + numbers[max]
		val, err := strconv.Atoi(num)
		if err == nil {
			total += val
		}
	}

	fmt.Printf("Total: %d\n", total) // not 54533
}

func getAllIndexes(str string, needle string) []int {
	results := []int{}
	start := 0
	for start < len(str) {
		position := strings.Index(str[start:], needle)
		if position != -1 {
			results = append(results, start+position)
			start += position
		}
		start++
	}

	return results
}

func keys(numbersMap map[int]string) []int {
	results := make([]int, len(numbersMap))
	i := 0
	for k := range numbersMap {
		results[i] = k
		i++
	}

	return results
}

func minMax(array []int) (int, int) {
	min := array[0]
	max := array[0]
	for _, value := range array {
		if max < value {
			max = value
		}
		if min > value {
			min = value
		}
	}

	return min, max
}
