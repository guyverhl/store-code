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
