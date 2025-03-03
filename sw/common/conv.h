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
    for (int i=0; i<dim; i++){
        for (int j=0; j<dim; j++){
            mat[i][j] = 1; //*(volatile uint32_t*)(base);
            //mat[i][0] = *(uint32_t*)(base);
        }
    }
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
