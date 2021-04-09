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

ht.insert(9, 'first in h(1)')
ht.insert(25,'second in h(1)')
# ht.wrong_delete(9)
# ht.wrong_delete(25)

print(ht)

