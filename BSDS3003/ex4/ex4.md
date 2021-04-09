# Mini-task 4 Deletion in open addressing approach 
Deletions in open addressing hash tables have been seen as problematic because the operations could be wrong if only remove an item x by simply marking the slot that contains it as empty. Although the item is present in the table, the search for the item might easily fail. One solution for saving these lists in the correct state is to mark deleted slot
by special value `DELETED`, as if there was an element still
sitting there.

## Class Hash_Table
In the beginning, the size `size` is input by the user to decide the length of the table.
```py
def __init__(self, size):
    self.size = size
    self.table = [None for _ in range(self.size)]
```

## probing_sequence()
Quadratic Probing is used to form the probing sequence by selecting `c = 0.5` and `m = 2^p`.
```py
def probing_sequence(self, key):

    seq = [int( (key % self.size) + 0.5*i + 0.5*i*i ) % self.size for i in range(0, self.size)]

    return seq
```

## insert()
By calling the insert function, it will automatically generate the probing sequence utilizing the inserted key. After that, by looping this list, it will search for the first empty space or `DELETED` according to the order of the list. Then the inserted key and value will be added to the table. The loop will break after appending to the table and stop this function.
```py
def insert(self, key, value):
    for i in self.probing_sequence(key):
        if self.table[i] == None or self.table[i] == "D":
            self.table[i] = (key, value)
            break
```

## delete()
After inputting the delete function, it first will automatically generate the probing sequence utilizing the inserted key. By looping the sequence according to the order, it will check the key is whether equal to the key in the table. After confirming by the condition is true, the item will mark as `DELETE` and break the loop immediately.
```py
def delete(self, key):
    for i in self.probing_sequence(key):
        if self.table[i][0] == key:
            self.table[i] = "D"
            break
```
## wrong_delete()
By applying the wrong_delete function, it will loop the probing sequence and check the key is in the table or not similar to delete function. However, the item will mark as `None` back instead of the segment. Then it will break the loop immediately.
```py
def wrong_delete(self, key):
    for i in self.probing_sequence(key):
        if self.table[i][0] == key:
            self.table[i] = None
            break
```

## __repr__()
Present the table and change the segment to full writing.
```py
def __repr__(self):
    def showItem(item):
        return "" if item == None else "DELETED" if item == "D" else item
        
    return "\n".join("  {}: [{}]".format(key, showItem(item)) for (key, item) in enumerate(self.table))
```

# Test result
### 1.
Firstly, the table size is set as `8`. After inserting the first item with key = `6` and value = `0`, the probing sequence `[6, 7, 1, 4, 0, 5, 3, 2]` will be generated. With reference to the list, the key-value pair will add into `6` as it is empty.
```py
ht = Hash_Table(8)
ht.insert(6,0)
```
```py
0: []
1: []
2: []
3: []
4: []
5: []
6: [(6, 0)]
7: []
```

### 2.
Next, key `9` and `25` will insert into the table also. Since the probing sequence for both keys is `[1, 2, 4, 7, 3, 0, 6, 5]`, key `9` will be added into the table `1` according to the list. Then function `insert` check the first place of the table is not empty and query the second place for key `25`. Hence the key-value pair `25` is added into `2`.
```py
ht.insert(9, 'first in h′(k)=1')
ht.insert(25,'second in h′(k)=1')
```
```py
0: []
1: [(9, 'first in h′(k)=1')]
2: [(25, 'second in h′(k)=1')]
3: []
4: []
5: []
6: [(6, 0)]
7: []
```

### 3. delete
By calling the `delete` function, key-value pairs `9` and `25` are removed. The corresponding rows in the table will mark as `DELETE`.
```py
ht.delete(9)
ht.delete(25)
```
```py
0: []
1: [DELETED]
2: [DELETED]
3: []
4: []
5: []
6: [(6, 0)]
7: []
```

### 4. wrong_delete
To examine the `wrong_delete function`, key-value pairs `9` and `25` are added back to the table. It is still fine for removing the first key `9`. The row is marked as `None`.
```py
ht.insert(9, 'first in h′(k)=1')
ht.insert(25,'second in h′(k)=1')
ht.wrong_delete(9)
```
```py
0: []
1: []
2: [(25, 'second in h′(k)=1')]
3: []
4: []
5: []
6: [(6, 0)]
7: []
```

### 5. wrong_delete
Nevertheless, it cannot process when deleting the second key `25`. The function cannot identify whether the `NoneType` object is equal to the key in the table or not. Therefore, it is not a proper working of hashing by changing the item back to `None`.
```py
ht.wrong_delete(25)
```
```py
TypeError: 'NoneType' object is not subscriptable
```

# Appendix
```py
class Hash_Table:
    def __init__(self, size):
        self.size = size
        self.table = [None for _ in range(self.size)]

    def probing_sequence(self, key):
        seq = [int( (key % self.size) + 0.5*i + 0.5*i*i ) % self.size for i in range(0, self.size)]

        return seq

    def insert(self, key, value):
        for i in self.probing_sequence(key):
            if self.table[i] == None or self.table[i] == "D":
                self.table[i] = (key, value)
                break

    def delete(self, key):
        for i in self.probing_sequence(key):
            if self.table[i][0] == key:
                self.table[i] = "D"
                break

    def wrong_delete(self, key):
        for i in self.probing_sequence(key):
            if self.table[i][0] == key:
                self.table[i] = None
                break

    def __repr__(self):
        def showItem(item):
            return "" if item == None else "DELETED" if item == "D" else item
            
        return "\n".join("  {}: [{}]".format(key, showItem(item)) for (key, item) in enumerate(self.table))

ht = Hash_Table(8)

ht.insert(6,0)
ht.insert(9, 'first in h′(k)=1')
ht.insert(25,'second in h′(k)=1')
ht.delete(9)
ht.delete(25)

ht.insert(9, 'first in h′(k)=1')
ht.insert(25,'second in h′(k)=1')
ht.wrong_delete(9)
ht.wrong_delete(25)

print(ht)
```