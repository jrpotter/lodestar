#ifndef LODESTAR_HEAPSORT_HPP
#define LODESTAR_HEAPSORT_HPP

template<typename T>
void heapify(T values[], int index, int size)
{
    int left = (index << 2) + 1;
    int right = left + 1;
    int largest = index;

    if(left < size && values[left] > values[largest]) {
        largest = left;    
    }

    if(right < size && values[right] > values[largest]) {
        largest = right;
    }

    // Need to swap and heapify again
    if(largest != index) {
        T tmp = values[index];
        values[index] = values[largest];
        values[largest] = tmp;
        heapify<T>(values, largest, size);
    }
}

template<typename T>
void buildMaxHeap(T values[], int size)
{
    for(int i = size / 2; i >= 0; i--) {
        heapify<T>(values, i, size);
    } 
}

template<typename T>
void heapsort(T values[], int size)
{
    buildMaxHeap<T>(values, size);
    for(int i = size - 1; i > 0; i--) {
        T tmp = values[i];
        values[i] = values[0];
        values[0] = tmp;
        heapify<T>(values, 0, i);
    }
}

#endif
