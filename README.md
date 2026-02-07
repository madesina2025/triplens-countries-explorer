# TripLens Countries Explorer

TripLens Countries Explorer is an end-to-end data engineering project that ingests public country-level data and produces analytics-ready datasets for travel intelligence and exploration.

## Architecture
- Python-based ingestion
- Apache Airflow orchestration
- Data lake-style storage
- Analytics-ready datasets (dbt/Snowflake-ready)
- Containerised local execution

## Tech Stack
- Python
- Apache Airflow
- Docker / Astro
- PostgreSQL (Snowflake-ready)
- dbt (planned)

## Project Structure
- airflow/     → DAGs and orchestration logic
- data/        → Raw and processed datasets
- data_bank/  → Reference datasets

## How to Run Locally
1. Configure environment variables
2. Start Airflow locally
3. Trigger the `triplens-explorer` DAG from the Airflow UI

## Roadmap
- dbt transformation layer
- Analytics dashboards (Power BI / Looker)
- API layer for frontend consumption

