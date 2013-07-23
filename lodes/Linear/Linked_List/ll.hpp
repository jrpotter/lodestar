#ifndef LINKEDLIST_HPP
#define LINKEDLIST_HPP

template<class T>
class LinkedList
{
    public:
        LinkedList();
        ~LinkedList();

        void append(T);
        void remove(T);
        unsigned int size() const;

    private:
        struct node {
            T data;
            node *next;

            node(T);
            ~node();
        } *head, *tail;

        unsigned int count;
};


// Constructor
template<class T>
LinkedList::LinkedList()
    : head(nullptr)
    , tail(nullptr)
    , count(0) 
{}

template<class T>
LinkedList::~LinkedList()
{ if(head) delete head; }


// Modifiers
template<class T>
void LinkedList::append(T value)
{
    if(!tail){
        head = new node(value);
        tail = head;
    } else {
        tail -> next = new node(value);
        tail = tail -> next;
    }
}

template<class T>
void LinkedList::remove(T value)
{

}


// Getters
template<class T>
unsigned int LinkedList::size() const
{
    return count;
}


#endif /* LINKEDLIST_HPP */
