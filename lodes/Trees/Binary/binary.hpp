#ifndef BINARY_TREE_HPP
#define BINARY_TREE_HPP

#include "M_Tree.hpp"

// Basic Binary Tree
template<class K, class V>
class BinaryTree : public M_Tree<K, V>
{
    public:
        BinaryTree():M_Tree(2){}

        void remove(K);
        void insert(K, V);

    private:
};


// Binary Tree Definitions
template<class K, class V>
void BinaryTree::remove(K key)
{

}

template<class K, class V>
void BinaryTree::insert(K key, V val)
{
    node *tmp = root;

}


#endif /* BINARY_TREE_HPP */
