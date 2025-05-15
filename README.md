# **California Drought Data Analysis**  
*EDS 213 - Water Shortage Forecast Evaluation*

---

## **Project Overview**

This project explores California's historical and forecasted water shortage data.  

We aim to answer the question:  
**_"How have water shortage levels in California changed over time, and are they reasonably forecasted through time?"_**

Through cleaning, database structuring, SQL querying, and visualization, we look at how water shortage forecasts evolve over time and how well they align with actual reported shortages.

**Key to understanding shortage levels:**

0 = No Shortage
1 : < 10% Shortage 
2 : 10-19% Shortage
3 : 20-29% Shortage
4 : 30-39% Shortage
5 : 40-49% Shortage 
6 : Greater than 50% Shortage

![Database Diagram](images/dbdiagram.png)

---

## **Project Structure**

```plaintext
├── data/                        # All data files.
│   ├── actual_water_shortage_level.csv
│   ├── monthly_water_shortage_outlook.csv
│   ├── cleaned/                 # Cleaned data for database loading.
│   │   ├── actual_shortage_clean.csv
│   │   └── monthly_outlook_clean.csv
│   └── results/                 # Outputted db results to csv.
│       └── combined_yearly_avg.csv
├── query_viz_files/             # Render files for query_viz.qmd/.html.
├── shortage_db.duckdb           # Final DuckDB database.
├── shortage_db.sql              # SQL script to create and populate database.
├── initial_data_cleaning.R      # R script for data prep/cleaning.
├── query_viz.qmd / .html        # Visualization & report.
└── README.md                    # Your are here!
```

---

## **Key Files Explained**

- `data/`: Contains raw and cleaned datasets.
- `shortage_db.sql`: SQL script to build and populate the database.
- `shortage_db.duckdb`: Final database with all tables.
- `query_viz.qmd`: Final report where we visualize data.
- `initial_data_cleaning.R`: Data cleaning and pre-processing script.

---

## **How to Reproduce This Project**

1. **Run Data Cleaning Script: initial_data_cleaning.R**

Produced cleaned output files for our sql tables.

2. **Set Up the Database:**

```bash
duckdb shortage_db.duckdb < shortage_db.sql
```

3. **Run the Visualization:**
   - Run/Render `query_viz.qmd` to view results and plots.

---

**Primary Tools Used:**
- DuckDB: v1.2.2  
- R Version: 4.2.3  
- R Packages:
  - DBI 1.1.3  
  - duckdb 1.2.2  
  - ggplot2 3.5.1  
  - dplyr 1.1.4  
  - janitor  
  - readr

**Full list of dependencies and environment info and be found in this repository inside `dependencies.txt`**

---

