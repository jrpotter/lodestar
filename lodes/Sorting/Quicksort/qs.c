#ifndef QS_C
#define QS_C

void swap(int* values, int i, int j)
{
    int tmp = values[i];
    values[i] = values[j];
    values[j] = tmp;
}

void quicksort(int* values, int l, int r)
{
    if(l >= r) return;

    int j = l;
    for(int i = l; i < r; i++) {
        if(values[i] < values[r]) {
            swap(values, i, j++);
        }
    }

    swap(values, j, r);

    quicksort(values, l, j - 1);
    quicksort(values, j + 1, r);
}

#endif
