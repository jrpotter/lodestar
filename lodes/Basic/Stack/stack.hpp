#ifndef LODESTAR_STACK_HPP
#define LODESTAR_STACK_HPP

#include <cstring>

template<typename T>
class Stack
{
    public:
        Stack();
        ~Stack();

        void push(T data);
        T pop() throw ();

    private:
        T *contents;
        int size, length;
};

template<typename T>
Stack<T>::Stack()
         :size(0)
         ,length(20)
{
    contents = new T[length];
}

template<typename T>
Stack<T>::~Stack()
{
    delete[] contents;
}

template<typename T>
void Stack<T>::push(T data)
{
    if(++size > length) {

        T *tmp = new T[length];
        memcpy(tmp, contents, length * sizeof(T));        
        
        delete[] contents;
        contents = new T[length * 2];
        memcpy(contents, tmp, length * sizeof(T));

        length = length * 2;

    }

    contents[size-1] = data;
}

template<typename T>
T Stack<T>::pop() throw ()
{
    if(size > 0) {
        return contents[--size];
    } else {
        throw 0;
    }
}

#endif
