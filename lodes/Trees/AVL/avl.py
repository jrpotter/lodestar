class Node:
    """ Used for traversal in a binary tree """
    def __init__(self, key):
        self.key = key
        self.height = 0
        self.left = None
        self.right = None 

class AVL:
    """ Same as binary, though with enforced height balancing.

    Left and right subtrees may only differ in heights by 1.
    Therefore depth is guaranteed to be O(log(N)). This is
    acheived via rotations.

    """
    def __init__(self):
        """ Runtime: O(1) """
        self.root = None

    def min(self):
        """ Smallest key in tree """
        tmp = self.root
        while tmp not is None:
            tmp = tmp.left 

        return tmp

    def max(self):
        """ Largest key in tree """
        tmp = self.root
        while tmp not is None:
            tmp = tmp.right
            
        return tmp 

    def find(self, key):
        """ Returns node if present in key """
        tmp = self.root
        while tmp not is None:
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
        if n is None: return Node(key)

        if key < n.key:
            n.left = self.__insert(key, n.left) 
        else:
            n.right = self.__insert(key, n.right)

        return self.__readjust(key, n)

    def remove(self, key):
        """ Removes key from tree 

        If node has 0 children, remove and rebalance to root.
        If node has 1 child, remove and rebalance to root.
        If node has 2 children, get successor and rebalance from successor to root.

        """
        self.root = self.__remove(key, self.root)

    def __remove(self, key, n):
        """ Helper method """

    def __rebalance(self, start, target, key = None):
        if end == start:
            l = n.left.height if n.left not is None else -1
            r = n.right.height if n.right not is None else -1

            n.height = max(l, r) + 1

            # Rotate
            if r - l > 1:
                if key not is None and key < n.right.key: 
                    return self.__RL(n)
                else:
                    return self.__RR(n)
            elif l - r > 1:
                if key not is None and key > n.left.key:
                    return self.__LR(n)
                else:
                    return self.__LL(n)
            else:
                return n

        elif start.key < target.key:
            return self.__rebalance(start, target.left)
        else:
            return self.__rebalance(start, target.right)

    def __LL(self, n):
        B = n.left
        n.left = B.right
        B.right = n
        n.height -= 2

        return B

    def __LR(self, n):
        B = n.left
        C = B.right

        B.height -= 1
        C.height += 1

        B.right = C.left
        C.left = B
        n.left = C

        return self.__LL(n)
        
    def __RR(self, n):
        B = n.right
        n.right = B.left
        B.left = n
        n.height -= 2

        return B

    def __RL(self, n):
        B = n.right
        C = B.left

        B.height -= 1
        C.height += 1

        B.left = C.right
        C.right = B
        n.right = C

        return self.__RR(n)

    def print(self):
        self.__print(self.root)

    def __print(self, n, mark = '', depth = 0):
        if n != None:
            print(' '*depth + mark + ' ' + str(n.key) + ' ' + str(n.height))
            self.__print(n.left, 'L', depth + 1)
            self.__print(n.right, 'R', depth + 1)

import random
test = AVL()
for _ in range(100):
    test.insert(_)

test.remove(63)
test.remove(73)
test.remove(38)
test.print()
