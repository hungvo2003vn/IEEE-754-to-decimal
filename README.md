# MIPS IEEE 754 to Decimal Conversion

This MIPS assembly program converts IEEE 754 floating-point numbers to their decimal representation. The program reads three floating-point numbers, processes them to convert to a decimal format, and outputs the result to both the console and a file named `SOTHUC.TXT`.

## Program Overview

### Data Segment
- **tenfile**: Name of the output file (`SOTHUC.TXT`).
- **dulieu1, dulieu2, dulieu3**: Variables to store the three floating-point numbers.
- **base_10**: Multiplier used to convert the floating-point numbers to their decimal equivalent.
- **str_tc, str_loi, str_endl**: Strings used for success, error messages, and newline character respectively.
- **str_dulieu1, str_dulieu2, str_dulieu3**: Buffers to hold the converted string representations of the numbers.

### Code Segment
- **main**: The main entry point of the program, which generates random floating-point numbers, converts them, and outputs the result.
- **Random_generator**: Generates random floating-point numbers.
- **Convert_toString**: Converts a floating-point number to its decimal string representation.
- **File_output**: Handles the writing of the converted numbers to `SOTHUC.TXT`.
- **Xuat_out**: Outputs the converted numbers to the console.
- **Kthuc**: Terminates the program.

### Helper Functions
- **Convert_toString**: Converts a floating-point number from IEEE 754 format to a string that represents its decimal value. Handles edge cases where the number has fewer than 8 digits after the decimal point.

## Example Output

### Console Output
```plaintext
So 1: 0.87115672
So 2: 0.98419240
So 3: 0.96514776

-- program is finished running --
