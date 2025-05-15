-- Create empty tables.
--------------------------------------

CREATE TABLE actual_shortage (
    org_id INTEGER,
    pwsid TEXT,
    supplier_name TEXT,
    state_standard_shortage_level INTEGER,
    start_date DATE,
    end_date DATE
);

CREATE TABLE monthly_forecast (
    org_id INTEGER,
    pwsid TEXT,
    supplier_name TEXT,
    start_date DATE,
    end_date DATE,
    forecasted_shortage_level INTEGER
);

-- Load Data into our tables and associated types.
--------------------------------------

INSERT INTO actual_shortage
SELECT 
    org_id::INTEGER,
    pwsid::TEXT,
    supplier_name::TEXT,
    state_standard_shortage_level::INTEGER,
    start_date::DATE,
    end_date::DATE
FROM read_csv_auto('data/cleaned/actual_shortage_clean.csv', header = True);

INSERT INTO monthly_forecast
SELECT 
    org_id::INTEGER,
    pwsid::TEXT,
    supplier_name::TEXT,
    start_date::DATE,
    end_date::DATE,
    state_standard_shortage_level::INTEGER AS forecasted_shortage_level
FROM read_csv_auto('data/cleaned/monthly_outlook_clean.csv', header = True);

-- Create yearly aggregate temp tables.
--------------------------------------

CREATE TEMP TABLE actual_shortage_yearly_avg AS 
SELECT 
    org_id,
    pwsid,
    supplier_name,
    EXTRACT(year FROM start_date) AS year,
    AVG(state_standard_shortage_level) AS avg_actual_shortage_level
FROM actual_shortage
GROUP BY org_id, pwsid, supplier_name, year;

CREATE TEMP TABLE forecast_shortage_yearly_avg AS 
SELECT 
    org_id,
    pwsid,
    supplier_name,
    EXTRACT(year FROM start_date) AS year,
    AVG(forecasted_shortage_level) AS avg_forecasted_shortage_level
FROM monthly_forecast
WHERE EXTRACT(year FROM start_date) >= 2024
GROUP BY org_id, pwsid, supplier_name, year;

-- Combine temp yearly aggregate tables into a combined table.
--------------------------------------

CREATE TABLE combined_yearly_avg AS 
SELECT 
    org_id,
    pwsid,
    supplier_name,
    year,
    avg_actual_shortage_level AS avg_shortage_level,
    'Actual' AS data_type -- give data_type column to see diff between actual/forecasted.
FROM actual_shortage_yearly_avg

UNION ALL

SELECT 
    org_id,
    pwsid,
    supplier_name,
    year,
    avg_forecasted_shortage_level AS avg_shortage_level,
    'Forecasted' AS data_type -- give data_type column to see diff between actual/forecasted.
FROM forecast_shortage_yearly_avg

ORDER BY year, org_id, pwsid, data_type;
