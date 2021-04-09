# Mini-task 2
By looping every token in .cpp file, selected token will push into or drop from stack.
```py
s = Stack()
for line in srcFile:
    for token in line:
```

### Class stack
Function `isExist` is added into class stack to determine selected token exist or not.
```py
def isExist( self , item ):
        if item == "/": return item in self._theItems
        else: return any(i in self._theItems for i in ("*", "\"", "\'"))
```

## Push stack
When token equal to any one in `/\"\'{[(` and not appear in stack, the token will push to the stack.
```py
if token in "/\"\'{[(" and not s.isExist(token):
    s.push(token)
```

## / handling
If token equals to `/` and `/` is already added in the stack, check for boolean `isSlashAfterStar` to decide skip to the next row or not.

### isSlashAfterStar == false
Since `//` will comment the whole line, after drop the token from the stack, it will break the inner for loop to read starting from next line. 
```py
elif token == "/" and s.isExist(token) and not isSlashAfterStar:
    s.pop()
    break
```
### isSlashAfterStar == true
Since there may still have valid command after `*/`, it will drop the existed `/` in the stack and keep looping in the same line. isSlashAfterStar will return back to false to prepare next `/*`.
```py
elif token == "/" and s.isExist(token) and isSlashAfterStar:
    isSlashAfterStar = False
    s.pop()
```

## * handling
In order to not include single * as mulitple, `*` will add into stack only when `*` is not in stack but `/` exist.
```py
elif token == "*" and not s.isExist(token) and s.isExist("/"):
    s.push(token)
```

When token is `*` and `*` is already added in the stack, it will remove `*` in the stack and change boolean `isSlashAfterStar` to `true` in order to prepare face next token `/`.
```py
elif token == "*" and s.isExist(token):
    s.pop()
    isSlashAfterStar = True
```

## " & ' handling
When token is `"` or `'` and token is already added in the stack, it will remove the same token in the stack.
```py
elif token in "\"\'" and s.isExist(token):
    s.pop()
```

## Drop stack
When token is any in `)]}` and there is no `*`, `'` or `"` in the stack at that moment, the current token will be drop.
```py
elif token in ")]}" and not s.isExist(token):
    if s.isEmpty():
        return False
    else:
        left = s.pop()
```

# Test result
## Valid C++ file
Since the stack will return empty, it is a valid C++ file from this example.
```py
This is a valid C++ file.
```

Example:
```cpp
#include <iostream>

using namespace std;

int main()

{
    // test 1 single (
    /* test 2 {
    [ test 3 }
    */ cout << "Hello World:)" << "\n";
    cout << '[' << endl;
    int i = 3 * 4;
}
```

## Invalid C++ file
Since the stack is not empty in the end, it is an invalid C++ file from this example.
```py
This is an invalid C++ file, cause delimiters are not balanced.
```

Example:
```cpp
#include <iostream>

using namespace std;

int main()
[
{
    // test 1 single (
    /* test 2 {
    [ test 3 }
    */ cout) << "Hello World:)" << "\n";
    cout << '[' << endl; }
    int i = 3 * 4;
}
```

# Appendix
```py
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
    return s.isEmpty()

if __name__ == "__main__":
    with open("./test.cpp", "r") as srcFile:
        if isValidSource(srcFile):
            print("This is a valid C++ file.")
        else:
            print("This is an invalid C++ file, cause delimiters are not balanced.")
```