#!/usr/bin/python3

import numpy as np
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--weight")
parser.add_argument("--input")
parser.add_argument("--output")
args = parser.parse_args()

# return input file contents as np array
def read_file(input):

    with open(input, 'r') as file:
        tmp_mat = []
        tmp_lst = []
        lines = file.readlines()
        last = lines[-1]

        for line in lines:
            if len(line.split()) != 0:
                tmp_lst.append(line.split())
                if line is last:
                    tmp_mat.append(tmp_lst)
            else:
                tmp_mat.append(tmp_lst)
                tmp_lst = []

        # list comprehension to cast everything into int base 10
        tmp_mat = [[[int (z, 16) for z in y] for y in x] for x in tmp_mat]

    return np.asarray(tmp_mat, dtype=np.uint8)

# write computation result into .hex file with 32-bit allignment
# check printed results against .hex file for mapping
def write_file(file, data, dim, elem_size):
    with open(file, 'w') as file:

        data = np.asarray([[[f'{z:0{elem_size}x}' for z in y] for y in x] for x in data])

        for i in range(4):
            allign = 0
            for y in range(dim):
                for x in range(dim):
                    file.write(data[i][y][x])
                    if allign == (8/elem_size)-1:
                        file.write("\n")
                        allign  = 0
                    else:
                        allign += 1



# return subwindow of specified size, position from "input"
def get_window(input, size, x, y):
    tmp = []
    for z in range(size):
        tmp.append(input[z+y][x:size+x])
    return np.array(tmp)

# accumulate all values of matrix into one scalar value
def accumulate(array):
    acc = 0
    for x in array:
        for y in x:
            acc += y
    return acc

def main():

    if len(sys.argv) != 7:
        print("Invalid args!")
        raise ValueError

    data    = read_file(args.input)
    weights = read_file(args.weight)

    print("Convolution Data:\n", data)
    print("Convolution Weights:\n", weights)

    MULT_PER_CONV = 3*3
    NUM_OPS       = 4
    WINDOW_SQUARE = 2

    # TODO: clean magic numbers
    all_conv = np.zeros([NUM_OPS, 3,3], np.uint32)

    for i in range(NUM_OPS):

        conv_res = np.zeros([3, 3], dtype=np.uint32)

        for y in range(3):
            for x in range(3):
                window = get_window(data[i], WINDOW_SQUARE, x,y)
                res = np.matmul(window, weights[i], dtype=np.uint16)
                conv_res[x][y] = accumulate(res)


        all_conv[i] = conv_res

    print("Convolution results:\n", all_conv)
    write_file(args.output, all_conv, 3, 8)

    # input files in simulator-friendly format
    write_file("reference/gen/input_formated.hex", data, 4, 2)
    write_file("reference/gen/weight_formated.hex", weights, 2, 2)

if __name__ == "__main__":
    main()