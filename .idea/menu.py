import json
import os

MENU_FILE = 'data/menu.json'

def cargar_menu():
    if not os.path.exists(MENU_FILE):
        return []
    with open(MENU_FILE, 'r', encoding='utf-8') as file:
        return json.load(file)

def guardar_menu(menu):
    with open(MENU_FILE, 'w', encoding='utf-8') as file:
        json.dump(menu, file, indent=4)

def agregar_plato(nombre, precio, categoria):
    menu = cargar_menu()
    nuevo_plato = {
        "nombre": nombre,
        "precio": precio,
        "categoria": categoria
    }
    menu.append(nuevo_plato)
    guardar_menu(menu)
    print(f"✅ Plato '{nombre}' agregado al menú.")

def mostrar_menu():
    menu = cargar_menu()
    if not menu:
        print("📭 El menú está vacío.")
        return

    print("\n📋 MENÚ DEL RESTAURANTE:")
    for idx, plato in enumerate(menu, 1):
        print(f"{idx}. {plato['nombre']} - ${plato['precio']} ({plato['categoria']})")
