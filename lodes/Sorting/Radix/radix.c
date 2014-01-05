#include <stdlib.h>
#include <math.h>

struct entry
{
    int value;
    int digit;
};

void radix(int* values, int length, int d)
{
    for(int i = 0; i < d; i++) {

        // Copy
        struct entry* B = (struct entry*)malloc(sizeof(struct entry) * length);
        for(int j = 0; j < length; j++) {
            B[j].digit = values[j] / (int)pow(10, i) % 10;
            B[j].value = values[j];
        }

        // Find Max
        int k = -1;
        for(int j = 0; j < length; j++) {
            if(B[j].digit > k) k = B[j].digit;
        }

        // Create Storage
        int* C = (int*)calloc(k + 1, sizeof(int));
        for(int j = 0; j < length; j++) C[B[j].digit] += 1;
        for(int j = 0, total = 0; j < k + 1; j++) {
            int tmp = C[j];
            C[j] = total;
            total += tmp;
        }
        
        // Sort
        for(int j = 0; j < length; j++) values[C[B[j].digit]++] = B[j].value;

        // Cleanup
        free(B);
        free(C);
    }
}
