/*
 * Name: conv.h
 * Contributor(S):
 *    - Antti Nurmi <antti.nurmi@tuni.fi>
 * Description:
 *    - helper functions conv_ex test
 */
#ifndef __CONV_H__
#define __CONV_H__

void init_matrix (uint8_t dim, uint8_t mat[dim][dim], uint32_t base){
    uint8_t size = dim*dim;
    int idx = 0;
    for (int offset=0; offset != size; offset += 4){
        volatile uint32_t word_line = *(uint32_t*)(base + offset);
        uint8_t bytes[4]; // extract big-endian bytes
        bytes[0] =   ((word_line>>24)&0xff);             // move byte 3 to byte 0
        bytes[2] =   ((word_line<<8)&0xff0000)    >> 16; // move byte 1 to byte 2
        bytes[1] =   ((word_line>>8)&0xff00)      >> 8;  // move byte 2 to byte 1
        bytes[3] =   ((word_line<<24)&0xff000000) >> 24; // byte 0 to byte 3
        if (dim == 2) {
            for (int pos = 0; pos < size; pos++){
                int x = pos / dim;
                int y = pos % dim;
                mat[x][y] = bytes[pos];
                idx++;
            }
        }
        else if (dim == 4) {
            for (int pos = 0; pos < dim; pos++){
                int x = offset / 4;
                int y = pos % dim;
                mat[x][y] = bytes[pos];
                idx++;
            }
        }
    }
}

void print_matrix (uint8_t dim, uint32_t mat[dim][dim]){
    fprint("[");
    for (int i=0; i<dim; i++){
        fprint("[");
        for (int j=0; j<dim; j++){
            fprint("%x", mat[i][j]);
            if (j != dim-1) fprint(", ");
        }
        if (i != dim-1) fprint("]\n ");
        else fprint("]]\n\r ");
    }
}

// Print matrix in flat form for automated checking
void print_matrix_flat (uint8_t dim, uint32_t mat[dim][dim]){
    for (int i=0; i<dim; i++){
        for (int j=0; j<dim; j++){
            fprint("%x\n", mat[i][j]);
        }
    }
}

void get_submatrix (uint8_t res_dim, uint8_t src_dim, int pos_x, int pos_y,
    uint8_t src_mat[src_dim][src_dim], uint8_t res_mat[res_dim][res_dim]){
    for (int i = 0; i<res_dim; i++){
        for (int j = 0; j<res_dim; j++){
            res_mat[i][j] = src_mat[i+pos_x][j+pos_y];
        }
    }
}

void matmul (uint8_t dim, uint8_t mat_a[dim][dim], 
    uint8_t mat_b[dim][dim], uint32_t mat_res[dim][dim]){
        for (int i = 0; i < 2; i++){
            for (int j = 0; j < 2; j++){
                for (int k = 0; k < 2; k++){
                    mat_res[i][j] += (uint16_t) mat_a[i][k] * (uint16_t) mat_b[k][j];
                }
            }
        }
    }

uint32_t accumulate(uint8_t dim, uint32_t mat[dim][dim]){
    uint32_t acc = 0;
    for (int i = 0; i < dim; i++){
        for (int j = 0; j < dim; j++){
            acc += mat[i][j];
        }
    }
    return acc;
}

#endif //__CONV_H__
