#ifndef AVL_HPP
#define AVL_HPP

#include "M_Tree.hpp"

template<class K, class V>
class AVL : public M_Tree<K, V>
{
    public:
        AVL():M_Tree(2){}

        void remove(K);
        void insert(K, V);

    private:
        // Rotations
        node* LL(node*);
        node* LR(node*);
        node* RR(node*);
        node* RL(node*);

        // Helpers
        node* insert(T, node*);
};


// AVL Public Methods
template<class K, class V>
void AVL<K, V>::insert(K key, V val)
{
    size += 1;  
    root = insert(key, val, root);
}

template<class K, class V>
class AVL<K, V>::node*
AVL<K, V>::insert(K key, V val, node *n)
{
    if(!n) return new node(key);

    // Insert until leaf is hit
    if(key < n -> value) n -> left = insert(key, n -> left);
    else if(key > n -> value) n -> right = insert(key, n -> right);

    // Adjust heights
    int l = n -> left ? n -> left -> height : -1;
    int r = n -> right ? n -> right -> height : -1;
    
    n -> height = 1 + (l > r) ? l : r;

    // Rotate
    if(r - l > 1){
        if(key < n -> right -> value) return RL(n);
        else return RR(n);
    } else if(l - r > 1){
        if(key > n -> left -> value) return LR(n);
        else return LL(n);
    }

    return n;
}

template<class K, class V>
void AVL<K, V>::remove(K key)
{

}


// AVL Rotation Methods
template<class K, class V>
class AVL<K, V>::node*
AVL<K, V>::LL(node *n)
{
    node *B = n -> left;

    n -> left = B -> right;
    B -> right = n;

    n -> height -= 1;

    return B;
}

template<class K, class V>
class AVL<K, V>::node*
AVL<K, V>::LR(node *n)
{
    node *B = n -> left;
    node *C = B -> right;

    B -> right = C -> left;
    C -> left = B;
    n -> left = C;

    B -> height -= 1;
    C -> height += 1;

    return LL(n);
}

template<class K, class V>
class AVL<K, V>::node*
AVL<K, V>::RR(node *n)
{
    node *B = n -> right;
    
    n -> right = B -> left;
    B -> left = n;

    n -> height -= 1;

    return B;
}

template<class K, class V>
class AVL<K, V>::node*
AVL<K, V>::RL(node *n)
{
    node *B = n -> right;
    node *C = B -> left;

    B -> left = C -> right;
    C -> right = B;
    n -> right = C;

    B -> height -= 1;
    C -> height += 1;

    return RR(n);
}


#endif /* AVL_HPP */
