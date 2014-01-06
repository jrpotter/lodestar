#ifndef COUNTING_C
#define COUNTING_C

#include <stdlib.h>
#include <stdio.h>

// Note this version is not stable
// Check radix sort for a stable variant
void counting_sort(int* values, int length)
{
    // Copy
    int* B = (int*)malloc(sizeof(int) * length);
    for(int i = 0; i < length; i++) B[i] = values[i];

    // Find Max Value
    int k = -1;
    for(int i = 0; i < length; i++) {
        if(k < B[i]) k = B[i];
    }

    // Build Up Storage
    int* C = (int*)calloc(k + 1, sizeof(int));
    for(int i = 0; i < length; i++) C[values[i]] += 1; 
    for(int i = 0; i < k + 1; i++) C[i] += C[i-1];

    // Sort
    for(int i = 0; i < length; i++) values[--C[B[i]]] = B[i];

    free(B);
    free(C);
}

int main()
{
    int values[10] = {5, 3, 4, 4, 5, 2, 9, 8, 5, 6};
    counting_sort(values, 10);
    for(int i = 0; i < 10; i++) printf("%d\n", values[i]);
    return 0;
}

#endif
