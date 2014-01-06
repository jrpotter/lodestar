#ifndef HEAPSORT_C
#define HEAPSORT_C

void heapify(int* values, int size, int index)
{
    int l = (index << 1) + 1;
    int r = l + 1;

    int max = index;
    if(l < size && values[l] > values[max]) max = l;
    if(r < size && values[r] > values[max]) max = r;

    if(max != index) {
        int tmp = values[index];
        values[index] = values[max];
        values[max] = tmp;

        heapify(values, size, max);
    }
}

void heapsort(int* values, int size)
{
    // Heapify
    for(int i = size / 2 - 1; i >= 0; i--) {
        heapify(values, size, i);
    }

    // Sort
    int len = size;
    while(len--) {
        int tmp = values[0];
        values[0] = values[len];
        values[len] = tmp;

        heapify(values, len, 0);
    }
}

#endif
