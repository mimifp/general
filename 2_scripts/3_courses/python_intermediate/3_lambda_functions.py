#######################
### Lamda functions ###
#######################

# In Python, a lambda function (also commonly called an anonymous function) is a one-line shorthand for function. 
# Normal function
def add_two(my_input):
  return my_input + 2

# Lamda function
add_two = lambda my_input: my_input + 2

check_if_A_grade = lambda grade: 'Got an A!' if grade >= 90 else 'Did not get an A.'

### Introduction to Higher-Order Functions ###
