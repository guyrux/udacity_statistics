def somatorio(lista):
    total = 0
    for item in lista:
        total += float(item)
    return total

def produtorio(lista):
    total = 1
    for item in lista:
        total *= float(item)
    return total