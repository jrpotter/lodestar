#ifndef LODESTAR_QUICKSORT_HPP
#define LODESTAR_QUICKSORT_HPP

#include <ctime>
#include <cstdlib>
#include <iostream>
using namespace std;

template<typename T>
void swap(T values[], int i, int j)
{
    T tmp = values[i];
    values[i] = values[j];    
    values[j] = tmp;
}

template<typename T>
int partition(T values[], int left, int right)
{
    int pivot = left;
    
    // Switch with last element
    swap<T>(values, pivot, right);

    // Begin partitioning
    int index = left;
    for(int i = left; i < right; i++) {
        if(values[i] < values[right]) {
            swap<T>(values, i, index++);
        }
    }

    // Now ordered around pivot
    swap<T>(values, index, right);
    return index;
}

template<typename T>
void quicksort(T values[], int left, int right)
{
    if(left < right) {
        int p = partition<T>(values, left, right);
        quicksort<T>(values, left, p - 1);
        quicksort<T>(values, p + 1, right);
    }
}

template<typename T>
void quicksort(T values[], int size)
{
    if(size > 0) {
        srand(time(0));
        quicksort<T>(values, 0, size - 1);
    }
}

#endif
