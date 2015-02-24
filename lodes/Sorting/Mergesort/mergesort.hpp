#ifndef LODESTAR_MERGESORT_HPP
#define LODESTAR_MERGESORT_HPP

#include <cstring>
#include <iostream>
using namespace std;

template<typename T>
void mergesort(T values[], T tmp[], int left, int right)
{
    if(right - left > 0) {

        int middle = (right + left) / 2;
        mergesort(values, tmp, left, middle);
        mergesort(values, tmp, middle + 1, right);

        // Merge most of arrays
        int index = 0;
        int i = left, j = middle + 1;
        while(i <= middle && j <= right) {
            if(values[i] <= values[j]) {
                tmp[index++] = values[i++];
            } else {
                tmp[index++] = values[j++];
            }
        }

        // Finish merging
        for(; i <= middle; i++) tmp[index++] = values[i];
        for(; j <= right; j++) tmp[index++] = values[j];

        // Copy over
        memcpy(values+left, tmp, (right-left+1) * sizeof(T));
    }
}

template<typename T>
void mergesort(T values[], int size)
{
    if(size > 0) {
        T *tmp = new T[size];
        mergesort(values, tmp, 0, size - 1);
        delete[] tmp; tmp = nullptr;
    }
}

#endif
