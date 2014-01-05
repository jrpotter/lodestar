#include <stdlib.h>

int* counting_sort(int* values, int length)
{
    // Find Max Value
    int k = -1;
    for(int i = 0; i < length; i++) {
        if(k < values[i]) k = values[i];
    }

    // Build Up Storage
    int* C = (int*)calloc(k + 1, sizeof(int));
    for(int i = 0; i < length; i++) C[values[i]] += 1; 
    for(int i = 1; i < k + 1; i++) C[i] += C[i-1];

    // Create Storage
    int* B = (int*)malloc(sizeof(int) * length);
    for(int i = 0; i < length; i++) B[--C[values[i]]] = values[i];
    free(C);

    return B;
}
