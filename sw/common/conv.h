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
    fprint("size: %x\n", size);
    for (int offset=0; offset != size; offset += 4){
        volatile uint32_t word_line = *(uint32_t*)(base + offset);
        fprint("Word: %x\n", word_line);
        uint8_t bytes[4]; // extract big-endian bytes
        bytes[0] =   ((word_line>>24)&0xff);             // move byte 3 to byte 0
        bytes[2] =   ((word_line<<8)&0xff0000)    >> 16; // move byte 1 to byte 2
        bytes[1] =   ((word_line>>8)&0xff00)      >> 8;  // move byte 2 to byte 1
        bytes[3] =   ((word_line<<24)&0xff000000) >> 24; // byte 0 to byte 3
        for (int pos = 0; pos < size; pos++){

            int x = pos / dim;
            int y = pos % dim;

            fprint("bytes: %x, pos: %x\n", bytes[pos], pos);
            mat[x][y] = bytes[pos];//big_endian << pos*8;
        }
        
    }
    //for (int i=0; i<dim; i++){
    //    uint32_t data_line = *(uint32_t*)(base + 4*i);
    //    for (int j=0; j<dim; j++){
    //        mat[i][j] = *(uint32_t*)(base + 4*j + i);
    //        //mat[i][0] = *(uint32_t*)(base);
    //    }
    //}
}

void print_matrix (uint8_t dim, uint8_t mat[dim][dim]){
    fprint("[");
    for (int i=0; i<dim; i++){
        fprint("[");
        for (int j=0; j<dim; j++){
            fprint("%x", mat[i][j]);
            if (j != dim-1) fprint(", ");
        }
        if (i != dim-1) fprint("]\n ");
        else fprint("]]\n ");
    }
    //fprint("]\n");

}

#endif //__CONV_H__
