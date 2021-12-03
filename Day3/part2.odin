package main

input := string(#load("input.txt"))

import "core:fmt"
import "core:unicode"

N :: 12

main :: proc() {
	bits_array: [dynamic][N]bool
	{
		pos := 0
		for pos < len(input) {
			bits: [N]bool
			for i in 0..<N {
				assert(input[pos] == '0' || input[pos] == '1')
				bits[i] = input[pos] != '0'
				pos += 1
			}
			append(&bits_array, bits)
			for pos < len(input) && unicode.is_white_space(cast(rune) input[pos]) {
				pos += 1
			}
		}
	}

	bits_array_oxygen: [dynamic][N]bool
	for bits in bits_array {
		append(&bits_array_oxygen, bits)
	}
	bit_index := 0
	for bit_index < N && len(bits_array_oxygen) > 1 {
		zeros := 0
		ones := 0
		for bits in bits_array_oxygen {
			if bits[bit_index] {
				ones += 1
			} else {
				zeros += 1
			}
		}
		is_one := ones >= zeros
		for i := len(bits_array_oxygen) - 1; i >= 0; i -= 1 {
			if is_one != bits_array_oxygen[i][bit_index] {
				ordered_remove(&bits_array_oxygen, i)
			}
		}
		bit_index += 1
	}

	oxygen_value := 0
	for bit in bits_array_oxygen[0] {
		oxygen_value *= 2
		oxygen_value += bit ? 1 : 0
	}

	bits_array_co2: [dynamic][N]bool
	for bits in bits_array {
		append(&bits_array_co2, bits)
	}
	bit_index = 0
	for bit_index < N && len(bits_array_co2) > 1 {
		zeros := 0
		ones := 0
		for bits in bits_array_co2 {
			if bits[bit_index] {
				ones += 1
			} else {
				zeros += 1
			}
		}
		is_one := ones < zeros
		for i := len(bits_array_co2) - 1; i >= 0; i -= 1 {
			if is_one != bits_array_co2[i][bit_index] {
				ordered_remove(&bits_array_co2, i)
			}
		}
		bit_index += 1
	}

	co2_value := 0
	for bit in bits_array_co2[0] {
		co2_value *= 2
		co2_value += bit ? 1 : 0
	}

	fmt.println(oxygen_value * co2_value)
}
