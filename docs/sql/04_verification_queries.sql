-- ============================================================
-- TripLens Countries Explorer
-- File: 04_verification_queries.sql
-- Purpose: Verify the full Snowflake and dbt environment
-- ============================================================

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE TRIPLENS_WH;
USE DATABASE TRIPLENS;

-- ============================================================
-- 1. SESSION CHECK
-- ============================================================

SELECT
    CURRENT_USER() AS current_user,
    CURRENT_ROLE() AS current_role,
    CURRENT_WAREHOUSE() AS current_warehouse,
    CURRENT_DATABASE() AS current_database,
    CURRENT_SCHEMA() AS current_schema;

-- ============================================================
-- 2. ENVIRONMENT INVENTORY
-- ============================================================

SHOW WAREHOUSES LIKE 'TRIPLENS_WH';

SHOW SCHEMAS IN DATABASE TRIPLENS;

SHOW TABLES IN SCHEMA TRIPLENS.RAW;

SHOW VIEWS IN SCHEMA TRIPLENS.BRONZE;

SHOW TABLES IN SCHEMA TRIPLENS.BRONZE;

SHOW VIEWS IN SCHEMA TRIPLENS.SILVER;

SHOW TABLES IN SCHEMA TRIPLENS.SILVER;

SHOW TABLES IN SCHEMA TRIPLENS.GOLD;

SHOW VIEWS IN SCHEMA TRIPLENS.GOLD;

SHOW TABLES IN SCHEMA TRIPLENS.ANALYTICS;

SHOW VIEWS IN SCHEMA TRIPLENS.ANALYTICS;

-- ============================================================
-- 3. RAW DATA CHECK
-- ============================================================

SELECT COUNT(*) AS raw_row_count
FROM TRIPLENS.RAW.COUNTRIES_RAW;

SELECT *
FROM TRIPLENS.RAW.COUNTRIES_RAW
LIMIT 5;

-- ============================================================
-- 4. BRONZE DATA CHECK
-- ============================================================

SELECT COUNT(*) AS bronze_row_count
FROM TRIPLENS.BRONZE.TRIPLENS_COUNTRIES;

SELECT *
FROM TRIPLENS.BRONZE.TRIPLENS_COUNTRIES
ORDER BY country_name
LIMIT 20;

-- ============================================================
-- 5. SILVER DATA CHECK
-- ============================================================

SELECT COUNT(*) AS silver_row_count
FROM TRIPLENS.SILVER.TRIPLENS_COUNTRIES;

SELECT *
FROM TRIPLENS.SILVER.TRIPLENS_COUNTRIES
ORDER BY country_name
LIMIT 20;

-- Check important fields for null values

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT country_name) AS distinct_country_names,
    COUNT_IF(country_name IS NULL) AS null_country_names,
    COUNT_IF(continent IS NULL) AS null_continents,
    COUNT_IF(region IS NULL) AS null_regions,
    COUNT_IF(population IS NULL) AS null_population,
    COUNT_IF(area_km2 IS NULL) AS null_area
FROM TRIPLENS.SILVER.TRIPLENS_COUNTRIES;

-- Check duplicates

SELECT
    country_name,
    COUNT(*) AS record_count
FROM TRIPLENS.SILVER.TRIPLENS_COUNTRIES
GROUP BY country_name
HAVING COUNT(*) > 1
ORDER BY record_count DESC;

-- ============================================================
-- 6. GOLD MODEL CHECKS
-- ============================================================

SELECT *
FROM TRIPLENS.GOLD.GOLD_CONTINENT_SUMMARY
ORDER BY total_population DESC;

SELECT *
FROM TRIPLENS.GOLD.GOLD_REGION_SUMMARY
ORDER BY total_population DESC;

SELECT *
FROM TRIPLENS.GOLD.GOLD_POPULATION_RANKING
ORDER BY population_rank
LIMIT 20;

SELECT *
FROM TRIPLENS.GOLD.GOLD_CURRENCY_SUMMARY
ORDER BY total_countries DESC, combined_population DESC
LIMIT 50;

SELECT *
FROM TRIPLENS.GOLD.GOLD_LANGUAGE_SUMMARY
ORDER BY total_countries DESC, combined_population DESC
LIMIT 50;

-- ============================================================
-- 7. ANALYTICS MODEL CHECKS
-- ============================================================

SELECT COUNT(*) AS analytics_country_rows
FROM TRIPLENS.ANALYTICS.ANALYTICS_COUNTRY_OVERVIEW;

SELECT *
FROM TRIPLENS.ANALYTICS.ANALYTICS_COUNTRY_OVERVIEW
ORDER BY population_rank
LIMIT 20;

SELECT *
FROM TRIPLENS.ANALYTICS.ANALYTICS_GLOBAL_KPIS;

-- ============================================================
-- 8. EXPECTED RESULTS
-- ============================================================

-- Expected:
--
-- ANALYTICS_COUNTRY_OVERVIEW = 254 rows
-- ANALYTICS_GLOBAL_KPIS      = 1 row
-- dbt tests                  = PASS
-- duplicate country names    = 0 rows