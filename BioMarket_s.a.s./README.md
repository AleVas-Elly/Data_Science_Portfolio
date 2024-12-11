# Management software for BioMarket s.a.s (Vegan Store)

BioMarket s.a.s wants me to develop a small management software for their new shop
The software must let the user:
- Register new products with name, quantity, selling price, and purchase price.
- List all available products.
- Record completed sales.
- Display gross and net profits.
- Show a help menu with all available commands.
- Handle possible mistakes of the user.

The software will be text-based, and usable from the command line.


## Requirements

- *python3*: any version
- *os modul*e: usually pre-intalled with python3
- *json module*: usually pre-intalled with python3

Check out the [Useful Resources](#useful-resources) paragraph for more info.

## Usage

Download BioMarket_s.a.s folder on ur computer. You are gonna find a python script named BioMarket_management.py in it.
Copy the script in the folder you want the inventory file to be created in.

alternatively open the file and change the variable 

```inventory_path``` in ```main()```

to the global path you want the file to be created.

Make BioMarket_s.a.s folder the current directory and on your console run:

```console
python3 BioMarket_management.py
```

Using the software is pretty straight forward.
Use the command ```help()``` to have the list of possible commands.

### **ATTENTION!!!**
By design, the inventory is saved on the file, only and only through the function exit(), therefore all the changes made in the session are not gonna be permanent if the program is quitted abruptly.
This has been implemeted this way because explicitly asked by the contractor




## Useful resources: 

- [How to install python3](https://www.geeksforgeeks.org/download-and-install-python-3-latest-version/)
- [How to install the os module](https://www.geeksforgeeks.org/how-to-install-os-sys-module-in-python/)
- [How to install the json module](https://www.geeksforgeeks.org/add-json-library-in-python/)



