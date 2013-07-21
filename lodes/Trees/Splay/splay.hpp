#ifndef SPLAY_HPP
#define SPLAY_HPP

template<class K, class V>
class Splay
{
    // Used for traversing tree
    struct node
    {
        K key;
        V value;
        node *left, right*;
        
        node(K, V);
        ~node();
    };

    public:
        Splay();
        ~Splay();

        V* find(K);
        void remove(K);
        void insert(K, V);

    private:
        node *root;
        unsigned int size;

        // Rotation Methods
        node *zig(node*);
        node *zag(node*);

        node *zigZig(node*);
        node *zigZag(node*);

        node *zagZag(node*);
        node *zagZig(node*);
};


// Node Definitions

template<class K, class V>
Splay<K, V>::node::node(T v)
    : value(v)
    , left(nullptr)
    , right(nullptr)
{}

template<class K, class V>
Splay<K, V>::node::~node()
{
    if(left) delete left;
    if(right) delete right;
}


// Splay Definitions

template<class K, class V>
Splay<K, V>::Splay()
    : size(0)
    , root(nullptr)
{}

template<class K, class V>
Splay<K, V>::~Splay()
{ if(root) delete root; }


// Splay Public Methods

template<class K, class V>
V* Splay<K, V>::find(K key)
{
    for(node *tmp = root; tmp;){
        if(tmp -> key == key){
            return true;
        }

        if(tmp -> key < key) tmp = tmp -> left;
        else tmp = tmp -> right;
    }

    return nullptr;
}

template<class K, class V>
void Splay<K, V>::insert(T key)
{

}

template<class K, class V>
void Splay<K, V>::remove(T key)
{

}


// Splay Rotation Methods

// Expects the root
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zig(node *r)
{
    node *B = r -> left;
    r -> left = B -> right;
    B -> right = r;

    return B;
}

// Expects the root
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zag(node *r)
{
    node *B = r -> right;
    r -> right = B -> left;
    B -> left = r;

    return B;
}

// Expects the grandparent
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zigZig(node *g)
{
    node *p = g -> left;
    node *n = p -> left;    

    g -> left = p -> right;
    p -> right = g;
    p -> left = n -> right;
    n -> right = p;

    return n;
}

// Expects the grandparent
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zigZag(node *g)
{
    node *p = g -> left;
    node *n = p -> right;

    p -> right = n -> left;
    g -> left = n -> right;
    n -> left = p;
    n -> right = g;

    return n;
}

// Expects the grandparent
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zagZag(node *g)
{
    node *p = g -> right;
    node *n = p -> right;    

    g -> right = p -> left;
    p -> left = g;
    p -> right = n -> left;
    n -> left = p;

    return n;
}

// Expects the grandparent
template<class K, class V>
class Splay<K, V>::node*
Splay<K, V>::zagZig(node *g)
{
    node *p = g -> right;
    node *n = g -> left;

    g -> right = n -> left;
    p -> left = n -> right;
    n -> right = p;
    n -> left = g;

    return n;
}


#endif /* SPLAY_HPP */
