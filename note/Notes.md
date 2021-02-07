# ecture 1

The Zen of Python:

```python
import this
```

<br>

Different ways for reading files:

``` python
file = open('myFile', 'r')
words = file.read().split()

file = open('myFile', 'br')
words = file.read().decode().split()
```



# Lecture 2

The intrinsic name and the bound name of a function:

```python
def myfunc(args):
    pass
g = f
>>>f.__name__
'f'
>>>g.__name__
'f'

```

<br>

Function name should always be in lowercases.

<br>

Don't use tabs, use spaces.

<br>

help(fun_name): enter q to quit help.

<br>

Docstring Syntax:

```python
def myfunc(args):
    """ A one-line description of this function.
    General behavior of this function.
    Description of args. e.g. x -- temperature in centigrades.
    >>> myfunc(m)
    n
    >>> myfunc(n)
    t
    """
    pass
```



# Lab 00



Test labs and homework using ok in your own computer:

```python
python ok -q question_function_name --local # test for a specific question.
python ok --local # test for the whole Python file.
python ok -q question_name -u # unlock the question, if you add --local, it will fail. In this situation, I use the 2020 fall homework instead
```

Notice: only the latest version(currently the ok for Spring 2020 fall class and Spring 2021 class) of ok can be working without the `--local` parameter. If you use an older version of ok python without `--local`, it will display `checking for software updates` and stuck at there.  



# HW 1

Answer for the Quine question:

```python
quline = 'print("quline = " + repr(quline) + ";eval(quline)")';eval(quline)
```

The built-in `eval` function, which evaluates a string as a Python expression.

The built-in `repr` function, which returns an expression that evaluates to its argument.



# Lecture 3

If not short-circuiting, `and` and `or` Boolean operator returns the last expression they evaluate.

<br>

Some examples for  including  `1/0(ZeroDivisionError)`in the Boolean expressions:

```python
True and 1/0  # No short-circuiting, so the result is ZeroDivisionError
True or 1/0  # The right expression is short-circuited, so the result is True
False and 1/0 # The right expression is short-circuited, so the result is False
False or 1/0 # No short-circuiting, so the result is ZeroDivisionError

1/0 and/or True/False  # The left expression will cause an error, so the result is ZeroDivisionError
```

<br>

 Debugging Methods:

1) Running doctests for codes in a file:

```python
python -m doctest <filename.py> # simply run the test in docstrings
python -m doctest <filename.py> -v # run the test in docstrings and display the result on the screen
```

2) Running doctests for codes in the interactive session:

```python
from doctest import testmod
testmode()   # test for all tests in all docstrings in the session

from doctest import run_docstring_examples
run_docstring_examples(function_name, globals(), True) # test for tests in the docstring of a specific function

```



# Lab 01

Assertion statement should be included in a release version of your codes, but debugging print statement should not.

<br>

Traceback Message: `File <file_name> line <line_number> in <function>`

Error Message: `<error type> : <error message>`

<br>

Common Error Types: SyntaxError, IndentationError, TypeError, ZeroDivisionError, NameError, IndexError

<br>

Common Bugs: spelling, missing parentheses, missing close quotes, == v.s. =, infinite loops, off-by-one errors(boundary condition error)



# Lecture 4

Notice the following tuple assignment:

```python
def func(n,term):
    total, k = 0, 1
    while k <= n:
        total, k = total + term(k), k + 1
    return total
        

```

Currying(so-called 柯里化 in Chinese): use high-order function to convert functions with multiple arguments into a chin of functions(in some languages like Haskell a function can have at most one argument ):

```python
# Use g(x)(y) to represent f(x,y)
def g(x):
    def h(y):
        return f(x,y)
    return h
```

Lambda expression :

```python
# An example: the three ways return the identical result
def func(f,g):                                                   # func.__name__ : '<lambda>'
    return lambda x: f(g(x)) 
f = func(lambda x: x ** 2, lambda y: y + 1)                      # f.__name__:'<lambda>'
f(12) # return 169

func = lambda f, g: lambda x: f(g(x))
f = func(lambda x: x ** 2, lambda y: y + 1)
f(12) # return 169

(lambda f,g: lambda x: f(g(x)))(lambda x: x ** 2, lambda y: y + 1)(12) # return 169
```

Decorator: apply a higher-order function as part of executing a def statement:

```python
def trace(func):
    def wrapped(x):
        print('=>', func, '(', x, ')')
    return wrapped

@trace
def identity(x):
    return x

>>>identity(5) # when executing the def statement with  @ <decorator_name> above it, the interpreter will automaticaly run the decorator function
```

Newton's Method:

The procedure of Newton's method:

1) have the function $$func$$ and an initial guess $$x_0$$

2) update the guess by the relationship: $$x_n = x_{n-1} - \frac{func(x_{n-1})}{d func(x_{n-1})}$$

3) stop the iteration when $$func(x_{n}) = 0$$ or $$|func(x_n) - target| < boundry$$

```python
# The following example calculates the nth root of a number using Newton's Method:
def nth_root(n, f, df, guess, target, boundry=1e-6):
    """Calculate the nth root of a number
    
    n -- the nth order
    f -- the function used in the calculation process
    df -- the differential function of f
    guess -- initial guess of the root
    target -- the base of which we want to know the root
    """
    while abs(f(guess, n, target)) > boundry:
        guess = guess - f(guess, n, target) / df(guess, 5)
    return guess


def f1(x, n, target):
    """The function used to calculate nth root
    
    x -- the independent variable in the function
    n -- the nth order
    target -- the base of which we want to know the root
    """
    return x ** n - target


def df1(x, n):
    """The differential function of f1
    
    x -- the independent variable in the function
    n -- the nth order
    """
    return n * (x ** (n - 1))


```



# Project Hog

```python
randint(a,b) # a <= x <= b
```

Nonlocal variable: a variable declared in the outer function but can be modified in the inner function 

```python
def f1():
    x = 5
    def f2():
        nonlocal x
        x += 1
    f2()
    return x
print(f1())    # 6
```

```python
ls.sort(key = lambda x: x[0],reverse = True)  # Default ascending
rs = []
for ele in ls:
    if ele[0] == ls[0][0]
    rs.append(ele[1])                       # List comprehension: rs = [ele[1] for ele in ls if ele[0] == ls[0][0]]
print(min(rs))

```



# Lecture 5

How to draw an environment diagram:

1) when defines an function:

```python
fn: <fun_name>   --------------------> func <fun_name>(<formal_parameters>)[parent = <parent>]                       
```

2) when calls a function:

<ol>
    <li>create a local frame titled with the function being called</li>
    <li>copy the parent of the function to the local frame: [parent = &lt parent &gt]</li>
    <li>bind &lt formal-parameters &gt to arguments in the local frame</li>
    <li>execute the body of the function in the environment that starts with the local frame</li>
</ol>

