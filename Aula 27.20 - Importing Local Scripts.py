import funcoes
import math

temporario = "s"
continuar = True

while continuar:
    l = list(input("Digite uma lista de números separados por vírgula: ").split(","))
    # print(l,type(l))
    print("O somatório é {} e o produtório é {}.".format(funcoes.somatorio(l),funcoes.produtorio(l)))
    temporario = input("Deseja continuar? (s/n) ")
    if temporario == "s":
        continuar = True
    else:
        continuar = False

print("Muito obrigado!")