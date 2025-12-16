# Portfolio-Projects

See Covid Data Exploration

🦠 COVID‑19 Data Exploration (SQL Project)
This project explores global COVID‑19 data using advanced SQL techniques. It analyzes infection trends, death rates, vaccination progress, and population‑level impacts across countries and continents. The goal is to demonstrate strong SQL skills while uncovering meaningful insights from real‑world data.

📊 Project Overview
Using two datasets — CovidDeaths and CovidVaccinations — this project performs a full exploratory analysis, including:
- Infection rates
- Death percentages
- Population impact
- Vaccination rollout
- Global and regional comparisons
The queries are written for Microsoft SQL Server and make extensive use of analytical SQL features.

🛠️ Skills Demonstrated
This project highlights proficiency in:
- Joins (inner joins for combining datasets)
- Common Table Expressions (CTEs)
- Temp Tables
- Window Functions (OVER, PARTITION BY, running totals)
- Aggregate Functions (SUM, MAX, CAST, CONVERT)
- Data Type Conversions
- Creating Views for BI tools
- Data cleaning & filtering

📂 Data Sources
The project uses two tables:
- CovidDeaths$ — case counts, deaths, population, location metadata
- CovidVaccinations$ — vaccination counts by date and location
Both tables are assumed to come from the Our World in Data COVID‑19 dataset.

🔍 Key Analyses Performed
1. Initial Data Exploration
Previewing raw data and selecting relevant fields such as:
- Location
- Date
- Total cases
- New cases
- Total deaths
- Population

2. Case Fatality Analysis
Calculating the likelihood of death after contracting COVID‑19:
(total_deaths / total_cases) * 100


Filtered for specific regions (e.g., United States).

3. Infection Rate vs Population
Determining what percentage of each country’s population was infected.

4. Highest Infection Rates
Finding countries with the highest infection counts and infection percentages.

5. Highest Death Counts
Identifying:
- Countries with the highest total deaths
- Continents with the highest total deaths

6. Global Aggregations
Summing global cases and deaths to calculate worldwide death percentages.

7. Vaccination Progress
Joining deaths and vaccination tables to calculate:
- Daily vaccinations
- Rolling total of people vaccinated
- Percentage of population vaccinated
This uses a window function to compute cumulative totals.

8. CTE for Vaccination Analysis
A CTE (POPvsVAC) is used to simplify repeated calculations and improve readability.

9. Temp Table for Reusable Calculations
A temporary table stores vaccination progress for further analysis or visualization.









See Slot Machine Project



🎰 Python Slot Machine Game
A fully interactive command‑line slot machine game built in Python. This project simulates a classic 3×3 slot machine where players can deposit money, place bets across multiple lines, spin the reels, and win based on symbol probabilities and payout values. It’s designed to demonstrate clean logic, modular functions, user input validation, and randomized game mechanics.

🚀 Features
- Deposit system to manage player balance
- Configurable betting across 1–3 lines
- Randomized slot machine spins based on weighted symbol distribution
- Automatic winnings calculation using symbol values
- Clear, user‑friendly CLI interface
- Modular, well‑commented code suitable for learning and portfolio use

🧠 How It Works
- The player deposits money to start.
- They choose how many lines to bet on and how much to bet per line.
- The slot machine generates a random 3×3 grid using weighted symbols.
- If all symbols match on a bet line, the player wins based on the symbol’s payout value.
- The game continues until the player chooses to quit.

🛠️ Technologies Used
- Python 3
- Built‑in modules (random)
- Clean, modular function design

📂 Project Structure
slot_machine.py


All game logic is contained in a single, well‑organized Python file with detailed comments explaining each block of code.

🎯 Purpose
This project was created to strengthen Python fundamentals, practice clean code structure, and build a fun, interactive program suitable for showcasing in a professional portfolio.


