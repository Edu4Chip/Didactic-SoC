/*
 * Name: conv.h
 * Contributor(S):
 *    - Antti Nurmi <antti.nurmi@tuni.fi>
 * Description:
 *    - helper functions conv_ex test
 */
#ifndef __CONV_H__
#define __CONV_H__

//#include <stdlib.h>

void init_matrix (uint8_t dimension, uint8_t mat[dimension][dimension], uint32_t base){
    //mat[0][0] = 1;
    //return matrix;
    /*
    for (int i=0; i<dimension; i++){
        for (int j=0; i<dimension; j++){
            mat[i][j] = *(uint32_t*)(base);
        }
    }
    */
    for (int i=0; i<dimension; i++){
        for (int j=0; i<dimension; j++){
            mat[i][j] = *(uint32_t*)(base);
            //mat[i][0] = *(uint32_t*)(base);
        }
    }
}

#endif //__CONV_H__
