import tkinter as tk
from tkinter import messagebox
from functools import partial


class TicTacToe:
    def __init__(self, root):
        self.root = root
        self.root.title("Tic Tac Toe")

        self.board = ["" for _ in range(9)]
        self.current_player = "X"
        self.game_active = True
        self.buttons = []

        self.create_widgets()

    def create_widgets(self):
        """Creates the 3x3 grid of buttons for the game board."""
        for i in range(9):
            btn = tk.Button(self.root, text="", font=("Arial", 20), height=2, width=5,
                            command=partial(self.on_click, i))  # Use partial instead of lambda
            btn.grid(row=i // 3, column=i % 3)
            self.buttons.append(btn)

    def on_click(self, index):
        """Handles button clicks and updates the game state."""
        if not self.game_active or self.board[index] != "":
            return

        self.board[index] = self.current_player
        self.buttons[index].config(text=self.current_player, state=tk.DISABLED)

        if self.check_winner(self.current_player):
            messagebox.showinfo("Game Over", f"Player {self.current_player} wins!")
            self.game_active = False
            self.root.after(1000, self.reset_board)
            return
        elif "" not in self.board:
            messagebox.showinfo("Game Over", "It's a tie!")
            self.game_active = False
            self.root.after(1000, self.reset_board)
            return

        self.current_player = "O" if self.current_player == "X" else "X"

    def check_winner(self, player):
        """Checks if the given player has won the game."""
        win_patterns = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]
        return any(all(self.board[i] == player for i in pattern) for pattern in win_patterns)

    def reset_board(self):
        """Resets the game board for a new round."""
        self.board = ["" for _ in range(9)]
        self.current_player = "X"
        self.game_active = True
        for button in self.buttons:
            button.config(text="", state=tk.NORMAL)


if __name__ == "__main__":
    root = tk.Tk()
    game = TicTacToe(root)
    root.mainloop()
