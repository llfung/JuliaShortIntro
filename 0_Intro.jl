# Julia Language Introduction Showcase
# This script demonstrates key features that make Julia unique and powerful
## 0. EASY SYNTAX - Clean and intuitive, similar to Python and MATLAB
println("Welcome to Julia programming!")

# Assign the value 10 to the variable x
x = 10

# Doing math with x's value
x + 1

# Reassign x's value
x = 1 + 1

# You can assign values of other types, like strings of text
x = "Hello World!"

# Complex numbers are built-in
z = 1 + 2im
z/z^2

## 1. FLOW CONTROL - For loops, while loops, if statements, and more
# For loops 
for i in 1:5
    println("For-loop Iteration $i")
end

# While loops is slightly trickier, because variable scope in loops are local
i = 0
while i < 5
    global i  # Declare i as global to modify it inside the loop
    println("While-loop Iteration $i")
    i += 1
end

# If statements
x = rand()
if x < 0.5
    println("x is less than 0.5")
else
    println("x is greater than or equal to 0.5")
end

# Vectorisation - if you can express your code in terms of vectorised operations, it will be much faster than loops
v = zeros(1000)
# Slow way using loops
for i=1:length(v)
    v[i] += 1
end
print("v = ", v)
# Fast way using Broadcast operations
v = zeros(1000)
v .+= 1
print("v = ", v)

## ARRAYS and TUPLES - Flexible data structures
arr = [1, 2, 3, 4, 5]  # Array (mutable)
tup = (1, 2, 3)       # Tuple (immutable)
println("Array: ", arr)
println("Tuple: ", tup)

arr[1] = 10  # Modify array
println("Modified Array: ", arr)
# tup[1] = 10  # This would throw an error since tuples are immutable

## 2. MATRIX OPERATIONS - First-class linear algebra
A = rand(3, 3)
b = rand(3)
x = A \ b  # Solves Ax = b


