package main

import "core:fmt"
import "core:strconv"
import "core:unicode"

input := string(#load("input.txt"))

main :: proc() {
	sub_horizontal := 0
	sub_depth := 0
	sub_aim := 0
	pos := 0
	for pos < len(input) {
		command_start_pos := pos
		for !unicode.is_white_space(cast(rune) input[pos]) {
			pos += 1
		}
		command := input[command_start_pos:pos]
		for unicode.is_white_space(cast(rune) input[pos]) {
			pos += 1
		}
		amount_start_pos := pos
		for !unicode.is_white_space(cast(rune) input[pos]) {
			pos += 1
		}
		amount, ok := strconv.parse_int(input[amount_start_pos:pos], 10)
		assert(ok)
		switch command {
			case "forward": {
				sub_horizontal += amount
				sub_depth += sub_aim * amount
			}

			case "up": {
				sub_aim -= amount
			}

			case "down": {
				sub_aim += amount
			}

			case: {
				assert(false, "invalid input")
			}
		}
		for pos < len(input) && unicode.is_white_space(cast(rune) input[pos]) {
			pos += 1
		}
	}
	fmt.printf("Horizontal: {}\n", sub_horizontal)
	fmt.printf("Depth: {}\n", sub_depth)
	fmt.printf("Horizontal * Depth: {}\n", sub_horizontal * sub_depth)
}
