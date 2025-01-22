import tkinter as tk
import math

# Function to handle arithmetic operations
def add(a, b):
    return a + b

def subtract(a, b):
    return a - b

def multiply(a, b):
    return a * b

def divide(a, b):
    if b == 0:
        raise ZeroDivisionError("Cannot divide by zero")
    return a / b

# Function to calculate square root
def square_root(a):
    if a < 0:
        raise ValueError("negative number")
    return math.sqrt(a)

# Function to handle button clicks
def button_click(value):
    current = display_var.get()
    display_var.set(current + value)

# Function to clear the display
def clear_display():
    display_var.set("")

# Function to perform calculations
def calculate():
    try:
        expression = display_var.get().replace("^", "**")  # Support for exponentiation
        result = eval(expression)
        display_var.set(str(result))
    except ZeroDivisionError:
        display_var.set("Error: Division by Zero")
    except ValueError:
        display_var.set("Error: Invalid Input")
    except SystemError:
        display_var.set("Error")


# Function to delete the last digit
def delete_last_digit():
    current = display_var.get()
    display_var.set(current[:-1])


# Create the main application window
root = tk.Tk()
root.title("Mohamed Rimsan Calculator")
root.configure(bg="#ADD8E6")

# Display area
display_var = tk.StringVar()
display = tk.Entry(root, textvariable=display_var, font=("Arial", 20), bd=10, insertwidth=2, width=18, justify="right")
display.grid(row=0, column=0, columnspan=10, padx=10, pady=10)

# Define the layout for buttons
buttons = [
    ("7", 1, 0), ("8", 1, 1), ("9", 1, 2), ("/", 1, 3), ("√", 1, 4),
    ("4", 2, 0), ("5", 2, 1), ("6", 2, 2), ("*", 2, 3), ("^", 2, 4),
    ("1", 3, 0), ("2", 3, 1), ("3", 3, 2), ("-", 3, 3), ("+", 3, 4),
    ("0", 4, 1), ("=", 4, 2), ("Del", 4, 3),(".", 4, 0),("C", 4, 4),
]

# Add buttons to the grid
for (text, row, col) in buttons:
    if text == "=":
        btn = tk.Button(root, text=text, padx=20, pady=20, font=("Arial", 14), bg="#4CAF50", fg="white", command=calculate)
    elif text == "C":
        btn = tk.Button(root, text=text, padx=20, pady=20, font=("Arial", 14), bg="#f44336", fg="white", command=clear_display)
    elif text == "√":
        btn = tk.Button(root, text=text, padx=20, pady=20, font=("Arial", 14), bg="#ff9800", fg="white", command=lambda: display_var.set(str(square_root(float(display_var.get())))) if display_var.get() else None)
    elif text == "Del":
        btn = tk.Button(root, text=text, padx=20, pady=20, font=("Arial", 14), bg="#e7e7e7", command=delete_last_digit)
    else:
        btn = tk.Button(root, text=text, padx=20, pady=20, font=("Arial", 14), bg="#e7e7e7", command=lambda t=text: button_click(t))
    btn.grid(row=row, column=col, padx=5, pady=5)

root.mainloop()
