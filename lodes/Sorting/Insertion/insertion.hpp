#ifndef LODESTAR_INSERTION_HPP
#define LODESTAR_INSERTION_HPP

template<typename T>
void insertion(T values[], int size) 
{
    for(int i = 1; i < size; i++) {
        int j = i - 1;
        int key = values[i];
        while(j >= 0 && values[j] > key) {
            values[j+1] = values[j];
            j -= 1;
        }
        values[j+1] = key;
    }
}

#endif
