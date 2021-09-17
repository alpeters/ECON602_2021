# Tutorial 2: Getting started coding Julia

1. Create a new repository through your github (online)
2. Open VS Code
    - ctrl + shift + p is your master shortcut for everything in VS Code!
3. Make a local clone of your repository
4. Pulling changes:
    - Create a new Julia file *on github*, for example demo.jl

            my_integer = 5
            my_float = 5.
            my_range = 1:7
            my_vector = [1, 2, 3]
            my_string = "hello"
            my_character = 'o'
            my_boolean = true
    - Now go to VS Code and pull demo.jl
5. .gitignore
    - In VS Code, create a garbage file: garbage.lmnop
    - Add *.lmnop to your .gitignore file
6. Some basics (see [Quantecon Intro](https://julia.quantecon.org/getting_started_julia/julia_by_example.html) for more explanation):
    - Start Julia REPL
    - Open your demo.jl, we'll be working in this file
        - (Almost) always work in a script file
        - Comment your code enough that someone else who knows the language can follow, but not too much!!

                # This is a single line comment
                #= 
                    This is a multline comment
                =#
                """ 
                    This is a header 
                """
        - Can use up arrow in REPL (or first letters and then up arrow)
    - Getting help:
        - VS code sidebar
        - REPL: type '?' followed by command name
        - Search in browser: 'Julia' and command name
    - Execute the existing code
    - Check types:

            typeof(my_integer)
            typeof(my_float)
            ##
            typeof(my_vector)
            typeof(my_string)
            ##
            typeof(my_character)
            typeof(my_boolean)
    - Execute current:
        - line: ctrl + enter
        - cell: alt + enter
        - block: shift + enter
    - Cancel running code: ctrl + c
    - Exit Julia REPL: ctrl + d
    - Other useful things:

            α = 5  #type '\alpha' and hit 'tab'
            α = 5;
            @show α + my_integer
            print("α = $α \n", "My string is: $(my_string)")
            println("hi")  # creates a new line after

        - Greek (and other) letters
        - Use ';' to suppress output (typically not required)
        - @show vs. print()
        - spacing around operators and after commas
        - variable names should be lowercase, use '_' to separate words if necessary (see [naming conventions](https://docs.julialang.org/en/v1/manual/style-guide/))

7. Matrix operations
    - Define arrays

            A = [1, 2, 3]   # column vector (array)
            B = [1 2 3]     # row vector (array)
            ones(3)
            zeros(5)
            C = [1 3; 5 9]  # array


        - Common to use capital letters for arrays or make plural (ex. values as array of value elements)

    - Define ranges

            A = 1:9
            B = 1:0.5:9

    - Explore arrays, ranges

            typeof(A)
            eltype(A)
            size(A)
            length(A)
            ndims(A)


    - Indexing elements

            A[1]    # first element
            A[end]  # last element
            C[1,2]  # element in row 1, column 2
            C[3]    # Julia iterates column-wise
            C[3,]   # Same as above
            C[2,:]  # Select row


        - Starts at 1 (not 0)
    - Aside:Julia package environment
        - Packages provide more functionality
        - Best to use different environments for different projects to avoid loading unnecessary packages
        - To enter package manager: ']' *in REPL*
        - Current environment is shown in parentheses
        - Check what is installed in your current environment:

                st # or 'status'

        - Switch (activate) environment:

                activate .  # '.' selects current directory
                add LinearAlgebra
                
        - To remove a package:

                rm LinearAlgebra # or 'remove'

    - Identity matrix

            using LinearAlgebra
            I
            C*I
        - 'I' scales appropriately

    - Operations (matrix vs. element-wise/broadcasting)

            C'
            C^2
            C.^2

        - The last is an example of broadcasting, which can be used with any function, for example:
            
                sin.([1 2 3])

    - Matrix inverse

            inv(C) 

        - $ C^{-1}C$

                inv(C)*C  # Never use this!
                C\C       # Use this instead
        
    

8. Functions, control flow, and scope
    - A useful pre-defined function: random numbers
            
            using Random
            rand(1)
            rand(1, 1)
            randn(2)
            Random.seed!(1234)
            rand(3)
            Random.seed!(1234)
            rand(1)
        - Set seed for reproducible results

    - If/else
        - Simple

                a = true
                if a
                    b = 3
                end

                a ? b = 3 : nothing  # equivalent to previous

        - If, else
                a = 5
                b = 3

                if a == 5 | b == 3
                    print("Either a equals 5 or b equals 3 (or both")
                else
                    print("a is not 5 and be is not 3")
                end

        - If, elseif, else

                a = 5
                b = 2

                if a == 5
                    print("a is 5")
                elseif a == 9
                    print("a is 9")
                else
                    print("a is neither 5 nor 9")
                end

    - For loops

            vals = ["a" "b" "c"]
            for val in vals
                println(val)
            end

        - Scope. 'val' only exists inside loop
        - For loops are fast in Julia!

        - If you need indices:

                for i in eachindex(vals)
                    println(val[i])
                end

        - If you need values and indices:

                for (index, value) in enumerate(vals)
                    println("Element $index of vals is $value")
                end

    - Functions

            function cobbdouglas(l, k, α, β = 1 - α; A = 1)
                y = A*l^α*k^β
                return y
            end

            output = cobbdouglas(1, 3, 0.5)
            output = cobbdouglas(1, 3, 0.5, 0.6)
            output = cobbdouglas(1, 3, 0.5, A = 2)
            output = cobbdouglas.([1, 2], 3, 0.5)

        - Can provide default values with '=':

                f(x = 1) = x
        - Can require arguments to be named with ';':

                f(x; y)

        - Can broadcast your own functions

        - Last line is automatically returned unless specified otherwise:

                function cobbdouglasnoreturn(l, k, α, β = 1 - α; A = 1)
                    y = A*l^α*k^β
                end

                cobbdouglas(1, 3, 0.5) == cobbdouglasnoreturn(1, 3, 0.5)

        - Short-hand form (preferred if makes code clearer):

                y(l,k, α, β = 1 - α; A = 1) = A*l^α*k^β
                y.([1, 2], 3, 0.5) .== cobbdouglas.([1, 2], 3, 0.5)

        - Can also pass functions to functions!

                fsquared(f, x) = f(x)^2
                fsquared(sin, 0.1) == sin(0.1)^2

            

9. Plotting
    - Install 'Plots' package
    - Plot a basic function:

            using Plots
            plot(sin, 0, 1)
            plot!(cos, 0 , 1)
            scatter!([0.5], [0.5])
    
    - Add labels:

            plot(sin, 0, 1, label = "sin(x)")
            plot!(cos, 0, 1, label = "cos(x)")

10. Optimization
    - [See optimization markdown](Optimization_demo.md)

11. Commit changes and push your demo.jl file
    - Make meaningful commit messages. They are useful if you ever want to revert.
    
