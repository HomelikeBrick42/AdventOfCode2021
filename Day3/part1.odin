package main

input := string(#load("input.txt"))

import "core:fmt"
import "core:unicode"

N :: 12

main :: proc() {
	bits_count: int
	on_bits_count: [N]int
	pos := 0
	for pos < len(input) {
		for i in 0..<N {
			if input[pos] == '1' {
				on_bits_count[i] += 1
			}
			pos += 1
		}
		for pos < len(input) && unicode.is_white_space(cast(rune) input[pos]) {
			pos += 1
		}
		bits_count += 1
	}
	gamma := 0
	epsilon := 0
	for i in 0..<N {
		if on_bits_count[i] > bits_count / 2 {
			gamma *= 2
			gamma += 1
			epsilon *= 2
			epsilon += 0
		} else {
			gamma *= 2
			gamma += 0
			epsilon *= 2
			epsilon += 1
		}
	}
	fmt.printf("Gamma: {}\n", gamma)
	fmt.printf("Epsilon: {}\n", epsilon)
	fmt.printf("Gamma * Epsilon: {}\n", gamma * epsilon)
}
