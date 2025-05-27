from menu import agregar_plato, mostrar_menu

def main():
    while True:
        print("\n1. Agregar Plato\n2. Ver Menú\n3. Salir")
        opcion = input("Elige una opción: ")

        if opcion == "1":
            nombre = input("Nombre del plato: ")
            precio = float(input("Precio: "))
            categoria = input("Categoría: ")
            agregar_plato(nombre, precio, categoria)
        elif opcion == "2":
            mostrar_menu()
        elif opcion == "3":
            break
        else:
            print("Opción inválida")

if __name__ == "__main__":
    main()

