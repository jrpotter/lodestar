#ifndef LL_C
#define LL_C

#include <stdlib.h>

struct node {
    struct node* next;
    int value;
};

struct node* insert(struct node* tail, int value)
{
    struct node* n = (struct node*)malloc(sizeof(struct node));
    n -> value = value;
    tail -> next = n;
    n -> next = NULL;

    return n;
}

void delete(struct node* head, int value)
{
    struct node** pp = &head;
    struct node* entry = head;

    while(entry) {
        if(entry -> value == value) {
            *pp = entry -> next;
            free(entry);
            return;
        }

        pp = &entry -> next;
        entry = entry -> next;
    }
}

int contains(struct node* head, int value)
{
    struct node* entry = head;
    while(entry) {
        if(entry -> value == value)
            return 1;
    }

    return 0;
}

#endif
