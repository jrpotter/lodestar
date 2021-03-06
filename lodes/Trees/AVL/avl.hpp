#ifndef AVL_HPP
#define AVL_HPP

template<class K, class V>
class AVL : public M_Tree<K, V>
{
    public:
        AVL();
        ~AVL();

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
            unsigned int height;

            node(K, V);
            ~node();
        } *root;

        unsigned int count;

        // Helper Methods
        node* remove(K, node*);
        node* insert(K, V, node*);
        node* find(K, node*) const;

        // Rotations
        node* LL(node*);
        node* LR(node*);
        node* RR(node*);
        node* RL(node*);
};


// Node Constructors
template<class K, class V>
BinaryTree<K, V>::node::node(K k, V v)
    : key(k)
    , value(v)
    , left(nullptr)
    , right(nullptr)
    , height(0)
{}

template<class K, class V>
BinaryTree<K, V>::node::~node()
{
    if(left) delete left;
    if(right) delete right;
}


// Constructor
template<class K, class V>
AVL<K, V>::AVL()
    : root(nullptr)
    , count(0)
{}

template<class K, class V>
AVL<K, V>::~AVL()
{ if(root) delete root; }


// Modifiers
template<class K, class V>
void AVL<K, V>::remove(K key)
{
    count -= 1;
    root = remove(key, root);
}

template<class K, class V>
void AVL<K, V>::remove(K key, node *n)
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
    }

    if(n -> key < key){
        n -> left = remove(key, n -> left);
    } else {
        n -> right = remove(key, n -> right);
    }

    // Rebalancing
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
void AVL<K, V>::insert(K key, V val)
{
    count += 1;  
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

#endif /* AVL_HPP */
