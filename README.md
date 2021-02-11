# Mini-task 1

# Class
Class Circle is formed to perform.
```py
class Circle:
```

# Constructor
The constructor reads variables `self` and the number of input `*args`, then create 3 variables `x`, `y`, and `r` representing `X-coordinate`, `Y-coordinate`, `radius` respectively.
```py
def __init__(self, *args):
```

## Number of input = 0
When user input 0 input, the program will generate a circle with center (0,0) and radius equal to 1.
```py
if len(args) == 0:
        self.x = 0
        self.y = 0
        self.r = 1
```

## Number of input = 1
When user input a input, the input will consider as radius. 
The program will generate a circle with center (0,0) and radius equal to the input.
```py
elif len(args) == 1: 
    self.x = 0
    self.y = 0
    self.r = args[0]
```

## Number of input = 2
When user input 2 inputs, the input will consider as x and y coordinate.
The program will generate a circle with center (`input.x-coordinate`,`input.x-coordinate`) and radius equal to 1.
```py
elif len(args) == 2: 
        self.x = args[0]
        self.y = args[1]
        self.r = 1
```

## Number of input >= 3
When user input 3 or more inputs, the input will consider as radius, x and y coordinate.
The program will generate a circle with center (`input.x-coordinate`,`input.x-coordinate`) and radius equal to `input.raidus`.
```py
 else: 
        self.x = args[1]
        self.y = args[2]
        self.r = args[0]
```

# Function Shift
By calling shift, the orginial x and y coordinate will be moved by user input new variable `xCoord` and `yCoord`.
```py
def shift(self, xCoord, yCoord):
        self.x = xCoord
        self.y = yCoord
        print(f"The unit circle is now centered at ({self.x},{self.y}).")
```

# Function Enlarge
By calling enlarge, the orginial radius will be enlarged by user input's `radius` times.
```py
def enlarge(self, radius):
    self.r *= radius
    print(f"c1 was a unit circle and now it has a radius of {self.r}.")
```

# Function Inside
By calling inside, user input new variable `xCoord` and `yCoord` will be test whether it is inside the circle or not.
After calculating the limit of x and y-axis, 2 lists will be formed.
Then, conclusion that within the circle or not will show by comparing whether the input are in the lists.
```py
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
```

# Usage
For example
```py
c1 = Circle()
c1.shift(4,5)
c1.enlarge(3)
c1.inside(2,5)
```