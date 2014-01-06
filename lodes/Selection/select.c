#ifndef SELECT_C
#define SELECT_C

#include <stdlib.h>

static void swap(int* values, int i, int j)
{
    int tmp = values[i];
    values[i] = values[j];
    values[j] = tmp;
}

static int find(int* values, int l, int r, int n)
{
    int j = l;
    for(int i = l; i < r; i++) {
        if(values[i] < values[r]) {
            swap(values, i, j++);
        }
    }

    swap(values, j, r);

    if(j == n) return values[j];
    else if(n < j) return find(values, l, j - 1, n);
    else return find(values, j + 1, r, n);
}

int select(int* values, int length, int n)
{
    int* copy = (int*)malloc(sizeof(int) * length);
    for(int i = 0; i < length; i++) copy[i] = values[i];

    int tmp = find(copy, 0, length - 1, n - 1);
    free(copy);

    return tmp;
}

#endif
