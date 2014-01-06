#include <stdlib.h>

struct node
{
    int value;
    struct node* next;
};

static struct node* new(int value)
{
    struct node* tmp = (struct node*)malloc(sizeof(struct node));
    tmp -> value = value;
    tmp -> next = NULL;

    return tmp;
}

static void insert(struct node** head, int value)
{
    if(!*head) *head = new(value);
    else {
        struct node* tail = NULL;

        while(*head) {
            struct node* entry = *head;

            if(value < entry -> value) {
                *head = new(value);
                (*head) -> next = entry;
                return;
            }

            tail = *head;
            head = &entry -> next;
        }

        tail -> next = new(value);
    }
}

void bucket_sort(int* values, int length, int entries, int cap)
{
    struct node** buckets = (struct node**)calloc(entries, sizeof(struct node*));

    for(int i = 0; i < length; i++) {
        int pos = (double)values[i] / cap * (entries - 1);
        insert(&buckets[pos], values[i]);
    }

    for(int i = 0, j = 0; i < entries; i++) {
        struct node* entry = buckets[i];

        while(entry) {
            struct node* tmp = entry -> next;
            values[j++] = entry -> value;
            free(entry);
            entry = tmp;
        }
    }

    free(buckets);
}
