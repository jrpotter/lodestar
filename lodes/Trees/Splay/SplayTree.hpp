#ifndef SPLAY_HPP
#define SPLAY_HPP

template<class K, class V>
class SplayTree
{
    public:
        SplayTree();
        ~SplayTree();

        void remove(K);
        void insert(K, V);

        V* min() const;
        V* max() const;
        V* find(K) const;
        unsigned int size() const;

    private:
        struct node {
            K key; 
            V value;
            node *left, *right;

            node(K, V);
            ~node();
        } *root;

        unsigned int count;

        // Helper Methods
        node* remove(K, node*);
        node* insert(K, V, node*);
        node* find(K, node*) const;

        // Rotation Methods
        node* zig(node*);
        node* zag(node*);

        node* zigZig(node*);
        node* zigZag(node*);

        node* zagZag(node*);
        node* zagZig(node*);
};


// Node Constructors
template<class K, class V>
SplayTree<K, V>::node::node(T v)
    : value(v)
    , left(nullptr)
    , right(nullptr)
{}

template<class K, class V>
SplayTree<K, V>::node::~node()
{
    if(left) delete left;
    if(right) delete right;
}


// Constructor
template<class K, class V>
SplayTree<K, V>::SplayTree()
    : size(0)
    , root(nullptr)
{}

template<class K, class V>
SplayTree<K, V>::~SplayTree()
{ if(root) delete root; }


// Modifiers
template<class K, class V>
void SplayTree<K, V>::remove(K key)
{

}

template<class K, class V>
void SplayTree<K, V>::remove(K key, node *n)
{

}

template<class K, class V>
void SplayTree<K, V>::insert(K key, V value)
{

}

template<class K, class V>
void SplayTree<K, V>::insert(K key, V value, node *n)
{

}


// SplayTree Rotation Methods
template<class K, class V>
class SplayTree<K, V>::node*
SplayTree<K, V>::zig(node *r)
{
    node *B = r -> left;
    r -> left = B -> right;
    B -> right = r;

    return B;
}

// Expects the root
template<class K, class V>
class SplayTree<K, V>::node*
SplayTree<K, V>::zag(node *r)
{
    node *B = r -> right;
    r -> right = B -> left;
    B -> left = r;

    return B;
}

// Expects the grandparent
template<class K, class V>
class SplayTree<K, V>::node*
SplayTree<K, V>::zigZig(node *g)
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
class SplayTree<K, V>::node*
SplayTree<K, V>::zigZag(node *g)
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
class SplayTree<K, V>::node*
SplayTree<K, V>::zagZag(node *g)
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
class SplayTree<K, V>::node*
SplayTree<K, V>::zagZig(node *g)
{
    node *p = g -> right;
    node *n = g -> left;

    g -> right = n -> left;
    p -> left = n -> right;
    n -> right = p;
    n -> left = g;

    return n;
}


// Getters
template<class K, class V>
V* BinaryTree<K, V>::min() const
{
    if(!root) return nullptr;

    node *tmp = root;
    while(tmp -> left){
        tmp = tmp -> left;
    }

    return &tmp -> value;
}

template<class K, class V>
V* BinaryTree<K, V>::max() const
{
    if(!root) return nullptr;

    node *tmp = root;
    while(tmp -> right){
        tmp = tmp -> right;
    }

    return &tmp -> value;
}

template<class K, class V>
V* BinaryTree<K, V>::find(K key) const
{
    node *tmp = find(key, root);

    if(tmp) return &tmp -> value;
    else return nullptr;    
}

template<class K, class V>
class BinaryTree<K, V>::node*
BinaryTree<K, V>::find(K key, node *n) const
{
    if(!n) return nullptr;

    node *tmp = n;
    if(tmp -> key == key) return tmp;

    if(tmp -> key < key) return find(key, n -> left);
    else if(tmp -> key > key) return find(key, n -> right);
}

template<class K, class V>
unsigned int BinaryTree<K, V>::size() const
{
    return count;
}

#endif /* SPLAY_HPP */
