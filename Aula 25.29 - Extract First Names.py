'''
Quiz: Extract First Names

Use a list comprehension to create a new list first_names containing just the first names in names in lowercase.
'''
names = ["Rick Sanchez", "Morty Smith", "Summer Smith", "Jerry Smith", "Beth Smith"]

first_names = [name.lower().split()[0] for name in names] # write your list comprehension here

print(first_names)