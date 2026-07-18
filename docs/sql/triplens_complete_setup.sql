01_setup_database.sql
02_roles_and_permissions.sql
03_database_objects.sql
04_verification_queries.sql
05_dashboard_queries.sql
06_useful_queries.sql


-- Do not automatically run 03_database_objects.sql until you confirm whether load_to_snowflake.py creates COUNTRIES_RAW
-- otherwise, you could create a table structure that conflicts with your loader.