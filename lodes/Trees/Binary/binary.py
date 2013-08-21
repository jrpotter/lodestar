class Node:
    """ Used for traversal in a binary tree """
    def __init__(self, key):
        self.key = key
        self.left = None
        self.right = None 

class Binary:
    """ Simple Binary tree implementation.

    Sum of all nodes in a tree is known as the internal path length.
    Running time operations of all methods (except constructor)
    is O(d), which is the depth of the node in question.

    """
    def __init__(self):
        """ Runtime: O(1) """
        self.root = None

    def min(self):
        """ Smallest key in tree """
        tmp = self.root
        while tmp != None:
            tmp = tmp.left 

        return tmp

    def max(self):
        """ Largest key in tree """
        tmp = self.root
        while tmp != None:
            tmp = tmp.right
            
        return tmp 

    def find(self, key):
        """ Returns node if present in key """
        tmp = self.root
        while tmp != None:
            if tmp.key == key:
                return tmp
            elif key < tmp.key: 
                tmp = tmp.left
            else:
                tmp = tmp.right

        return tmp
        
    def insert(self, key):
        """ Inserts key into tree """
        self.root = self.__insert(key, self.root)

    def __insert(self, key, n):
        """ Helper method """
        if n == None: return Node(key)

        if key < n.key:
            n.left = self.__insert(key, n.left) 
        else:
            n.right = self.__insert(key, n.right)

        return n

    def remove(self, key):
        """ Removes key from tree """
        self.root = self.__remove(key, self.root)

    def __remove(self, key, n):
        """ Helper method """
        if n != None:
            if n.key == key:
                if n.left != None and n.right != None:

                    # Find successor
                    succ = n.right
                    succ_parent = n
                    while succ.left != None:
                        succ_parent = succ
                        succ = succ.left

                    # Right child has height one
                    if succ_parent == n:
                        n.key = n.right.key
                        n.right = None
                    else:
                        n.key = succ.key
                        succ_parent.left = self.__remove(succ.key, succ)
                        
                elif n.left != None: 
                    return n.left
                elif n.right != None: 
                    return n.right
                else: 
                    return None
                            
            elif key < n.key:
                n.left = self.__remove(key, n.left)
            else:
                n.right = self.__remove(key, n.right) 

        return n
