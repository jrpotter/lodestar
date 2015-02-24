#ifndef LODESTAR_COUNTING_HPP
#define LODESTAR_COUNTING_HPP

#include <cstring>
#include <algorithm>

void counting_sort(int values[], int size)
{
    if(size == 0) return;

    // Get the largest value in the array
    int k = values[0];
    for(int i = 1; i < size; i++) {
        k = std::max(k, values[i]);
    }

    // Temporary array to hold counts and sorted result
    int *counts = new int[k+1];
    int *sorted = new int[size];
   
    // Obtain counts
    std::fill(counts, counts+k, 0);
    for(int i = 0; i < size; i++) {
        counts[values[i]]++;
    }

    // Cumulative Count
    for(int i = 1; i < k + 1; i++) {
        counts[i] += counts[i-1];
    }

    // Sort Values
    for(int i = 0; i < size; i++) {
        counts[values[i]]--;
        sorted[counts[values[i]]] = values[i];
    }

    memcpy(values, sorted, size * sizeof(int));

    // Cleanup
    delete[] counts;
    delete[] sorted;
}


#endif
