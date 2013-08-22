def insertion_sort(values):
    for i in range(len(values)):
        tmp = values[i]
        for j in range(i-1, -1, -1):
            if values[j] <= tmp:
                values[j+1] = tmp
                break
            values[j+1] = values[j]
        else:
            values[0] = tmp

    return values
                
