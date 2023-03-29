##########################
### Function Arguments ###
##########################

tables = {
  1: ['Jiho', False],
  2: [],
  3: [],
  4: [],
  5: [],
  6: [],
  7: [],
}
print(tables)


def assign_table(table_number, name, vip_status = False):
  tables[table_number] = [name, vip_status]
  print(tables)

assign_table(6, 'Yoni', False)
assign_table(table_number = 3, name = 'Martha', vip_status = True)
assign_table(4, 'Karla')

### Variable Number of Arguments ###
def print_order(*order_items):
  print(order_items)

print_order('Orange Juice', 'Apple Juice', 'Scrambled Eggs', 'Pancakes')

### Combine unpacking operator ###
tables = {
  1: {
    'name': 'Jiho',
    'vip_status': False,
    'order': 'Orange Juice, Apple Juice'
  },
  2: {},
  3: {},
  4: {},
  5: {},
  6: {},
  7: {},
}

def assign_table(table_number, name, vip_status=False): 
  tables[table_number]['name'] = name
  tables[table_number]['vip_status'] = vip_status
  tables[table_number]['order'] = ''

def assign_and_print_order(table_number, *order_items):
  tables[table_number]['order'] = order_items
  print(tables)
  for item in order_items:
    print(item)
  
assign_table(2, 'Arwa', True)
assign_and_print_order(2, 'Steak', 'Seabass', 'Wine Bottle')

### Variable number of arguments ###
tables = {
  1: {
    'name': 'Chioma',
    'vip_status': False,
    'order': {
      'drinks': 'Orange Juice, Apple Juice',
      'food': 'Pancakes'
    }
  },
  2: {},
  3: {},
  4: {},
  5: {},
  6: {},
  7: {},
}


# Write your code below: 
def assign_food_items(**order_items):
  print(order_items)
  food = order_items.get('food')
  drinks = order_items.get('drinks')
  print(food)
  print(drinks)

assign_food_items(food = 'Pancakes, Poached Egg', drinks = 'Water')

### Working with **kwargs ###
tables = {
  1: {
    'name': 'Chioma',
    'vip_status': False,
    'order': {
      'drinks': 'Orange Juice, Apple Juice',
      'food_items': 'Pancakes'
    }
  },
  2: {},
  3: {},
  4: {},
  5: {},
  6: {},
  7: {},
}

def assign_table(table_number, name, vip_status = False): 
  tables[table_number]['name'] = name
  tables[table_number]['vip_status'] = vip_status
  tables[table_number]['order'] = {}

assign_table(2, 'Douglas', True)
print('--- tables with Douglas --- \n', tables)

def assign_food_items(table_number, **order_items):
  food = order_items.get('food')
  drinks = order_items.get('drinks')
  tables[table_number]['order']['food_items'] = food
  tables[table_number]['order']['drinks'] = drinks

assign_food_items(2, food = 'Seabass, Gnocchi, Pizza', drinks = 'Margarita, Water')

print('\n --- tables after update --- \n', tables)

### All together ###
def single_prix_fixe_order(appetizer, *entrees, sides, **dessert_scoops):
  print(appetizer)
  print(entrees)
  print(sides)
  print(dessert_scoops)

single_prix_fixe_order('Baby Beets', 'Salmon', 'Scallops', sides = 'Mashed Potatoes', ice_cream_scoop = 'Vanilla', dessert_scoop = 'Cookies and Cream')


### Function Call Unpacking & Beyond ###
def calculate_price_per_person(total, tip, split):
  total_tip = total * (tip/100)
  split_price = (total + total_tip) / split
  print(split_price)

table_7_total = [534.50, 20.0, 5]
calculate_price_per_person(*table_7_total)

### Review ###
tables = {
  1: {
    'name': 'Jiho',
    'vip_status': False,
    'order': {
      'drinks': 'Orange Juice, Apple Juice',
      'food_items': 'Pancakes',
      'total': [534.50, 20.0, 5]
    }
  },
  2: {},
  3: {},
  4: {},
  5: {},
  6: {},
  7: {},
}

def assign_table(table_number, name, vip_status=False): 
  tables[table_number]['name'] = name
  tables[table_number]['vip_status'] = vip_status
  tables[table_number]['order'] = {}

def assign_food_items(table_number, **order_items):
  food = order_items.get('food')
  drinks = order_items.get('drinks')
  tables[table_number]['order']['food_items'] = food
  tables[table_number]['order']['drinks'] = drinks

def calculate_price_per_person(total, tip, split):
    total_tip = total * (tip/100)
    split_price = (total + total_tip) / split
    print(split_price)