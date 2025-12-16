import random

# -----------------------------
# GLOBAL CONSTANTS
# -----------------------------

# Maximum number of horizontal lines the user can bet on
MAX_LINES = 3

# Betting limits per line
MAX_BET = 100
MIN_BET = 1

# Slot machine grid size (3x3)
ROWS = 3
COLS = 3

# Symbol distribution: higher count = more common = lower value
symbol_count = {
    "A": 2,
    "B": 4,
    "C": 6,
    "D": 8
}

# Payout values for each symbol
symbol_value = {
    "A": 5,
    "B": 4,
    "C": 3,
    "D": 2
}


# -----------------------------
# GAME LOGIC FUNCTIONS
# -----------------------------

def check_winnings(columns, lines, bet, values):
    """
    Checks each bet line to determine if all symbols match.
    If a line wins, payout = symbol value * bet amount.

    Args:
        columns (list): 2D list representing the slot machine spin.
        lines (int): Number of lines the user bet on.
        bet (int): Bet amount per line.
        values (dict): Symbol payout values.

    Returns:
        tuple: (total winnings, list of winning line numbers)
    """
    winnings = 0
    winning_lines = []

    # Loop through each line the user bet on
    for line in range(lines):
        symbol = columns[0][line]  # Symbol in the first column for this line

        # Check if all columns match the first symbol
        for column in columns:
            symbol_to_check = column[line]
            if symbol != symbol_to_check:
                break
        else:
            # All symbols matched → this line wins
            winnings += values[symbol] * bet
            winning_lines.append(line + 1)

    return winnings, winning_lines


def get_slot_machine_spin(rows, cols, symbols):
    """
    Generates a random slot machine spin based on symbol frequency.

    Args:
        rows (int): Number of rows in the slot machine.
        cols (int): Number of columns.
        symbols (dict): Symbol distribution.

    Returns:
        list: 2D list representing the slot machine columns.
    """
    # Create a list of all symbols, repeated by their frequency
    all_symbols = []
    for symbol, symbol_count in symbols.items():
        for _ in range(symbol_count):
            all_symbols.append(symbol)

    columns = []

    # Build each column independently
    for _ in range(cols):
        column = []
        current_symbols = all_symbols[:]  # Copy to avoid modifying original

        # Randomly pick symbols for each row
        for _ in range(rows):
            value = random.choice(current_symbols)
            current_symbols.remove(value)
            column.append(value)

        columns.append(column)

    return columns


def print_slot_machine(columns):
    """
    Prints the slot machine grid in a readable format.
    """
    for row in range(len(columns[0])):
        for i, column in enumerate(columns):
            # Print with separators except for last column
            if i != len(columns) - 1:
                print(column[row], end=" | ")
            else:
                print(column[row], end="")
        print()  # Newline after each row


# -----------------------------
# USER INPUT FUNCTIONS
# -----------------------------

def deposit():
    """
    Prompts the user to deposit money and validates input.
    """
    while True:
        amount = input("What would you like to deposit? $")
        if amount.isdigit():
            amount = int(amount)
            if amount > 0:
                break
            else:
                print("Amount must be greater than 0.")
        else:
            print("Please enter a number.")

    return amount


def get_number_of_lines():
    """
    Asks the user how many lines they want to bet on.
    """
    while True:
        lines = input(f"Enter the number of lines to bet on (1-{MAX_LINES}): ")
        if lines.isdigit():
            lines = int(lines)
            if 1 <= lines <= MAX_LINES:
                break
            else:
                print("Enter a valid number of lines.")
        else:
            print("Please enter a number.")

    return lines


def get_bet():
    """
    Prompts the user for a bet amount per line.
    """
    while True:
        amount = input("What would you like to bet on each line? $")
        if amount.isdigit():
            amount = int(amount)
            if MIN_BET <= amount <= MAX_BET:
                break
            else:
                print(f"Amount must be between ${MIN_BET} - ${MAX_BET}.")
        else:
            print("Please enter a number.")
    return amount


# -----------------------------
# GAME ROUND FUNCTION
# -----------------------------

def spin(balance):
    """
    Handles a full round of betting, spinning, and payout calculation.

    Args:
        balance (int): Player's current balance.

    Returns:
        int: Net winnings (can be negative if the player loses).
    """
    lines = get_number_of_lines()

    # Ensure the user has enough balance for their bet
    while True:
        bet = get_bet()
        total_bet = bet * lines

        if total_bet > balance:
            print(f"You do not have enough to bet that amount. Current balance: ${balance}")
        else:
            break

    print(f"You are betting ${bet} on {lines} lines. Total bet: ${total_bet}")

    # Spin the slot machine
    slots = get_slot_machine_spin(ROWS, COLS, symbol_count)
    print_slot_machine(slots)

    # Calculate winnings
    winnings, winning_lines = check_winnings(slots, lines, bet, symbol_value)
    print(f"You won ${winnings}.")
    print("Winning lines:", *winning_lines)

    return winnings - total_bet


# -----------------------------
# MAIN GAME LOOP
# -----------------------------

def main():
    """
    Main game loop: handles deposits, repeated spins, and quitting.
    """
    balance = deposit()

    while True:
        print(f"Current balance: ${balance}")
        answer = input("Press Enter to play (q to quit): ")

        if answer == "q":
            break

        balance += spin(balance)

    print(f"You left with ${balance}")


# Start the game
main()
