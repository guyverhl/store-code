class Stack :
    def __init__( self ):
        self._theItems = list()
        
    def isEmpty( self ):
        return len( self ) == 0
    
    def __len__( self ):
        return len(self._theItems)
    
    def peek( self ):
        assert not self.isEmpty(), "Cannot peek at an empty stack"
        return self._theItems[-1]
        
    def pop( self ):
        assert not self.isEmpty(), "Cannot pop from an empty stack"
        return self._theItems.pop()
    
    def push( self, item ):
        self._theItems.append( item )

    def isExist( self , item ):
        if item == "/": return item in self._theItems
        else: return any(i in self._theItems for i in ("*", "\"", "\'"))

def isValidSource(srcFile):
    isSlashAfterStar = False
    s = Stack()
    for line in srcFile:
        for token in line:
            if token in "/\"\'{[(" and not s.isExist(token):
                s.push(token)
            elif token == "/" and s.isExist(token) and not isSlashAfterStar:
                s.pop()
                break
            elif token == "/" and s.isExist(token) and isSlashAfterStar:
                isSlashAfterStar = False
                s.pop()
            elif token == "*" and not s.isExist(token) and s.isExist("/"):
                s.push(token)
            elif token == "*" and s.isExist(token):
                s.pop()
                isSlashAfterStar = True
            elif token in "\"\'" and s.isExist(token):
                s.pop()
            elif token in ")]}" and not s.isExist(token):
                if s.isEmpty():
                    return False
                else:
                    left = s.pop()
                    if token == "}" and left != "{" or \
                        token == "]" and left != "[" or \
                        token == ")" and left != "(":
                        return False
            else:
                continue
            print(s._theItems)
    return s.isEmpty()

if __name__ == "__main__":
    with open("./test.cpp", "r") as srcFile:
        if isValidSource(srcFile):
            print("This is a valid C++ file.")
        else:
            print("This is an invalid C++ file, cause delimiters are not balanced.")
