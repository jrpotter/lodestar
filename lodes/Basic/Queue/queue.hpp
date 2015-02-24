#ifndef LODESTAR_QUEUE_HPP
#define LODESTAR_QUEUE_HPP

#include <cstring>

template<typename T>
class Queue
{
    public:
        Queue();
        ~Queue();

        // Basic Operations
        void enqueue(T data);
        T dequeue() throw ();

    private:
        T *contents;
        int head, tail;
        int size, length;
};

template<typename T>
Queue<T>::Queue()
         :head(0)
         ,tail(0)
         ,size(0)
         ,length(20)
{
    contents = new T[length];
}

template<typename T>
Queue<T>::~Queue()
{
    delete[] contents;
}

template<typename T>
void Queue<T>::enqueue(T data)
{
    if(++size > length) {

        // Transfer wrapped content
        T *tmp = new T[length];
        for(int i = head, j = 0; i != tail; i = i + 1 % length) {
            tmp[j++] = contents[i];
        }

        // Copy Value
        delete[] contents;
        contents = new T[length * 2];
        memcpy(contents, tmp, length);
        delete[] tmp;
        tmp = nullptr;

        // Reset
        head = 0;
        tail = length;
        length = length * 2;

    }

    contents[tail++] = data;
}

template<typename T>
T Queue<T>::dequeue() throw ()
{
    if(size > 0) {
        size--;
        T tmp = contents[head];
        head = (head + 1) % length;
        return tmp;
    } else {
        throw 0;
    }
}

#endif
