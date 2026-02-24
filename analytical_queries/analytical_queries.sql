/* 
   AQI Lakehouse – Analytics Queries
   Database: aqi_gold
   Layer: Gold Aggregations
     */


/*  
   1. Daily AQI Trend by State (Last 30 Days)
     */
SELECT
    date,
    state,
    pollutant_id,
    avg_aqi
FROM aqi_gold.agg_daily_state
WHERE date >= date_sub(current_date(), 30)
ORDER BY state, date;



/*  
   2. Daily AQI Trend by City (Last 30 Days)
     */
SELECT
    date AS Date,
    state AS State,
    city AS City,
    pollutant_id AS Pollutant,
    ROUND(AVG(avg_aqi), 2) AS Average_AQI
FROM aqi_gold.agg_daily_city
WHERE date >= date_sub(current_date(), 30)
GROUP BY date, state, city, pollutant_id
ORDER BY State, City, Date;



/*  
   3. Pollutant Trend Comparison by State (Last 30 Days)
     */
SELECT
    date,
    state,
    pollutant_id,
    AVG(avg_aqi) AS avg_aqi
FROM aqi_gold.agg_daily_state
WHERE date >= date_sub(current_date(), 30)
GROUP BY date, state, pollutant_id
ORDER BY state, date;



/*  
   4. Hourly AQI Trend (Last 72 Hours)
     */
SELECT
    hour_ts,
    state,
    pollutant_id,
    avg_aqi
FROM aqi_gold.agg_hourly_state
WHERE hour_ts >= date_sub(current_timestamp(), 3)
ORDER BY state, hour_ts;



/*  
   5. AQI Threshold Breach Events (Last 7 Days)
     */
SELECT
    state,
    city,
    pollutant_id,
    event_ts,
    pollutant_avg
FROM aqi_gold.fact_threshold_breach
WHERE event_ts >= date_sub(current_timestamp(), 7)
ORDER BY event_ts DESC;



/*  
   6. Historical vs Recent AQI Comparison
     */
WITH classified AS (
    SELECT
        CASE 
            WHEN date BETWEEN date_sub(current_date(), 7) AND current_date()
            THEN 'Recent (Last 7 Days)'
            ELSE 'Historical'
        END AS Period,
        state AS State,
        pollutant_id AS Pollutant,
        avg_aqi
    FROM aqi_gold.agg_daily_state
)

SELECT
    Period,
    State,
    Pollutant,
    ROUND(AVG(avg_aqi), 2) AS Average_AQI
FROM classified
GROUP BY Period, State, Pollutant
ORDER BY State, Period;



/*  
   7. State-Level Heatmap Data (Last 7 Days)
     */
SELECT
    state,
    pollutant_id,
    ROUND(AVG(avg_aqi), 2) AS avg_aqi
FROM aqi_gold.agg_daily_state
WHERE date >= date_sub(current_date(), 7)
GROUP BY state, pollutant_id
ORDER BY state, pollutant_id;



/*  
   8. Top 10 Most Polluted Cities (Latest Available Date)
     */
SELECT
    state,
    city,
    avg_aqi
FROM aqi_gold.agg_daily_city
WHERE date = (
    SELECT MAX(date)
    FROM aqi_gold.agg_daily_city
)
ORDER BY avg_aqi DESC
LIMIT 10;