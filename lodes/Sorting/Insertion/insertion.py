def insertion(values):
    for i in range(1, len(values)):
        for j in range(i-1, -1, -1):
            if values[j+1] < values[j]:
                tmp = values[j]
                values[j] = values[j+1]
                values[j+1] = tmp

    return values
