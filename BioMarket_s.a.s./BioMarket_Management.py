import os
import json


def load_data(path):

  '''
  Loads inventory.json file in a json object if the file already exists. 
  Otherwise it returns a json object of the type: {"Inventory":{}, "Sales":{"gross":0, "net":0}}

  Arguments:
    path: path which inventory.json has been created/will be created

  Returns:
    json object: where the content of the json file has been/will be loaded

  '''

  if os.path.exists(path + "inventory.json"):
    with open(path + "inventory.json", "r") as json_file:
      return json.load(json_file)
  else:
    return {"Inventory":{}, "Sales":{"gross":0, "net":0}}



def display_help():

  '''
  Displays a list of all possible commands.

  command_list is the list of all possible commands

  Arguments:
    None

  Returns:
    None

  '''

  command_list = ["\nAvailable commands are: ", 
                  "- add: to add a product to inventory",
                  "- list: to list the products in inventory",
                  "- sell: registers a sale",
                  "- profit: shows the total profit",
                  "- help: shows the possible commands",
                  "- exit: exits the program and saves all changes"]

  print(*command_list, sep='\n')



def save_data(data, path):

  '''
  Saves the data in the inventory.json file

  Using the json.dump function it dumps the content of the json object data in the inventory.json file.
  The file is overwritten each time, this is sth to work on to make the program more efficient

  Arguments:
    data: json object containing all the info about the inventory
    path: path of the inventory.json file

  Returns:
    None

  '''

  with open (path + "inventory.json", "w") as json_file:
    json.dump(data, json_file, indent = "\t\t")



def add(data):

  '''
  Adds a specified amount of an item to the json object(data) updating the net profit

  Adds a specified amount, sell price and purchase price of an item if the item is not already present in the file.
  Otherwise it just adds the amount without having to specify anything else.
  Updates the net profit in the json object
  Eventually it prints out a confirm message each time sth is added and asks if the user wants to add sth more.

  Arguments:
    data: json object containing all the info about the inventory

  Returns:
    None

  '''

  another = "yes"
  while another == "yes":

      name = input("\nName of the product: ").strip().lower()

      try:
        amount = int(input("Amount: "))
      except ValueError:
        print("ERROR: Amounts can only be integers, please try adding again")
        continue
      if amount <= 0:
        print("ERROR: The amount has to be a positive integer, please try adding again")
        continue

      if name in data["Inventory"]:
        data["Inventory"][name]["Amount"] += amount

      else:
        try:
          purchase_price = round(float(input("Purchase price: ").strip().lower()),2)
        except ValueError:
          print("ERROR: Purchase price must be a positive number, please try adding again")
          continue
        if purchase_price < 0:
          print("ERROR: Purchase price must be a non negative integer, please try adding again")
          continue

        try:
          sell_price = round(float(input("Sell price: ").strip().lower()),2)
        except ValueError:
          print("ERROR: Sell price must be a positive number, please try adding again")
          continue
        if sell_price < 0:
          print("ERROR: Sell price must be a non negative integer, please try adding again")
          continue

        data["Inventory"][name] = { "Amount":amount,
                                    "Purchase price":purchase_price,
                                    "Sell price":sell_price }

      data['Sales']["net"] -= (amount * data['Inventory'][name]['Purchase price'])

      print(f"ADDED: {amount} X {name}\n")

      another = input("\nWould you like to add another item? [yes/no] ").strip().lower()

      while another != "yes" and another != "no":
        print("The only available options are 'yes' or 'no', please try again:\n")
        another = input("\nWould you like to add another item? [yes/no] ").strip().lower()



def list_items(data):

  '''
  Lists all the items present in the json object specifying amount and selling price.

  Arguments:
    data: json object containing all the info about the inventory

  Returns:
    None

  '''

  print(f"\nPRODUCT\t\t\tAMOUNT\tPRICE")
  for name, details in data['Inventory'].items():
    print(f"{name:<23} {details['Amount']:<7} {details['Sell price']}")



def sell(data):

  '''
  Reduces the amount of selected item in json object and updates gross and net profits

  If the amount of an item is equal to 0 after the sell it deletes it off the json object.
  Eventually checks if the user wants to sell sth else.
  Displays a confirmation message if the sell has been successful specifying what has been sold and how much it has been sold for.
  Displays the total earned through the sell.

  Arguments:
    data: json object containing all the info about the inventory

  Returns:
    None

  '''

  another = "yes"
  session_items = list()
  session_total = 0

  while another == "yes":
    name = input("\nName of the product: ").strip().lower()

    if name not in data['Inventory']:
      print("Selected product is not in the inventory\n")
      continue

    else:
      try:
        amount = int(input("Amount: "))
      except ValueError:
        print("ERROR: The amount must be an integer, please try adding again")
        continue

      if amount <= 0:
        print("ERROR: The amount must be a positive integer, please try adding again")
        continue

      if amount > data['Inventory'][name]['Amount']:
          print(f"There are just {data['Inventory'][name]['Amount']}X {name}! You can't sell {amount}")
          continue

      else:
        data['Inventory'][name]['Amount'] -= amount
        session_items.append((name, amount))
        data['Sales']["gross"] += (amount * data['Inventory'][name]['Sell price'])
        data['Sales']["net"] += (amount * data['Inventory'][name]['Sell price'])

    another = input("\nWould you like to sell another item? [yes/no] ").strip().lower()

    while another != "yes" and another != "no":
      print("The only available options are 'yes' or 'no', please try again: ")
      another = input("\nWould you like to sell another item? [yes/no] ").strip().lower()


  print("\nSALE HAS BEEN REGISTERED:\n")

  for n, a in session_items:
    print(f"- {a} X {n}: ${data['Inventory'][n]['Sell price']}\n")
    session_total += a * data['Inventory'][n]['Sell price']

  print(f"Total: ${round(session_total, 2)}")

  if data['Inventory'][name]['Amount'] == 0:
          del data['Inventory'][name]


def profit(data):

  '''
  Prints to screen gross and net profit.

  Arguments:
    data: json object containing all the info about the inventory

  Returns:
    None

  '''

  print(f"\nGross profit = {round(data['Sales']['gross'], 2)}$\n" +
        f"Net profit = {round(data['Sales']['net'], 2)}$ ")

def main():

  '''
  Runs an infinite loop asking for a new command. 
  
  It stops when the user enters the command "exit", printing a greetings message and breaking the cycle.
  If the user enters an unavailable command, it displays the list of all available commands

  '''

  inventory_path = "" #global path at which the user wants the inventory.json file
  data = load_data(inventory_path) #json object  
  command = ""

  while True:
    command = input("\n\nEnter a command: ").strip().lower()


    if command == "exit":
      save_data(data, inventory_path) #only instance in which the changes are finalized and saved to the inventory.json file
      print("bye bye")
      break
    elif command == "add":
      add(data)
    elif command == "help":
      display_help()
    elif command == "list":
      list_items(data)
    elif command == "sell":
      sell(data)
    elif command == "profit":
      profit(data)
    else:
      print("Selected command is not available.")
      display_help()

if __name__ == "__main__":
  main()

"""
Instructions are not followed to the letter in the add function, i just wanted to implement an extra functionality
to help the user experience.

Improvements:
Implementing a saving function each time an operation is made in order to save the 
file automatically after every change made by the user
Implement a back function to let the user go back to the main menu (Enter a command: ) when they make a mistake

"""
