class Circle: 
  
    def __init__(self, *args): 
  
        if len(args) == 0:
            self.x = 0
            self.y = 0
            self.r = 1
  
        elif len(args) == 1: 
            self.x = 0
            self.y = 0
            self.r = args[0]

        elif len(args) == 2: 
            self.x = args[0]
            self.y = args[1]
            self.r = 1

        else: 
            self.x = args[1]
            self.y = args[2]
            self.r = args[0]

    def shift(self, xCoord, yCoord):
        self.x = xCoord
        self.y = yCoord
        print(f"The unit circle is now centered at ({self.x},{self.y}).")
    
    def enlarge(self, radius):
        self.r *= radius
        print(f"c1 was a unit circle and now it has a radius of {self.r}.")
    
    def inside(self, xCoord, yCoord):
        self.x_limit_left = self.x - self.r
        self.x_limit_right = self.x + self.r
        self.y_limit_up = self.y + self.r
        self.y_limit_down = self.y - self.r
        x_limit_list = list(range(self.x_limit_left, self.x_limit_right + 1))
        y_limit_list = list(range(self.y_limit_down, self.y_limit_up + 1))
        if xCoord in x_limit_list and yCoord in y_limit_list:
            print(f"The point at ({xCoord},{yCoord}) is within the circle c1")
        else:
            print(f"The point at ({xCoord},{yCoord}) is without the circle c1")

c1 = Circle()
c2 = Circle(3)
c3 = Circle(2,5)
c4 = Circle(3,4,2)

print(f'c1 = ({c1.x},{c1.y}), radius = {c1.r}')
c1.shift(4,5)
c1.enlarge(3)
c1.inside(2,5)

print(f'c1 = ({c1.x},{c1.y}), radius = {c1.r}')
print(f'c2 = ({c2.x},{c2.y}), radius = {c2.r}')
print(f'c3 = ({c3.x},{c3.y}), radius = {c3.r}')
print(f'c4 = ({c4.x},{c4.y}), radius = {c4.r}')
