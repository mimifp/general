############################
### Names and namespaces ###
############################

#  Name (sometimes also called a symbolic name) is an identifier for an object.  In most programs, Python has to keep track of the hundreds and sometimes even thousands of names. So, how exactly does Python store all of this information? Well, it creates what is called a namespace. distinct types of namespaces that Python generates: Built-In, Global, Local and Enclosing. Differents script will generate differents namespaces.
# - built-in namespace is created when the interpreter is started and has a lifetime until the interpreter terminates (usually when our program is finished running). 
print(dir(__builtins__)) # access to builtins module

# - global namespace one level below. Anytime we use the import statement to bring in a new module into our program, instead of adding every name from that module (such as all the names in the random module) to our current global namespace, Python will create a new namespace for it.

print(' -- Globals Namespace with empty script -- \n')
print(globals())

global_variable = 'global'
print(globals())

def print_global():
  global_variable = 'nested global'
  nested_variable = 'nested value'

print(' \n -- Globals Namespace non-empty script -- \n')
print(globals())

# - local namespace is the deepest.
global_variable = 'global'


print(' -- Local and global Namespaces with empty script -- \n')
print(locals())
print('----------------------------------------------')
print(globals())

def divide(num1, num2):
  result = num1 / num2
  print(locals())

def multiply(num1, num2):
  product = num1 * num2
  print(locals())

print(' \n -- Local Namespace for divide -- \n')
divide(3, 4)

print(' \n -- Local Namespace for multiply -- \n')
multiply(4, 50)

print(' \n -- Local Namespace final -- \n')
print(locals())

# - enclosing namespace is a namespace created by an enclosing function and any number of enclosed functions inside it. Enclosing namespaces are created specifically when we work with nested functions and just like with the local namespace, will only exist until the function is done executing.