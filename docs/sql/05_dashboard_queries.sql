-- ============================================================
-- TripLens Countries Explorer
-- File: 05_dashboard_queries.sql
-- Purpose: Dashboard-ready queries for Power BI or Tableau
-- Run as: TRIPLENS_ANALYST_ROLE
-- ============================================================

USE ROLE TRIPLENS_ANALYST_ROLE;
USE WAREHOUSE TRIPLENS_WH;
USE DATABASE TRIPLENS;
USE SCHEMA ANALYTICS;

-- ============================================================
-- 1. GLOBAL KPI CARDS
-- ============================================================

SELECT
    total_countries,
    global_population,
    average_country_population,
    total_area_km2,
    average_country_area_km2,
    total_continents
FROM ANALYTICS_GLOBAL_KPIS;

-- ============================================================
-- 2. COUNTRY OVERVIEW
-- ============================================================

SELECT *
FROM ANALYTICS_COUNTRY_OVERVIEW
ORDER BY population_rank;

-- ============================================================
-- 3. TOP 20 COUNTRIES BY POPULATION
-- ============================================================

SELECT
    population_rank,
    country_name,
    official_name,
    capital_city,
    continent,
    region,
    subregion,
    population,
    area_km2,
    population_density,
    population_band
FROM ANALYTICS_COUNTRY_OVERVIEW
ORDER BY population_rank
LIMIT 20;

-- ============================================================
-- 4. POPULATION BY CONTINENT
-- ============================================================

SELECT
    continent,
    COUNT(*) AS total_countries,
    SUM(population) AS total_population,
    AVG(population) AS average_population,
    SUM(area_km2) AS total_area_km2,
    AVG(area_km2) AS average_area_km2
FROM ANALYTICS_COUNTRY_OVERVIEW
GROUP BY continent
ORDER BY total_population DESC;

-- ============================================================
-- 5. POPULATION BY REGION
-- ============================================================

SELECT
    region,
    COUNT(*) AS total_countries,
    SUM(population) AS total_population,
    AVG(population) AS average_population
FROM ANALYTICS_COUNTRY_OVERVIEW
GROUP BY region
ORDER BY total_population DESC;

-- ============================================================
-- 6. POPULATION BY SUBREGION
-- ============================================================

SELECT
    continent,
    region,
    subregion,
    COUNT(*) AS total_countries,
    SUM(population) AS total_population,
    AVG(population) AS average_population
FROM ANALYTICS_COUNTRY_OVERVIEW
GROUP BY
    continent,
    region,
    subregion
ORDER BY total_population DESC;

-- ============================================================
-- 7. POPULATION DENSITY RANKING
-- ============================================================

SELECT
    country_name,
    continent,
    population,
    area_km2,
    population_density
FROM ANALYTICS_COUNTRY_OVERVIEW
WHERE population_density IS NOT NULL
ORDER BY population_density DESC
LIMIT 20;

-- ============================================================
-- 8. LARGEST COUNTRIES BY AREA
-- ============================================================

SELECT
    country_name,
    continent,
    area_km2,
    population,
    population_density
FROM ANALYTICS_COUNTRY_OVERVIEW
WHERE area_km2 IS NOT NULL
ORDER BY area_km2 DESC
LIMIT 20;

-- ============================================================
-- 9. POPULATION BAND DISTRIBUTION
-- ============================================================

SELECT
    population_band,
    COUNT(*) AS total_countries,
    SUM(population) AS combined_population
FROM ANALYTICS_COUNTRY_OVERVIEW
GROUP BY population_band
ORDER BY combined_population DESC;

-- ============================================================
-- 10. CURRENCY SUMMARY
-- ============================================================

SELECT
    currency_code,
    currency_name,
    currency_symbol,
    COUNT(*) AS total_countries,
    SUM(population) AS combined_population
FROM ANALYTICS_COUNTRY_OVERVIEW
WHERE currency_code IS NOT NULL
GROUP BY
    currency_code,
    currency_name,
    currency_symbol
ORDER BY total_countries DESC, combined_population DESC;

-- ============================================================
-- 11. LANGUAGE SUMMARY
-- ============================================================

SELECT
    primary_language,
    primary_language_native,
    COUNT(*) AS total_countries,
    SUM(population) AS combined_population
FROM ANALYTICS_COUNTRY_OVERVIEW
WHERE primary_language IS NOT NULL
GROUP BY
    primary_language,
    primary_language_native
ORDER BY total_countries DESC, combined_population DESC;

-- ============================================================
-- 12. MEMBERSHIP SUMMARY
-- ============================================================

SELECT
    COUNT_IF(un_member = TRUE) AS un_members,
    COUNT_IF(eu_member = TRUE) AS eu_members,
    COUNT_IF(african_union_member = TRUE) AS african_union_members,
    COUNT_IF(asean_member = TRUE) AS asean_members
FROM ANALYTICS_COUNTRY_OVERVIEW;

-- ============================================================
-- 13. MAP DATASET
-- ============================================================

SELECT
    country_name,
    official_name,
    capital_city,
    continent,
    region,
    subregion,
    population,
    area_km2,
    population_density
FROM ANALYTICS_COUNTRY_OVERVIEW
WHERE country_name IS NOT NULL;