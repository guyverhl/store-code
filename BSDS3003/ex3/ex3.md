# Mini-task 3 Auto-resizing Stack

## Class stack
In the beginning, the default capacity `dflt_cap` is input by the user to decide the length of the list. The size of the list should be `0` initially without an item.
```py
def __init__( self, dflt_cap ):
    self.dflt_cap = dflt_cap
    self._data = [None]*dflt_cap
    self._size = 0
```

## isEmpty()
A boolean `True` or `False` will be returned when is called.
```py
def isEmpty( self ):
    return self._size == 0
```

## __len__()
The number of items of the stack will be returned when is called.
```py
def __len__( self ):
    return self._size
```

## peek()
The top item of the stack will be returned. It will alert the user when the stack is empty. 
```py
def peek( self ):
    assert not self.isEmpty(), "Cannot peek at an empty stack"
    return self._data[self._size - 1]
```
## pop()
When the answer of the length divided by the size of the stack is `2` and the size is not equal to `the fixed number of the list`, it indicates more than half-spaces are not used. By calling the `_resize` function, the length of the stack is reduced by half. No need to call it when an item is in the stack. After that, the top of the item will return to `None` and reduce the `_size` by 1.
```py
def pop( self ):
    if int(len(self._data) / self._size) == 2 and not len(self._data) == self.dflt_cap:
      self._resize(int(len(self._data)/2))
      print("Stack's size is reduced by half")
    self._data[self._size - 1] = None
    self._size -= 1
    return self._data 
```

## push()
A shortage of place occurs when the size is `equal to` the length of the stack. By calling function `_resize`, it will double the list length. Then, the item will be pushed to the top of the stack by calculating the remainder of length and size. Next, the size of the stack will rise by 1.
```py
def push( self, item ):
    if self._size == len(self._data):
      self._resize(2*len(self._data))
      print("Stack's size is full and doubled")
    avail = self._size % len(self._data)
    self._data[avail] = item
    self._size += 1
    return self._data
```

## _resize()
This internal function will record the existing list and allocate it with a new capacity.
```py
def _resize(self, cap):
    old = self._data
    self._data = [None]*cap
    walk = 0
    for k in range(self._size):
        self._data[k] = old[walk]
        walk = (1 + walk) % len(old)
```

# Test result
Firstly, the default capacity is set as `3`. After pushing `item 1 - item 3`, the stack will be doubled when pushing `item 4` due to the lack of spaces. Then, the size will be reduced after poping `item 4` as more than half of the spaces are `None`, a list will 3 `None` is shown in the end of the result.
```py
s = Stack(3)
item_list = [f'item {str(i)}' for i in range(1,5)]

[print(s.push(i)) for i in item_list]
print('--- All item pushed ---')
while not s.isEmpty(): print(s.pop())
```
```py
['item 1', None, None]
['item 1', 'item 2', None]
['item 1', 'item 2', 'item 3']
Stack's size is full and doubled
['item 1', 'item 2', 'item 3', 'item 4', None, None]
--- All item pushed ---
['item 1', 'item 2', 'item 3', None, None, None]
Stack's size is reduced by half
['item 1', 'item 2', None]
['item 1', None, None]
[None, None, None]
```

# Appendix
```py
class Stack:

  def __init__( self, dflt_cap ):
    self.dflt_cap = dflt_cap
    self._data = [None]*dflt_cap
    self._size = 0

  def isEmpty( self ):
    return self._size == 0

  def __len__( self ):
    return self._size

  def peek( self ):
    assert not self.isEmpty(), "Cannot peek at an empty stack"
    return self._data[self._size - 1]

  def pop( self ):
    if int(len(self._data) / self._size) == 2 and not len(self._data) == self.dflt_cap:
      self._resize(int(len(self._data)/2))
      print("Stack's size is reduced by half")
    self._data[self._size - 1] = None
    self._size -= 1
    return self._data 

  def push( self, item ):
    if self._size == len(self._data):
      self._resize(2*len(self._data))
      print("Stack's size is full and doubled")
    avail = self._size % len(self._data)
    self._data[avail] = item
    self._size += 1
    return self._data

  def _resize(self, cap):
    old = self._data
    self._data = [None]*cap
    walk = 0
    for k in range(self._size):
        self._data[k] = old[walk]
        walk = (1 + walk) % len(old)

s = Stack(3)
item_list = [f'item {str(i)}' for i in range(1,5)]

[print(s.push(i)) for i in item_list]
print('--- All item pushed ---')
while not s.isEmpty(): print(s.pop())
```