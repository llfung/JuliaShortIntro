## WHY JULIA? - A quick overview of its unique features
# Julia is designed for high-performance numerical and scientific computing, while also being easy to use and flexible. 
# Here are some of the key features that make Julia stand out.
## 1. MULTIPLE DISPATCH - Julia's core feature
# Functions behave differently based on argument types

function greet(name::String)
    println("Hello, $name")
end

function greet(n::Int)
    println("The number is $n")
end

greet("Julia")
greet(42)

## 2. DYNAMIC TYPING with PERFORMANCE
# No type declarations needed, but Julia compiles to efficient machine code

function fibonacci(n)
    if n ≤ 1
        return n
    end
    return fibonacci(n - 1) + fibonacci(n - 2)
end

println("Fibonacci(10) = ", fibonacci(10))

## 3. UNICODE SUPPORT - Write mathematical code naturally
α = 0.1
β = 0.5
θ = α + β
ϕ = sin(θ)

## 4. COMPREHENSIONS - Concise and readable
squares = [i^2 for i in 1:10]
matrix = [i + j for i in 1:3, j in 1:3]

## 5. BROADCASTING - Vectorized operations without loops
v = [1, 2, 3]
result = v .* 2 .+ 1  # Element-wise operations

## 6. PERFORMANCE - Type stability leads to speed
function sum_array(arr::Vector{Float64})
    total = 0.0
    for val in arr
        total += val
    end
    return total
end
