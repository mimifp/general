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
def add_tax(total):
  tax = total * 0.06
  new_total = total + tax
  return new_total

def add_tip(total):
  tip = total * .2
  new_total = total + tip
  return new_total

def total_bill(func, value):
  total = func(value)
  return ("The total amount owed is $" + "{:.2f}".format(total) + ". Thank you! :)")
 
 
print(total_bill(add_tax, 100))
print(total_bill(add_tip, 100))

### Iteration ###
bills = [115, 120, 42]
 
new_bills = []
 
for i in range(len(bills)):
  total = add_tax(bills[i])
  new_bills.append("Total amount owed is $" + "{:.2f}".format(total) + ". Thank you! :)")
 
print(new_bills)

## ----------------------------------------------------------------------------- ##

def total_bills(func, list):
  # This list will store all the new bill values
  new_bills = []
 
  # This loop will iterate through our bills
  for i in range(len(list)):
 
    # Here we apply the function to each element of the list!
    total = func(list[i])
    new_bills.append("Total amount owed is $" + "{:.2f}".format(total) + ". Thank you! :)")
 
  return new_bills

bills = [115, 120, 42]
 
bills_w_tax = total_bills(add_tax, bills)
 
print(bills_w_tax)

### Functions as Return Values ###
def make_box_volume_function(height):
    # defines and returns a function that takes two numeric arguments,        
    # length &  width, and returns the volume given the input height
    def volume(length, width):
        return length*width*height
 
    return volume
 
box_volume_height15 = make_box_volume_function(15)
 
print(box_volume_height15(3,2))

### MAP function ### 