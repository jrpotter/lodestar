#ifndef LODESTAR_RADIX_HPP
#define LODESTAR_RADIX_HPP

#include <cmath>
#include <cstring>
#include <algorithm>

void radix_sort(int values[], int size, int d)
{
    int *counts = new int[10];
    int *sorted = new int[size];
    int *digits = new int[size];

    for(int current = 0; current < d; current++) {

        std::fill(counts, counts + 10, 0);
        std::fill(digits, digits + size, 0);

        // Start at least significant value and sort by it
        int div = pow(10, current);
        for(int i = 0; i < size; i++) {
            digits[i] = (values[i] / div) % 10;
        }

        // Keep Counts
        for(int i = 0; i < size; i++) {
            counts[digits[i]]++;
        }

        // Cumulative Count
        for(int i = 1; i < 10; i++) {
            counts[i] += counts[i-1];
        }

        // Ordering
        for(int i = 0; i < size; i++) {
            counts[digits[i]]--;
            sorted[counts[digits[i]]] = values[i];
        }

        memcpy(values, sorted, size * sizeof(int));
    }

    // Cleanup
    delete[] counts; counts = nullptr;
    delete[] sorted; sorted = nullptr;
    delete[] digits; digits = nullptr;
}

#endif
