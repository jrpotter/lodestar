#ifndef LINKEDLIST_HPP
#define LINKEDLIST_HPP

template<class T>
class node 
{
    private:
        T data;
        node *next;

    public:
        node(T d, node *n = nullptr)
            : data(d)
            , next(n)
        {}

        ~node()
        { if(next) delete next; }
};


#endif /* LINKEDLIST_HPP */
