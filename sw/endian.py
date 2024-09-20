"""/*
    * Project: Edu4chip
    * Description: 
    *   - python script for reversing hex endianess
    * Contributors:
    *   - Jarkko Passi
        - Arto Oinonen (arto.oinonen@tuni.fi)
    * Notes:
    *   - currently unneeded
    */"""
	
import sys
from argparse import ArgumentParser

def reverse_endianess_32( word ):
	out_word = word[6:8] + word[4:6] + word[2:4] + word[0:2]
	return out_word

def main():

	input_file = sys.argv[1]
	output_file = sys.argv[2]

	source = open(input_file, "r")
	output = open(output_file, "w")

	for line in source:
		output.write( reverse_endianess_32(line) )
		output.write( '\n' )

	source.close()
	output.close()

if __name__ == "__main__":
	main()
