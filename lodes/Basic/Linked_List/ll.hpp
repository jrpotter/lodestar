#ifndef LODESTAR_LINKEDLIST_HPP
#define LODESTAR_LINKEDLIST_HPP

template<typename T>
struct Node
{
    T *data;
    Node *next;
    Node *prev;
    Node() { data = nullptr; }
    Node(T value) { data = new T(value); }
    ~Node() { if(data) delete data; }
};

template<typename T>
class LinkedList
{
    public:
        LinkedList();
        ~LinkedList();

        // Basic Functions
        void insert(T data);
        void remove(T data);
        struct Node<T>* search(T data);

    private:
        int length;
        Node<T> *nil;
};

/**
 * Constructor
 * Initializes nil value to point to itself, allowing
 * for circular doubly linked lists. It also serves as
 * both the head and tail of the list.
*/
template<typename T>
LinkedList<T>::LinkedList()
              :length(0)
{
    nil = new Node<T>();
    nil->next = nil;
    nil->prev = nil;
}

template<typename T>
LinkedList<T>::~LinkedList()
{
    struct Node<T> *tmp = nil->next;
    while(tmp != nil) {
        struct Node<T> *next = tmp->next;
        delete tmp; tmp = next;
    }

    delete nil;
}

/**
 * Insert new element at the front of the list.
 * This runs in O(1) time.
*/
template<typename T>
void LinkedList<T>::insert(T data)
{
    struct Node<T> *tmp = new Node<T>(data);
    tmp->next = nil->next;
    tmp->next->prev = tmp;
    nil->next = tmp;
    tmp->prev = nil;
}

/**
 * Remove element with given data value.
 * This runs in O(n) time.
*/
template<typename T>
void LinkedList<T>::remove(T data)
{
    struct Node<T> *tmp = search(data);
    if(tmp != nullptr) {
        tmp->prev->next = tmp->next;
        tmp->next->prev = tmp->prev;
        delete tmp;
    }
}

template<typename T>
struct Node<T>* LinkedList<T>::search(T data)
{
    struct Node<T> *tmp = nil->next;
    while(tmp != nil) {
        if(*tmp->data == data) {
            return tmp;
        }

        tmp = tmp->next;
    }

    return nullptr;
}


#endif /* LINKEDLIST_HPP */
