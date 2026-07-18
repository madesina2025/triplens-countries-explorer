-- ============================================================
-- TripLens Countries Explorer
-- File: 03_database_objects.sql
-- Purpose: Define database objects managed outside dbt
-- Run as: ACCOUNTADMIN or another role with object creation access
-- ============================================================

USE ROLE ACCOUNTADMIN;
USE WAREHOUSE TRIPLENS_WH;
USE DATABASE TRIPLENS;
USE SCHEMA RAW;

-- ============================================================
-- RAW OBJECTS
-- ============================================================

-- The Airflow loader currently creates and loads COUNTRIES_RAW.
-- This section provides a recovery template only.
--
-- Before running it, confirm the exact raw-table structure expected
-- by load_to_snowflake.py and the dbt source definition.

-- Example recovery table:

CREATE TABLE IF NOT EXISTS TRIPLENS.RAW.COUNTRIES_RAW (
    COUNTRY_DATA VARIANT,
    LOADED_AT TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
)
COMMENT = 'Raw country JSON records loaded from MinIO';

-- ============================================================
-- OPTIONAL FILE FORMAT
-- ============================================================

CREATE FILE FORMAT IF NOT EXISTS TRIPLENS.RAW.JSON_FILE_FORMAT
    TYPE = JSON
    STRIP_OUTER_ARRAY = TRUE
    COMMENT = 'JSON file format for country API data';

-- ============================================================
-- NOTES
-- ============================================================

-- The following objects are not created manually here:
--
-- BRONZE models
-- SILVER models
-- GOLD models
-- ANALYTICS models
--
-- They are created and managed by dbt.
--
-- To recreate them:
--
-- cd dbt/dbt_triplens
-- dbt deps
-- dbt build

-- ============================================================
-- VERIFY RAW OBJECTS
-- ============================================================

SHOW TABLES IN SCHEMA TRIPLENS.RAW;

SHOW FILE FORMATS IN SCHEMA TRIPLENS.RAW;

DESC TABLE TRIPLENS.RAW.COUNTRIES_RAW;