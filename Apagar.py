N = int(input("Insert a interger between 1 and 100: "))

if N < 1 or N > 100:
    print("Insert a interger between 1 and 100: ")
else:
    if N % 2 == 0 and 6 <= N <= 20:
        print("Weird")
    elif (N % 2 == 0 and 2 <= N <= 5) or N > 20:
        print("Not Weird")
    elif N % 2 != 0:
        print("Weird")