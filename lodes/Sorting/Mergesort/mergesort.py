def merge(left, right):
    """ Takes in two sublists and joins them into one sorted list. """
    merged = []
    i, j = 0, 0

    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            merged.append(left[i])
            i += 1
        else:
            merged.append(right[j])
            j += 1

    return merged + left[i:] + right[j:]

def mergesort(to_merge):

    # Sorted at this point
    if len(to_merge) <= 1: return to_merge

    # Recursively sort smaller lists
    middle = int(len(to_merge) / 2)
    left = mergesort(to_merge[:middle])
    right = mergesort(to_merge[middle:])

    return merge(left, right)
