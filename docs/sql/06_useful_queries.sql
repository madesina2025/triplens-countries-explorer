-- ============================================================
-- TripLens Countries Explorer
-- File: 06_useful_queries.sql
-- Purpose: Useful Snowflake administration and troubleshooting
-- ============================================================

-- ============================================================
-- 1. CURRENT SESSION
-- ============================================================

SELECT
    CURRENT_USER() AS current_user,
    CURRENT_ROLE() AS current_role,
    CURRENT_SECONDARY_ROLES() AS secondary_roles,
    CURRENT_WAREHOUSE() AS current_warehouse,
    CURRENT_DATABASE() AS current_database,
    CURRENT_SCHEMA() AS current_schema,
    CURRENT_ACCOUNT() AS current_account,
    CURRENT_REGION() AS current_region;

-- ============================================================
-- 2. ACCOUNT INFORMATION
-- ============================================================

SELECT
    CURRENT_ORGANIZATION_NAME() AS organization_name,
    CURRENT_ACCOUNT_NAME() AS account_name,
    CURRENT_ACCOUNT() AS account_locator,
    CURRENT_REGION() AS region;

-- ============================================================
-- 3. SHOW MAIN OBJECTS
-- ============================================================

SHOW DATABASES;

SHOW WAREHOUSES;

SHOW ROLES;

SHOW USERS;

SHOW SCHEMAS IN DATABASE TRIPLENS;

SHOW TABLES IN DATABASE TRIPLENS;

SHOW VIEWS IN DATABASE TRIPLENS;

-- ============================================================
-- 4. ROLE AND PERMISSION CHECKS
-- ============================================================

SHOW GRANTS TO ROLE DBT_ROLE;

SHOW GRANTS TO ROLE TRIPLENS_ANALYST_ROLE;

SHOW GRANTS TO USER DBT;

SHOW GRANTS TO USER MADESINA2025;

-- ============================================================
-- 5. WAREHOUSE CONTROL
-- ============================================================

ALTER WAREHOUSE TRIPLENS_WH RESUME;

ALTER WAREHOUSE TRIPLENS_WH SUSPEND;

ALTER WAREHOUSE TRIPLENS_WH SET AUTO_SUSPEND = 60;

ALTER WAREHOUSE TRIPLENS_WH SET AUTO_RESUME = TRUE;

-- ============================================================
-- 6. OBJECT DESCRIPTION
-- ============================================================

DESC DATABASE TRIPLENS;

DESC SCHEMA TRIPLENS.RAW;

DESC TABLE TRIPLENS.RAW.COUNTRIES_RAW;

DESC VIEW TRIPLENS.BRONZE.STG_TRIPLENS_COUNTRIES;

DESC TABLE TRIPLENS.SILVER.TRIPLENS_COUNTRIES;

DESC TABLE TRIPLENS.GOLD.GOLD_CONTINENT_SUMMARY;

DESC TABLE TRIPLENS.ANALYTICS.ANALYTICS_COUNTRY_OVERVIEW;

-- ============================================================
-- 7. FIND TABLE COLUMNS
-- ============================================================

SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    ordinal_position,
    is_nullable
FROM TRIPLENS.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'ANALYTICS_COUNTRY_OVERVIEW'
ORDER BY ordinal_position;

SELECT
    table_schema,
    table_name,
    column_name,
    data_type,
    ordinal_position,
    is_nullable
FROM TRIPLENS.INFORMATION_SCHEMA.COLUMNS
WHERE table_name = 'TRIPLENS_COUNTRIES'
ORDER BY table_schema, ordinal_position;

-- ============================================================
-- 8. ROW COUNTS BY LAYER
-- ============================================================

SELECT COUNT(*) AS raw_rows
FROM TRIPLENS.RAW.COUNTRIES_RAW;

SELECT COUNT(*) AS bronze_rows
FROM TRIPLENS.BRONZE.TRIPLENS_COUNTRIES;

SELECT COUNT(*) AS silver_rows
FROM TRIPLENS.SILVER.TRIPLENS_COUNTRIES;

SELECT COUNT(*) AS analytics_rows
FROM TRIPLENS.ANALYTICS.ANALYTICS_COUNTRY_OVERVIEW;

-- ============================================================
-- 9. QUERY HISTORY
-- ============================================================

SELECT
    query_id,
    user_name,
    role_name,
    warehouse_name,
    query_text,
    execution_status,
    start_time,
    end_time,
    total_elapsed_time
FROM TABLE(
    INFORMATION_SCHEMA.QUERY_HISTORY(
        END_TIME_RANGE_START => DATEADD('hour', -24, CURRENT_TIMESTAMP()),
        RESULT_LIMIT => 100
    )
)
ORDER BY start_time DESC;

-- ============================================================
-- 10. FAILED QUERIES
-- ============================================================

SELECT
    query_id,
    user_name,
    role_name,
    query_text,
    error_code,
    error_message,
    start_time
FROM TABLE(
    INFORMATION_SCHEMA.QUERY_HISTORY(
        END_TIME_RANGE_START => DATEADD('hour', -24, CURRENT_TIMESTAMP()),
        RESULT_LIMIT => 100
    )
)
WHERE execution_status = 'FAIL'
ORDER BY start_time DESC;

-- ============================================================
-- 11. TABLE STORAGE
-- ============================================================

SELECT
    table_schema,
    table_name,
    row_count,
    bytes,
    created,
    last_altered
FROM TRIPLENS.INFORMATION_SCHEMA.TABLES
WHERE table_schema IN (
    'RAW',
    'BRONZE',
    'SILVER',
    'GOLD',
    'ANALYTICS'
)
ORDER BY table_schema, table_name;

-- ============================================================
-- 12. SWITCH BETWEEN PROJECT ROLES
-- ============================================================

-- Administrative setup:
USE ROLE ACCOUNTADMIN;

-- dbt transformations:
USE ROLE DBT_ROLE;

-- Dashboard testing:
USE ROLE TRIPLENS_ANALYST_ROLE;

-- Recommended project warehouse:
USE WAREHOUSE TRIPLENS_WH;