# Lecture 1

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