void insertion(int *values, int length)
{
    for(int i = 1; i < length; i++) {
        for(int j = i - 1; j >= 0; j--) {
            if(values[j] > values[j+1]) {
                int tmp = values[j+1];
                values[j+1] = values[j];
                values[j] = tmp;
            }
        }
    }
};
