-- ============================================================
-- TripLens Countries Explorer
-- File: 01_setup_database.sql
-- Purpose: Create the Snowflake warehouse, database and schemas
-- Run as: ACCOUNTADMIN
-- ============================================================

USE ROLE ACCOUNTADMIN;

-- ------------------------------------------------------------
-- Create warehouse
-- ------------------------------------------------------------

CREATE WAREHOUSE IF NOT EXISTS TRIPLENS_WH
    WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 60
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = TRUE
    COMMENT = 'Warehouse for TripLens Countries Explorer';

-- ------------------------------------------------------------
-- Create database
-- ------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS TRIPLENS
    COMMENT = 'TripLens Countries Explorer data platform';

-- ------------------------------------------------------------
-- Create schemas
-- ------------------------------------------------------------

CREATE SCHEMA IF NOT EXISTS TRIPLENS.RAW
    COMMENT = 'Raw data loaded from MinIO by Airflow';

CREATE SCHEMA IF NOT EXISTS TRIPLENS.BRONZE
    COMMENT = 'Initial dbt staging and standardisation layer';

CREATE SCHEMA IF NOT EXISTS TRIPLENS.SILVER
    COMMENT = 'Cleaned and transformed country-level data';

CREATE SCHEMA IF NOT EXISTS TRIPLENS.GOLD
    COMMENT = 'Aggregated business-ready data models';

CREATE SCHEMA IF NOT EXISTS TRIPLENS.ANALYTICS
    COMMENT = 'Dashboard-ready analytical models';

-- ------------------------------------------------------------
-- Set working context
-- ------------------------------------------------------------

USE WAREHOUSE TRIPLENS_WH;
USE DATABASE TRIPLENS;
USE SCHEMA RAW;

-- ------------------------------------------------------------
-- Confirm setup
-- ------------------------------------------------------------

SELECT
    CURRENT_ROLE() AS current_role,
    CURRENT_WAREHOUSE() AS current_warehouse,
    CURRENT_DATABASE() AS current_database,
    CURRENT_SCHEMA() AS current_schema;

SHOW SCHEMAS IN DATABASE TRIPLENS;