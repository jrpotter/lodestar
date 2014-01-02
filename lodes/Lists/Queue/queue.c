#ifndef QUEUE_C
#define QUEUE_C

#include <stdlib.h>

#define FACTOR 2

struct queue {
    int *values;
    int head, tail;
    int size, limit;
};

void enqueue(int value, struct queue *q)
{
    int size = q -> size++;
    int limit = q -> limit;
    
    // Copy queue to larger one
    if(size == limit) {
        int *tmp = (int*)malloc(FACTOR * limit * sizeof(int));
        
        for(int j = 0; j < limit; j++) {
            int i = (q -> head + j) % limit;
            tmp[j] = q -> values[i];
        }

        // Reset queue
        free(q -> values);
        q -> head = 0;
        q -> values = tmp;
        q -> limit *= FACTOR;
        q -> tail = limit;
    }

    // Add element
    q -> values[q -> tail++ % q -> limit] = value;
}

int dequeue(struct queue *q)
{
    // Correct Values
    q -> size -= 1;
    int limit = q -> limit;
    int head = q -> head++ % limit;

    // Return front
    return q -> values[head];
}

#endif
