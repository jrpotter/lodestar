#ifndef BINARY_TREE_HPP
#define BINARY_TREE_HPP

template<class K, class V>
class BinaryTree
{
    public:
        BinaryTree();
        ~BinaryTree();

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
};


// Node Constructors
template<class K, class V>
BinaryTree<K, V>::node::node(K k, V v)
    : key(k)
    , value(v)
    , left(nullptr)
    , right(nullptr)
{}

template<class K, class V>
BinaryTree<K, V>::node::~node()
{
    if(left) delete left;
    if(right) delete right;
}


// Constructors
template<class K, class V>
BinaryTree<K, V>::BinaryTree()
    : root(nullptr)
    , count(0)
{} 

template<class K, class V>
BinaryTree<K, V>::~BinaryTree()
{ if(root) delete root; }


// Modifiers
template<class K, class V>
void BinaryTree<K, V>::remove(K key)
{
    count -= 1;
    root = remove(key, root);
}

template<class K, class V>
class BinaryTree<K, V>::node* 
BinaryTree<K, V>::remove(K key, node *n)
{
    if(!n) return nullptr;

    if(n -> key == key){

        // Has Children
        if(n -> left && n -> right){
            node *parent = n;
            node *tmp = n -> right;

            // Find Successor
            while(tmp -> left){
                parent = tmp;
                tmp = tmp -> left;
            }

            // Height of 1
            if(parent == n){
                delete n;
                return tmp;
            }

            // Replace
            n -> key = tmp -> key;
            n -> value = tmp -> value;

            if(tmp -> right){
                tmp -> key = tmp -> right -> key;
                tmp -> value = tmp -> right -> value;
                
                delete tmp -> right;
                tmp -> right = nullptr;
            } else {
                delete tmp;
                parent -> left = nullptr;
            }
        } 
        
        // Left Child 
        else if(n -> left){
            node *tmp = n -> left;
            delete n;
            return tmp;
        } 

        // Right Child
        else if(n -> right){
            node *tmp = n -> right;
            delete n;
            return tmp;
        } 
        
        // No Children
        else {
            delete n;
            return nullptr;
        }
        
    } else if(n -> key < key){
        n -> left = remove(key, n -> left);
    } else {
        n -> right = remove(key, n -> right);
    }

    return n;
}

template<class K, class V>
void BinaryTree<K, V>::insert(K key, V value)
{
    count += 1;
    root = insert(key, value, root);
}

template<class K, class V>
class BinaryTree<K, V>::node*
BinaryTree<K, V>::insert(K key, V value, node *n)
{
    if(!n) return new node(key, value);

    if(n -> key < key){
        n -> left = insert(key, value, n -> left);
    } else {
        n -> right = insert(key, value, n -> right);
    }

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

#endif /* BINARY_TREE_HPP */
