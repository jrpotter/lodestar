def quicksort(values):
    if len(values) <= 1: return values

    pivot = values[0]
    larger = list(filter(lambda x: x >= pivot, values[1:]))
    smaller = list(filter(lambda x: x < pivot, values[1:]))

    return quicksort(smaller) + [pivot] + quicksort(larger)
