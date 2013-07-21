#ifndef M_TREE_HPP
#define M_TREE_HPP

#include <vector>
#include <utility>


// Used to construct/manipulate tree
template<class K, class V>
struct node
{
    node(K, V);
    ~node();

    node(node&&);
    node(const node&);
    node& operator = (node&&);
    node& operator = (const node&);

    K *key;
    V *value;
    unsigned int height;
    std::vector<node*> nodes;
};


// Node definitions
template<class K, class V>
node<K, V>::node(K k, V v)
    : key(k)
    , value(v)
    , height(0)
{}

template<class K, class V>
node<K, V>::~node()
{
    if(key) delete key;
    if(value) delete value;
    for(auto &n : nodes) delete n;
}

template<class K, class V>
node<K, V>::node(node &&n)
    : key(n.key)
    , value(n.value)
    , nodes(n.nodes)
    , height(n.height)
{
    n.nodes.clear();
    n.key = nullptr;
    n.value = nullptr;
    n.height = 0;
} 

template<class K, class V>
node<K, V>::node(const node &n)
    , height(n.height)
{
    key = n.key ? new K(*n.key) : nullptr;
    value = n.value ? new V(*n.key) : nullptr;

    foreach(auto &n : nodes){
        nodes.emplace_back(new node(*n));
    }
}

template<class K, class V>
node<K, V>& node<K, V>::operator = (node &&n)
{
    if(this != &n){
        key = n.key;
        value = n.value;
        nodes = n.nodes;
        height = n.height;

        n.nodes.clear();
        n.key = nullptr;
        n.value = nullptr;
        n.height = 0;
    }

    return *this;
}

template<class K, class V>
node<K, V>& node<K, V>::operator = (const node &n)
{
    if(this != &n){
        key = n.key ? new K(*n.key) : nullptr;
        value = n.value ? new V(*n.value) : nullptr;
        height = n.height;

        foreach(auto &n : nodes){
            nodes.emplace_back(new node(*n));
        }
    }

    return *this;
}


// Tree with M branches
template<class K, class V>
class M_Tree
{
    public:
        M_Tree();
        virtual ~M_Tree();

        M_Tree(M_Tree&&);
        M_Tree(const M_Tree&);
        M_Tree& operator = (M_Tree&&);
        M_Tree& operator = (const M_Tree&);

        V* find(K) const;
        void printTree() const;
        unsigned int size() const;

        void remove(K) = 0;
        void insert(K, V) = 0;

    protected:
        node *root;
        unsigned int count;

        node *successor() const;
        node *predecessor() const;

    private:
        void printTree(node*, unsigned int) const;
};


// M_Tree Definitions
template<class K, class V>
M_Tree<K, V>::M_Tree(unsigned int b)
    : root(nullptr)
    , count(0)
{}

template<class K, class V>
M_Tree<K, V>::~M_Tree()
{ if(root) delete root; }

template<class K, class V>
M_Tree<K, V>::M_Tree(M_Tree &&m)
    : root(m.root)
    , count(m.count)
{}

template<class K, class V>
M_Tree<K, V>::M_Tree(const M_Tree &m)
    : count(m.count)
{
    root = m.root ? new node(*m.root) : nullptr;
}

template<class K, class V>
M_Tree<K, V>& M_Tree<K, V>::operator = (M_Tree &&m)
{
    if(this != &m){
        root = m.root;
        count = m.count;

        m.root = nullptr;
        m.count = 0;
    }

    return *this;
}

template<class K, class V>
M_Tree<K, V>& M_Tree<K, V>::operator = (const M_Tree &m)
{
    if(this != &m){
        root = m.root ? new node(*m.root) : nullptr;
        count = m.count;
    }

    return *this;
}


// M_Tree Public Methods
template<class K, class V>
V* M_Tree<K, V>::find(T key) const
{
    for(node *tmp = root; tmp;){
        if(key == tmp -> key) {
            return tmp -> value;
        }

        if(key < tmp -> value) tmp = tmp -> left;
        else tmp = tmp -> right;
    }

    return nullptr;
}

template<class K, class V>
void M_Tree<K, V>::printTree() const
{
    printTree(root, 0);    
}

template<class K, class V>
unsigned int M_Tree<K, V>::size() const
{
    return count;
}


// M_Tree Helper Methods
template<class T, class V>
node* M_Tree<K, V>::successor(node *n) const
{
    if(!n) return nullptr;

    node *tmp = n -> right;
    while(tmp -> left) tmp = n -> nodes.back();
    
    return tmp;
}

template<class T, class V>
node* M_Tree<K, V>::predecessor(node *n) const
{
    if(!n) return nullptr;

    node *tmp = n -> left;
    while(tmp -> right) tmp = n -> nodes.front();

    return tmp;
}

template<class K, class V>
void M_Tree<K, V>::printTree(node *r, unsigned int d) const
{
    if(!r) return;

    std::cout << std::string(d, ' ');
    std::cout  << r -> value << std::endl;
    for(auto &n : r -> nodes) printTree(n, d + 1);
}

#endif /* M_TREE_HPP */
