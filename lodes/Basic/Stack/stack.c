#ifndef STACK_C
#define STACK_C

#include <stdlib.h>

struct stack {
    int size;
    int limit;
    int *values;
};

void push(int value, struct stack* s)
{
    int limit = s -> limit;
    int size = s -> size++;

    // Copy stack over
    if(size == limit) {
        int *tmp = (int*)malloc(limit * 2 * sizeof(int));
        for(int i = 0; i < limit; i++) tmp[i] = s -> values[i];

        free(s -> values);
        s -> limit *= 2;
        s -> values = tmp;
    }

    s -> values[size] = value;
}

int pop(struct stack* s)
{
    return s -> values[--s -> size];
}

int peek(struct stack* s)
{
    return s -> values[s -> size];
}

#endif
