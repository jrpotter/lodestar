#ifndef LODESTAR_BUCKET_HPP
#define LODESTAR_BUCKET_HPP

#include <algorithm>

struct Node
{
    double value;
    struct Node *next;
    struct Node *prev;
};

struct Node* insert(struct Node *head, double value) 
{
    if(head == nullptr) {
        struct Node *tmp = new Node();
        tmp->value = value;
        tmp->next = nullptr;
        tmp->prev = nullptr;
        return tmp;
    } else {
        head->next = insert(head->next, value);
        head->next->prev = head;
        return head;
    }
}

void insertion_sort(struct Node *head)
{
    struct Node *entry = head;

    while(entry != nullptr) {
        
        double key = entry->value;
        struct Node *current = entry;
        struct Node *tmp = entry->prev;

        // Iterate backwards through list
        while(tmp != nullptr && tmp->value > key) {
            tmp->next->value = tmp->value;
            current = tmp;
            tmp = tmp->prev;
        }

        // Update Value
        current->value = key;
        entry = entry->next;
    }
}

void bucket_sort(double values[], int size)
{
    if(size == 0) return;

    // Get Max Value
    double k = values[0];
    for(int i = 1; i < size; i++) {
        k = std::max(k, values[i]);
    }

    // Create buckets
    struct Node **tmp = new Node*[10];
    std::fill(tmp, tmp + 10, nullptr);
    for(int i = 0; i < size; i++) {
        int index = 9 * values[i] / k;
        tmp[index] = insert(tmp[index], values[i]);
    }

    // Sort each bucket
    for(int i = 0; i < 10; i++) {
        insertion_sort(tmp[i]);
    }

    // Place values back into original array
    int index = 0;
    for(int i = 0; i < 10; i++) {
        struct Node *cur = tmp[i];
        while(cur != nullptr) {
            struct Node *next = cur->next;
            values[index++] = cur->value;
            delete cur; cur = next;
        }
    }

    // Further cleanup
    delete[] tmp;
}

#endif
