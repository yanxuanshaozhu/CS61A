# Lecture 01 2018/08/22

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



# Lecture 02 2018/08/24

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

Notice: only the latest version(currently the ok for 2020 Fall class and 2021 Spring class) of ok can be working without the `--local` parameter. If you use an older version of ok python without `--local`, it will display `checking for software updates` and stuck at there.  



# HW 01

Answer for the Quine question:

```python
quline = 'print("quline = " + repr(quline) + ";eval(quline)")';eval(quline)
```

The built-in `eval` function, which evaluates a string as a Python expression.

The built-in `repr` function, which returns an expression that evaluates to its argument.



# Lecture 03 2018/08/27

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



# Lecture 04 2018/08/29

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



# Project 01 Hog

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



# Lecture 05 2018/08/31

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


# Lecture 06 2018/09/03

Self-reference: a function that refers to itself in the function body is called self-reference



# Lecture 07 2018/09/05

Recursive function: can be divided into a base case and recursive function calls

<br>

Mutual recursion:  if a recursive procedure can be divided into two functions that call each other, then the two functions are mutual recursive.

The mutual recursive functions can be rewritten into a single recursive function. Say if you use two functions to represent the even and odd cases respectively, you can then replace them using one function that uses a step of two.

<br>

Tree recursion: a function calls itself multiple times in the function body

```python
# An example: let par(n, m) be the function that calculates the number of differentt partitions of an integer n, requiring each fraction no greater than m
# In such a case we must have par(n, m) = par(n - m, m) + par(n, m - 1). par(n - m, m) represents the partitions that use m as a fraction while par(n, m - 1) represents the remaining partitions
```

<br>

The Luhn algorithm: used for the credit card number checker. 

The credit card number consists of two parts: the ordinary digits and the check digit at last. For example,if the account number is "7992739871" and the check number is X, then the full account number is "7992739871X". The Luhn algorithm is used to calculate what the number X is.

Steps of Luhn Algorithm:

1. Starting from the rightmost digit(the check digit) and moving left, double the value of every second digit; if the result of doubling operation is greater than 9, then sum the digits of the result(e.g., 6 * 2 = 12 > 9, then replace 12 with 1 + 2 = 3 )

2. Add the resulting numbers in each place, denote it as sum_results, then the check digit can be calculated in the following ways:

    ​                                                                                                  $$ check\_digit = (10 - (sum\_results \quad mod \quad 10) \quad mod \quad 10)$$

For the above example, the sum_results = 1 * 2 + 7 + 7( 8 * 2 => 7) + 9 + 3 * 2 + 7 + 2 * 2 + 9 + 9( 9 * 2 => 9) + 7 = 67. Then check_digit =  (10 - 67 % 10) % 10 = 3. So the full credit card number is "7992739871X".

A simple way to verify whether the check_digit is correct:  if `(sum_results + check_digit) % 10 == 0`, then the check_digit is correct.



# Lecture 08 2018/09/07

Functional abstractions: concrete implementations do not matter in this situation.

<br>

Choosing names:

<ul>
    <li> Names should convey the meaning or purpose of the values to which they're bound</li>
    <li> The type of values bound to the name is best documented in the docstring of the function</li>
    <li> Names can be long if they help to document your code</li>
    <li> Names can be short if they represent generic quantities</li>
</ul>

<br>

Test-driven development:

<ul> 
    <li> Write test for functions before you actually implementing the function itself</li>
    <li> Develop incrementally and test each piece before moving on</li>
    <li> Run your code interactively</li>    
</ul>


# Lecture 09 2018/09/12

Different ways to implementations recursive functions:

<ul>
    <li> If multiple implementations of a function are equally clear, then you should choose the shorter one </li>
    <li> If the longer one is more clear, then you should use it</li>
    <li> Sometimes the base case is omitted so the function implementations are shorter, however, the function is still recursive in these cases</li>
</ul>

<br>

If you store every intermediate value during the recursion process, then it is pretty slow compared with Iteration.



# HW 02

This one is quite hard for me, I spent a long time converting iteration to recursion for the ping pong question and the count coins question. At first there were duplicate results in my recursion formula and I checked for a while, also I turned to the hint videos on the website for inspiration.  I learnt several lessons from these two problems:

<ol>
    <li>If you want to preserve several variables through the recursion process, define a helper function with all needed variables as arguments inside the target function.</li>
    <li>If counting from the largest number doesn't work, then try starting from the smallest one.</li>
    <li>A forluma: term(n, m) = term(n - m, m) + term(n, fun(m))</li>
</ol>

<br>

The recursive lambda:

```python
lambda func: lambda args: func(func,args)             # This is a general form for recursive lambda, the func is a two-argument recursive function
(lambda func: lambda args: func(func,args))(lambda f, x: x * f(f, x - 1))(n) # This calculate the factorial(n)
```



# Lecture 10 2018/09/14

Each value in Python has a class that determines the type of the value, values share class and behavior.

<br>

Native data types:

* Properties:
    * literals: expressions that evaluate to values of native data types
    * functions and operations to manipulate values of native data types
* Categories:
    * numeric types: int (integers), float (real numbers), complex (complex numbers)
    * no-numeric types: bool (True / False), the majority of no-numeric data types cannot be described in native data types

<br>

Data abstraction: separate segments of programs that deal with how data are represented from segments of programs that deal with how data are manipulated

Function abstraction: separate how function is implemented and how function is used

<br>

Abstraction barrier: lower-layer functions are invisible to function users, they only access higher-layer functions, the higher-layer functions can interact with the lower-layer functions. In such a way, how data is actually implemented, how lower-layer function is defined (like selector/ constructor  e.g., get/set, constructor in Java) don't affect the behavior of the data types/ functions.



# Lecture 11 2018/09/17

Sequence: an ordered collection of values, there are different types of sequences, but they share common behaviors.

* Properties: finite length, an empty sequence has 0 length
* Indexing: starting from 0
* list is a type of sequence, string is a type of sequence, range is a type of sequence

```python
for _ in range(n)  # use underscore instead of index like i


def map_list(func, ls):
    return [func(ele) for ele in ls]

map_list = lambda func,ls: list(map(func, ls))

def subset_list(func, ls):
    return [ele for ele in ls if func(ele)]

subset_list = lambda func, ls: list(filter(func, ls))

def reduce_list(func, ls, initial):
    reduced = initial
    for ele in ls:
        reduced  = func(reduced, ele)
    return reduced

from functools import reduce
reduce_list = reduce(func, ls)  # The initial value for reduce function can be omitted
```



# Lab 04

I stuck at question 5 for some time, so I put the question here:

A subsequence of a number is a series of (not necessarily contiguous) digits of the number. For example, 12345 has subsequences that include 123, 234, 124, 245, etc. Your task is to get the maximum subsequence below a certain length.

```python
def max_subseq(n, t):
    """
    Return the maximum subsequence of length at most t that can be found in the given number n.
    For example, for n = 20125 and t = 3, we have that the subsequences are
        2
        0
        1
        2
        5
        20
        21
        22
        25
        01
        02
        05
        12
        15
        25
        201
        202
        205
        212
        215
        225
        012
        015
        025
        125
    and of these, the maxumum number is 225, so our answer is 225.

    >>> max_subseq(20125, 3)
    225
    >>> max_subseq(20125, 5)
    20125
    >>> max_subseq(20125, 6) # note that 20125 == 020125
    20125
    >>> max_subseq(12345, 3)
    345
    >>> max_subseq(12345, 0) # 0 is of length 0
    0
    >>> max_subseq(12345, 1)
    5
    """
    "*** YOUR CODE HERE ***"
    if t == 0:
        return 0
    elif t >= len(str(n)):
        return n
    else:
        return max(10 * max_subseq(n // 10, t - 1) + n % 10, max_subseq(n // 10, t))
```



# Lecture 12 2018/09/19

Box- and-pointer notation: a way to represent lists in the environment diagrams

It's a series of adjacent boxes with two parts in each box, the first part is an index, the second is a value for this box or a pointer pointing to another box or pointing to a function.

<br>

Processing container values:

```python
sum(iterable [, initial_value]) -> value
max(iteratble, key = func) -> value # max([func(ele) for ele in iterable])
all(iterable) -> bool # True if the iterable is empty or bool(x) is true for each x in the iterable, False otherwise
```

<br>

Trees abstraction:

* Recursive definition: a root label and a list of branches, each branch is a tree; a tree with no branch is called a leaf
* Relative definition: each location in a tree is a node, each node has a label that can be any value; one node can be parent/child of another

<br>

Sum of nested list: return a list, the element of which is the sum of the elements of the original list at that place

<br>

Functions that take trees as inputs/outputs are often tree-recursive themselves



#  Lecture 13 2018/09/21

Objects combine data and behavior, objects represent information, but also behave like the things they represent.

<br>

```python
from datetime import date
mydate = date(22021,2,20)
mydate.strftime('%a, %b %d')  # 'Sat Feb 20'  %a means week, %b means month, %d means day
```

<br>

```python
str.swapcase()  # swap lowercases and uppercases in a string
```

<br>

Identity operator and equality operator:

```python
a is b # True is a and b points to the same object
a == b # True if the pointed objects have the same value
# If a is b equals to true then a == b must be true, but no otherwise
```



# Lecture 14 2018/09/24

Motivation: Sometimes we want to maintain some state within a function. For example, if we define a function called `withdraw(amount)` to withdraw  a certain amount of money from the bank,  the function returns the remaining balance in your account. We then want to maintain the balance within the function, which means if we call the function multiple times with the same amount parameter, we should have different returning values. 

There are two different ways to tackle this problem:

* We can use the nonlocal statement:

```python
def withdraw_account(balance):
    def withdraw(amount):
        nonlocal balance
        if amount > balance:
            return 'Insufficient funds'
        balance -= amount
        return balance
    return withdraw
```

* We can use the mutable objects:

```python
def withdraw_account(balance):
    b = [balance]
    def withdraw(amount):
        if amount > b[0]:
            return 'Insufficient funds'
        b[0] -= amount
        return b[0]
    return withdraw
```

<br>

If you use nonlocal statement for a variable, then it must be bound in the first non-local parent frame of the current frame.

<br>

Python pre-computes which frame contains which names before executing the function body. Within a function body, all instances of a name must refer to the same frame.

```python
def withdraw_account(balance):
    def withdraw(amount):
        #nonlocal balance
        if amount > balance:
            return 'Insufficient funds'
        balance -= amount
        return balance
    return withdraw
```

In the above example, if we omit the nonlocal statement, it will cause a UnboundLocalError, because within the body of function withdraw, the local variable `balance` is referenced before assignment.

<br>

Referential transparency: if an expression can be replaced by its value without changing the meaning of a program, then the expression is called referential transparent.

<br>

An example of nonlocal statement:

```python
def f(x):
    x = 4
    def g(y):
        def h(z):
            nonlocal x
            x += 1
            return x + y + z
        return h
    return g
a = f(1)
b = a(2)
total = b(3) + b(4) # 22, b(3) == 10, b(4) == 12
```



# Lecture 15 2018/09/26

Iterators:

1. An container can provide and iterator that provides access to its elements in some order

2. Some related functions:
    2.1. iter(iterable): returns an iterator

  2.2. next(iterator): returns the next element in the iterator

  2.3. list(iterator): list the unvisited elements in the iterator. If listed, then an iterator cannot be used again, otherwise an StopIterationError will be caused

3. Iterators are mutable objects

<br>

Dictionary iteration:

1. The values, keys and items of a dictionary are all iterable. For Python version 3.6 and higher, the iteration order is the order by which items are added into the dictionary, for Python version 3.5 or lower, the iteration order is arbitrary.
2. If the size of the dictionary is changed during iteration(you add something into the dictionary or you pop something during iteration), an RuntimeError will be caused. For lists,  you can do whatever you want to the list during iteration.

```python
# If you want to remove keys of which the values are empty,the following way is wrong and causes an RuntimeError
for key in d:
    if not d[key]:
        d.pop(key)                               
# You should do like this
for key in d.copy():
    if not d[key]:
        d.pop(key)
```

<br>

For iteration over iterables and iterators:

```python
for _ in iterable:                 # Iteration on iterables can be executed multiple times
    pass

for _ in iterator:                 # Iteration on iterators can be executed only once, otherwise StopIterationErro is caused
    pass
```

<br>

Built-in iterator functions:

1. Many operations on sequences return iterators that compute results lazily, lazy computation means result is only computed when needed

2. Example functions:

    2.1 map(func, iterable)

    2.2 filter(func, iterable)

    2.3 zip(first_iter, second_iter)

    2.4 reserved(seq)

<br>

Generators:

1. Generators are special iterators that they are results of generator functions
2. A generator function uses yield statements to replace the return statement, all yield statements can be executed and related values can be returned
3. Yield from statement: returns al values in an iterable or an iterator,the following two ways are equal:

```python
for x in iterable:
    yield x

yield from iterable
```



# Lab 05

Q9: Riffle Shuffle

The familiar [riffle shuffle](https://fredhohman.com/card-shuffling/static/images/riffle.gif) of a deck of cards (or in our case, of a sequence of things) results in a new configuration of cards in which the top card is followed by the middle card, then by the second card, then the card after the middle, and so forth. Assuming the deck (sequence) contains an even number of cards, write a list comprehension that produces the shuffled sequence.

*Hint:* To write this as a single comprehension, you may find the expression `k%2`, which evaluates to 0 on even numbers and 1 on odd numbers, to be useful. Consider how you can use the 0 or 1 returned by `k%2` to alternatively access the beginning and the middle of the list.

```python
def riffle(deck):
    """Produces a single, perfect riffle shuffle of DECK, consisting of
    DECK[0], DECK[M], DECK[1], DECK[M+1], ... where M is position of the
    second half of the deck.  Assume that len(DECK) is even.
    >>> riffle([3, 4, 5, 6])
    [3, 5, 4, 6]
    >>> riffle(range(20))
    [0, 10, 1, 11, 2, 12, 3, 13, 4, 14, 5, 15, 6, 16, 7, 17, 8, 18, 9, 19]
    """
    "*** YOUR CODE HERE ***"
    return _______
```

My intuition: we first make a list of nested lists, each element in the out-layer list is a two-element list, then we reduce the out-layer list to one dimension,

```python
	return [item for sublits in [[deck[k], deck[k + len(deck) // 2] for k in range(len(deck) // 2)] for item in sublist] 
```



Another solution following the hint: for odd position, the index needs to plus `len(deck) // 2`, for even position, the index is just `k`, so we simply use `k % 2` to separate the indices,

```python
	return [deck[k + (k % 2) * (len(deck) // 2)] for k in range(len(deck))] 
```



# Lab 06

Q4: Insert Items

Write a function which takes in a list `lst`, an argument `entry`, and another argument `elem`. This function will check through each item present in `lst` to see if it is equivalent with `entry`. Upon finding an equivalent entry, the function should modify the list by placing `elem` into the list right after the found entry. At the end of the function, the modified list should be returned. See the doctests for examples on how this function is utilized. Use list mutation to modify the original list, no new lists should be created or returned.

**Be careful in situations where the values passed into `entry` and `elem` are equivalent, so as not to create an infinitely long list while iterating through it.** If you find that your code is taking more than a few seconds to run, it is most likely that the function is in a loop of inserting new values.

```python
def insert_items(lst, entry, elem):
    """
    >>> test_lst = [1, 5, 8, 5, 2, 3]
    >>> new_lst = insert_items(test_lst, 5, 7)
    >>> new_lst
    [1, 5, 7, 8, 5, 7, 2, 3]
    >>> large_lst = [1, 4, 8]
    >>> large_lst2 = insert_items(large_lst, 4, 4)
    >>> large_lst2
    [1, 4, 4, 8]
    >>> large_lst3 = insert_items(large_lst2, 4, 6)
    >>> large_lst3
    [1, 4, 6, 4, 6, 8]
    >>> large_lst3 is large_lst
    True
    """
    "*** YOUR CODE HERE ***"
```

At first , I did not notice the restriction that no new lists were allowed to be created, so I wrote the following codes.

```python
def insert_items(lst, entry, elem):
    items = [(ele, 0) for ele in lst]
    for _ in range(len(items)):
        if items[_][0] == entry and items[_][1] == 0:
            items.insert(- + 1, (elem, 1))
    return [item[0] for item in items]
            
```

The main idea is that we can add a marker to identify whether the element locates originally in the list or is inserted into the list. Although this way does not meet the requirement of this question, I still find it interesting. 

The following codes do meet the needs of this question:

```python
def insert_items(lst, entry, elem):
    index = 0
    while index < len(lst):
        if lst[index] == entry:
            lst.insert(index + 1, elem)
            index += 2
        else:
            index += 1
    return lst
```



# Lecture 16 2018/09/28

1 Classes and objects:

1. class is a template for objects that share same attributes and behaviors, the objects are class instances
2. creating an instance of a class is also called instancing the class
3. attributes associated with instances are also called instance attributed, fields, properties and instance variables, function attributes are also called methods

<br>

2 Dual roles of object in the `object.method` expression:

1.  the object means the method is not in the global environment, but inside the local environment of a class
2.  the object is bound to the first argument `self` in the method

<br>

3 Functions and methods:

```python
type(Class_name.func_name(object, arguments))          # <class 'function'>
type(instance_name.func_name(arguments))               # <class 'method'>
```

Notice that when calling a method using a Class object, we need to explicitly specify the object that is bound to the `self` argument in the method, but when calling a method using an instance, we don't need to do that.

<br>

4 Class attributes:

1. Evaluation procedure of `<object>.<attribute>`:
    1.  we first evaluate the object
    2. then we look up the attribute in the current class, if it exists, return the value of that attribute
    3. if the attribute doesn't exist in the current class, we look up the attribute in parent  classes, if it is found, return the value of that attribute
    4. if the attribute is a method instead, return the result value of that method

2. attribute assignment

```python
instance.attribute = value 
"""
the code creates an instance field and assigns a value to it, if there exists already a class attribute with the same name, it doesn't change the value of that class attribute
"""
Class.attribute = value
"""
this code creates a class attribute and assigns a value to it, it affects all instances without instance attributes of the same name, it has no effect for those instances that have an attribute with the same name
"""
```



# Lecture 17 2018/10/01

1 Terminologies: parent class/ base class/ superclass                            subclass

<br>

2 Interfaces:

1. Def: a collection of attributes and conditions on those attributes
2. In Java, you need to explicitly declare an interface, however, in Python, Ruby and Go, an object with the appropriate name implements an interface already

<br>

3 Multiple inheritances:

1. Order: from bottom to top, from left to right in the same layer(the left-to-right order is the same as the order written in the class arguments)
2. The algorithm is called the C3 Resolution Ordering

<br>

4 Object-oriented design principles:

1. Don't repeat yourself, use existing implementations
2. Attributes that have been overridden are still accessible via class objects:  `Parent_class_name.attribute`
3. Look up attributes on instances whenever possible



# Lab 07

Don't modify a list while iterating on it using for loop, it may result in wrong results, particularly, don't remove elements during iteration.

Reason: the for loop uses list indices to record the iteration process, however, deleting items in the list results in mismatch of the current list with the original indices.

```python
"""
Say if you want to delete all zeros in the following list and you wirte codes like this:
"""
ls = [1, 0, 0, 1, 1, 0, 0, 1]
for item in ls:
    if item == 0:
        ls.remove(item)
# >> x   => [1, 1, 1, 0, 0, 1]
"""
The whole procedure
list.remove(item): remove the first element in the list that equals to item
index = 0,  len(ls) = 8       original list: ls = [1, 0, 0, 1, 1, 0, 0, 1]       item = ls[index] = 1       nothing changed
index = 1,  len(ls) = 7       original list: ls = [1, 0, 0, 1, 1, 0, 0, 1]       item = ls[index] = 0       delete the first 0 in ls
index = 2   len(ls) = 7		  original list: ls = [1, 0, 1, 1, 0, 0, 1]          item = ls[index] = 1       nothing changed
index = 3   len(ls) = 7       original list: ls = [1, 0, 1, 1, 0, 0, 1]          item = ls[index] = 1       nothing changed
index = 4   len(ls) = 7       original list: ls = [1, 0, 1, 1, 0, 0, 1]          item = ls[index] = 0       delete the first 0 in ls
index = 5   len(ls) = 6       original list: ls = [1, 1, 1, 0, 0, 1]             item = ls[index] = 1       done!

Another failed trail would be like this:
"""
ls = [1, 0, 0, 1, 1, 0, 0, 1]
for _ in range(len(ls)):
    if ls[_] == 0:
        ls.pop(_)
# >>IndexError: list index out of range

"""
The for loop will adjust for changes in list length, but the for with index loop will not, so it will iterate for len(ls) times, however, because of the item deletion during the iteration, the length of list is shortened, thus an error will be caused.
"""
```

There are several ways to correct this:

1. Use filter function:

```python
ls = list(filter(lambda x: x != 0, ls))
# The filter function returns an iterator, so we need to convert it into list
```

2.  Use list comprehension:

```python
ls = [x for x in ls if x != 0]
```

3. Iterate on the copy:

```python
for item in ls.copy():
    if item == 0:
        ls.remove(item)
#Another way to denote copy
for item in ls[:]:
    if i tme == 0:
        ls.remove(item)
        
```



# Lecture 18 2018/10/03

1 Generic functions:

1. Can accept values of multiple types
2.  Three implementing techniques: shared interfaces, type dispatching and type coercion

<br>

2 String conversion:

1. Python has two ways of string representation:
    1. Human-interpretable text: `str(x)`
    2. Python-interpretable expression: `repr(x)`
2. `repr(object)`: returns the canonical string representation of the object
    1. For most cases we have: `eval(repr(object)) == object`
    2. For some cases like built-in functions the above relationship doesn't hold
3. Use string representations in user-defined classes:
    1. The `str(object)` invokes `object.__str__()` , it is used in the `print(object)`
    2. The `repr(object)` invokes `object.__repr__()`, it is used in the interactive session
    3. If we explicitly overwrite the `__str__()` and the `__repr__()` in our class, then instances of our class have string representation 

<br>

3 Special Methods:

1. `__init__()`: construct objects                                               
2. `__str__()`: print objects

3. `__repr__() `: display objects in the interactive session

4. `__bool__()`: return bool values of objects,

    1. For instances of user-defined classes, the default `object.__bool__()` returns `True`

    2. We can overwrite the function to manipulate its behavior:

        ```python
        __bool__ = lambda self: self.__len__() == 0           # If the length of an object equals to zero, returns True
        ```

5. `__call__()`: allows objects to behave like higher-order function

<br>

4 Three ways to implement generic function:

1. Shared Interfaces: use a collection of shared attributes and behaviors, interface is additive
2. Type Dispatching: check instance types, do different things for instances of different types, the `isinstance(object, type)` function is used here

3. Type Coercion: we can deem subclass objects as superclass objects, or we can explicitly define a conversion function to transfer objects of one type into objects of another type



# Lecture 19 2018/10/05

1 Efficiency:

1. Definition: the computational resources used by a representation or processes

2. Measurement: time and space

3. Space requirements: how memory is used, preserved and reclaimed

    1.  All active environments with referenced values and frames are preserved by the interpreter

4. Efficiency can be greatly improved by memorization:

    ```python
    def fib(n):
        if n == 0:
            return 0
        elif n == 1:
            return 1
        else:
            return fib(n - 1) + fib(n - 2)
        
    def memo(f):
            cache = {}
            def memoized(n):
                if n not in cache:
                    cache[n] = f(n)
                return cache[n]
            return memoized
    fib = memo(fib)
    
    #Notice we can use dp to solve this:
    def fib(n):
        if n == 0:
            return 0
        elif n == 1:
            return 1
        else:
            p, q, r = 0, 0, 1
            for _ in range(2, n + 1):
                p, q = q, r
                r = p + q
            return r
    ```

2 Order of growth:

1. Definition:  let input scale be $n$, let resource requirement b $R(n)$, We say that $R(n)$ as order of growth $\Theta(f(n))$, written $R(n) = \Theta(f(n))$, if there are positive constants $k_1$,  $k_2$ such that $k_1 * f(n) \leq R(n) \leq k_2 * f(n)$
2. Tips:
    1. Constants do not affect order of growth
    2. Base of logarithms does not affect order of growth
    3. When an inner computational process is repeated for each step in an outer process, then the order of growth of the entire process is a product of the number of steps in the outer and inner processes
3.  Common categories:
    1. $\Theta(1)$: constant
    2. $\Theta(logn)$: logarithm
    3. $\Theta(n)$: linear
    4. $\Theta(n^2)$: quadratic
    5. $\Theta(b ^n)$: exponential



# Lecture 20 2018/10/08 

1 Linked List:

1. Definition: first + rest of the list; the rest of the linked list is also a linked list;
2. Empty linked list: no first element, no rest of the list
3. A linked list is a sequence, it has finite length and supports element selection

<br>

2 Tree:

1. Definition: a label + branches; each branch is also a tree
2. Leaf: a tree is a leaf if it has no branches



# Lecture 21 2018/10/10

1 Set:

1. Definition: unordered collection or elements, no duplication in a set

2. Printing order of a set may be different from the displaying order of a set

3. Set operations:

    * union, intersection, isdisjoint, issubset, issuperset
    * add, remove, discard, pop
        * remove: return None, if the element is not in the set, KeyError is caused
        * discard: return None, if the element is not in the set, KeyError is not caused
        * pop: return the removed element, if the element is not in the set, KeyError is caused
    * clear, update

4. Set implementations:  let $m, n $ be the length or the set

    * Unordered sequence: implemented by linked list:
        * Contain operation complexity: $\Theta(n)$
        * Intersect operation complexity: $\Theta(n * m)$
    * Ordered sequence: implemented by linked list:
        * Contain operation complexity: $\Theta(n)$
        * Intersect operation complexity: $\Theta(n + m)$

    * Binary search tree: implemented by tree:
        * Contain operation complexity: $\Theta(log_2n)$
        * Adjourn operation complexity: $\Theta(1)$



# Lecture 22 2018/10/12

1 Binary Search Tree(BST):

1. Definition: 

    * A leaf is a BST

    * Each node has at most two children, each children is a BST
    * For each node, the entries in the left child should be smaller than the label of the node
    * For each node, the entries in the right child should be larger than the label of the node

2.  For adjourn operation, a BST is faster than an ordered linked list



# Lecture 23 2018/10/15  & Lecture 24 2018/10/19

Lecture 23 is a review session, nothing interesting.

Lecture 24 is Alan Kay's presentation on the history of programming language and user interface design.



# Lecture 25 2018/10/22

1 Interpreter: a program that carries out evaluation and execution procedures

<br>

2 Programming Language:

1. PLs vary widely in syntactic structures, features and domain of application
2. A powerful PL can exist without object system, higher-order function, assignment or even control structures
3. The part of Scheme discussed in this class is limited into topics like expressions but not statements, symbolic computations and mutable values

<br>

3 Functional Programming

1. Low-level machine language cares about representation of data and control in terms of storage and primitive machine structures, higher-level language has means of combination and abstraction to apply in larger-scale organization of software systems
2. Scheme is a dialect of Lisp

3. Expressions:

    * Expressions are bound with parentheses
    * If statement:`(if <predicate> <consequent> <alternative>)`. Scheme does not have `elif` statement, you need to use nested if statements.
        * For numeric comparison: `(> 2 3)` is okay

    * Boolean values: `#t` for `True`, `#f` for `False`
    * Logical operations, short-circuiting is applied:
        * `(and <e1> ... <en>)`
        * `(or <e1> ... <en>)`
        * `(not <e>)`

4. Definitions

    * Definition of variable: `(define <var> <value>)`
    * Definition of function: `(define (<name> <formal parameters>) <body>)`
    * Call of function: `(<name> <arguments>)`
    * Lambda expression/ anonymous function: `(lambda (<formal parameters> <body>))`

5. Compound Values:

    * Built-in pairs: `(cons <value1> <value2>)`

        ``` scheme
        (define x (cons 1 2))
        ; Anything followed by a ';' is a comment
        ; Take the first element of a pair
        (car x) ; 1
        ; Take the second element of a pair
        (cdr x) ; 2
        ```

    * Built-in lists: 

        * The empty list `nil` or `'()`

        ```scheme
        ; You can construct a list from nested pairs
        (cons 1
              (cons 2
                    (cons 3 
                          (cons 4 nil)))); (1 2 3 4)
        ; You can also use the list notation
        (list 1 2 3 4); (1 2 3 4)
        ```

6. Symbolic Data: use a quotation mark to denote symbolic data

     ``` scheme
     (define a 1)
     (define b 2)
     (cons a b); (1 2)
     (cons 'a b); (a 2)
     ```



# Lab 10

1 `cond`expression

1. Syntax: `(cond (<p1> <e1>) (<p2> <e2>) ... (<pn> <en>) [(else <else expression>)])`
2. `<p1> ... <pn>` are predicates that can be evaluated to be `#t` or `#f`, `<e1> ... <en>` are expressions that could be executed
3. If `<p1> ... <pk-1>` are all `#f` and `<pk>` is `#t`, then `<ek>` is executed and the `cond` expression terminates  here

<br>

2 Selecting elements from a list:

1. The `car` operator selects the first element in the list
2. The `cdr` operator selects all elements in the list but the first one, is returns a sublist

```scheme
(define x list(1 2 3 4))
(car x); 1
(cdr x); (2 3 4)
```



# Lecture 26 2018/10/24

1 Python interpreter handles errors by terminating immediately and printing an error message.<br>

2 Raise an expression is a technique for interrupting the normal flow of execution in a program, signaling that some exceptional circumstance has arisen, and returning directly to an enclosing part of a program that was designated to react to this circumstance.<br>

3 You can raise an exception with the `raise` statement or the `assert` statement

1. An exception is an object instance inherited from the `BaseException` class
2. `assert` statement raises an exception with the `AssertionError` class
3. Syntax for raise statement: `raise Exception('Error information string')`
4. If an exception occurs, no further statements in the same block of codes will be executed unless the exception is handled, the interpreter will also print a stack backtree to indicate the source of the exception<br>

4 Handling an exception:

1. Syntax

```python
try:
    pass
catch <Exception Class> as <name>:
    pass
```

<br>

5 Exception objects:

1. Exception objects can have attributes
2. You can build a class that inherits the Exception class and customize instance behaviors<br>



# Lecture 27 2018/10/26

1 The Scheme-Syntax Calculator(aka Calculator)

1. It has two legal expressions: numbers that are self-evaluating and call expressions that are Pair instances representing Scheme lists
2. It has an interpreter that takes in text inputs and outputs Calculator expressions<br>

2 Parsing Expressions:

1. Definition: generate expression trees from raw text input
2. Construction of the parser: lexical parser(aka tokenizer) and the syntactic analyzer
    * Lexical parser: partitions one text input expression into tokens
    * Syntactic parser: construct an expression tree from tokens, it is a tree-recursive process<br>

3 The REPL

1. The interactive interface of an interpreter is a REPL(read-eval-print loop)
2. The implementation of a REPL can be independent of the interpreter it uses
3. The process of the REPL:
    1. Print a prompt to denote the REPL is ready
    2. Read the text input
    3. Parse the text input into expression
    4. Evaluate the expression
    5. If error occurs, report the error, otherwise print the expression value and return to Step 1



# Lecture 28 2018/10/29 

1 Scheme interpreter structure:

1. parsing 
2. evaluation
3. procedure application
4. eval/apply recursion

<br>

2 Logical special forms: only evaluate some sub-expressions

1. `If` expression
2. `And` or `or`
3. `Cond` expression

<br>

3 Quotation:

1. Definition: the `quote` special form evaluates to the quoted expression, which is not evaluated
2. Syntax: `(quote <expression>)`
3. `'<expression>` is shorthand for `(quote <expression>)`
2.
<br>

4 Lambda expression:

1. Lambda expressions evaluate to user-defined procedures
2. Syntax `(lambda (<formal-parameters>) <body>)`

5 Frames and environments:

1. A frame represents an environment by having a parent frame
2. Frames are Python instances with methods `lookup` and `define`

6 Define expressions:

1. Define binds a symbol to a value in the first frame of the current environment
2. Procedure definition is shorthand of define with a lambda expression
3. To apply a user-defined procedure, create a new frame in which formal parameters are bound to argument values, whose parent is the `env` of the procedure



# Lecture 29 2018/10/31

1 Dynamic scope:

1. The way names are looked up in Python and Scheme is called lexical scope(static scope)

    * Lexical scope: the parent of a frame is the environment in which a procedure is defined
    * Dynamic scope: the parent of a frame is the environment in which a procedure is called

<br>

2 Tail recursion:

1. Functional programming

    1. Properties:
        * All functions are pure functions
        * No reassignment and no mutable data types
        * Name-value bindings are permanent
    
    2. Advantage: 
        * Value of expression is independent of order of sub-expression evaluation, sub-expression can be evaluated in parallel or in demand(lazily)
        * Referential transparency: expression value does not change if sub-expression is replaced by its value

2. Iteration: Implementation of Scheme are required to be properly tail-recursive, this allows the execution of an iterative computation in constant space ($\Theta(1)$), even if the iterative computation is described by a syntactically recursive procedure

3. Tail calls:
    1. A procedure call that has not returned is active, some procedure calls are tail calls. A scheme interpreter should have an unbounded number of tail calls using only a constant amount of space
    2. A tail call is a call expression in a tail context, for example:
        * The last body sub-expression in a lambda expression
        * Sub-expression 2 & sub-expression in a tail context `if` expression, namely, the consequent expression and the alternative expression
        * All non-predicate sub-expresions in a tail context `cond` expression
        * The last sub-expression in a tail context `and` or `or`
        * The last sub-expression in a tail context `begin`
    3. The return value of the tail call should be the return value of the current procedure call, in this way, tail calls don't increase environment size


# Lecture 30 2018/11/02

1 A scheme expression is a scheme list:

1. A scheme expression is a scheme list
    * Expression: primitive expression and combination
    * Eval a scheme list of expressions return the value of the expression

<br>

2 Macros:

1. A macro is an operation performed on source code before evaluation that allows you to define special forms
2. Scheme has a define-macro special form that defines a source code transformation
3. Evaluation procedure of a macro call expression:
    1. Evaluate the operator sub-expression, which evaluates to a macro
    2. Call the macro procedure on the operand expressions withouth evaluating them first

<br>

3 Quasi-quotation

```scheme
;quotation
(define b 2)
'(a b c); The result is (a b c)
;quasi-quotation
`(a b c); The result is (a b c)
`(a ,b c); The result is (a 2 c)

```

# Lab 11

1 Two programing languages for an interpreter:

1. The language being interpretered
2. The underlying implementation language

For Python interpreter, the first is of course Python itself. The most common Python interpreter `CPython` is implemented using C, another popular Python interpreter `PyPy` is written in Python.

2 The REPL

1. Read: The interpreter takes the user input (a string) and passes it through a lexer and parser
    
    * The lexer turns the user input string into atomic pieces (tokens) that are like "words" of the implemented language
    * The parser takes the tokens and organizes them into data structures that the underlying language can understan

2. Eval: Mutual recursion between eval and apply evaluate the expression to obtain a value

    * Eval takes an expression and evaluates it according to the rules of the language. Evaluating a call expression involves calling apply to apply an evaluated operator to its evaluated operands
    * Apply takes an evaluated operator, i.e., a function, and applies it to the call expression's arguments. Apply may call eval to do more work in the body of the function, so eval and apply are mutually recursive

3. Print: Display the result of evaluating the user input

```

        +-------------------------------- Loop -----------+
        |                                                 |
        |  +-------+   +--------+   +-------+   +-------+ |
Input ---+->| Lexer |-->| Parser |-->| Eval  |-->| Print |-+--> Output
        |  +-------+   +--------+   +-------+   +-------+ |
        |                              ^  |               |
        |                              |  v               |
        ^                           +-------+             v
        |                           | Apply |             |
        |    REPL                   +-------+             |
        +-------------------------------------------------+
```