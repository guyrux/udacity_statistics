names =  list(input("Enter names separated by commas: ").split(",")) # get and process input for a list of names
assignments = list(input("Enter assignments separated by commas: ").split(",")) # get and process input for a list of the number of assignments
grades = list(input("Enter grades separated by commas: ").split(",")) # get and process input for a list of grades

# message string to be used for each student
# HINT: use .format() with this string in your for loop
for i, name in enumerate(names):
    message = "Hi {},\n\nThis is a reminder that you have {} assignments left to \
    submit before you can graduate. You're current grade is {} and can increase \
    to {} if you submit all assignments before the due date.\n\n".format(name,assignments[i], \
    grades[i], float(grades[i]) + 2*float(assignments[i]) )

    print("\n" + message)


# write a for loop that iterates through each set of names, assignments, and grades to
# print each student's message