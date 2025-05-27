import tkinter as tk
from tkinter import messagebox
import sqlite3
import datetime

# ----- Base de datos -----
def crear_base_datos():
    conn = sqlite3.connect("restaurante.db")
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS pedidos (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fecha TEXT,
            producto TEXT,
            cantidad INTEGER,
            subtotal REAL,
            total REAL
        )
    """)
    conn.commit()
    conn.close()

def guardar_pedido(producto, cantidad, subtotal, total):
    conn = sqlite3.connect("restaurante.db")
    cursor = conn.cursor()
    fecha = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    cursor.execute("INSERT INTO pedidos (fecha, producto, cantidad, subtotal, total) VALUES (?, ?, ?, ?, ?)",
                   (fecha, producto, cantidad, subtotal, total))
    conn.commit()
    conn.close()

# ----- Menú y lógica -----
menu = {
    "Hamburguesa": 5.0,
    "Pizza": 8.0,
    "Ensalada": 4.5,
    "Bebida": 2.0,
    "Postre": 3.5
}

def calcular_total():
    total = 0
    recibo.delete("1.0", tk.END)
    recibo.insert(tk.END, "---- RECIBO ----\n")

    for plato, entry in entradas.items():
        try:
            cantidad = int(entry.get())
            if cantidad > 0:
                subtotal = cantidad * menu[plato]
                total += subtotal
                recibo.insert(tk.END, f"{plato} x{cantidad} = ${subtotal:.2f}\n")
                guardar_pedido(plato, cantidad, subtotal, total)  # Guardar en BD
        except ValueError:
            messagebox.showerror("Error", f"Cantidad inválida para {plato}")
            return

    recibo.insert(tk.END, f"\nTOTAL: ${total:.2f}")

# ----- Interfaz gráfica -----
root = tk.Tk()
root.title("Sistema de Pedidos - Restaurante")

tk.Label(root, text="Menú", font=("Helvetica", 16)).grid(row=0, column=0, pady=10)

entradas = {}
for i, (plato, precio) in enumerate(menu.items(), start=1):
    tk.Label(root, text=f"{plato} - ${precio:.2f}").grid(row=i, column=0, sticky="w", padx=10)
    entrada = tk.Entry(root, width=5)
    entrada.grid(row=i, column=1)
    entradas[plato] = entrada

tk.Button(root, text="Calcular Total", command=calcular_total, bg="green", fg="white").grid(row=len(menu)+1, column=0, columnspan=2, pady=10)

recibo = tk.Text(root, height=10, width=40)
recibo.grid(row=len(menu)+2, column=0, columnspan=2)

# Inicializar base de datos
crear_base_datos()

root.mainloop()
