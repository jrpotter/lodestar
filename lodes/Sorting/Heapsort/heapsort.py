def heapify(values):
    """ 
        Note this process could be done inplace by replacing infinity in the 0th index
        with the last grabbed element. As an element is taken from values, another space
        is made available meaning an element could be entered into 1, 2 ...
    """
    # Heap starts at index 1
    heap = [float("inf")]

    # Add all values while maintaining sort/shape property
    for i in range(len(values)):
        heap.append(values[i])
        
        # Check parent is greater and if not swap
        j = i + 1
        while heap[j//2] < heap[j]:
            tmp = heap[j//2]
            heap[j//2] = heap[j]
            heap[j] = tmp

            j = j // 2 

    return heap[1:]

def heapsort(values):
    """ Takes in highest value of heap and re-heapifies """
    heap = []
    while len(values):
        tmp = heapify(values)
        heap.append(tmp[0])
        values = tmp[1:] 

    return reversed(heap)
