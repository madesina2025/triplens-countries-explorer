# TripLens Countries Explorer

## Project Overview

**Version:** 1.0 (In Development)  
**Project Type:** End-to-End Data Engineering & Analytics Engineering Portfolio Project  
**Status:** Active Development

---

# Business Problem

Many organisations need to integrate data from external APIs into a modern analytics platform where the data can be stored, transformed, analysed and visualised.

The challenge is not only extracting data from an API, but also designing a scalable data pipeline that follows modern data engineering best practices, including orchestration, cloud storage, data warehousing, transformation and business intelligence.

TripLens Countries Explorer is being developed to demonstrate how raw country information obtained from the REST Countries API can be transformed into analytics-ready datasets using a modern ELT architecture.

Rather than focusing solely on dashboards, the project emphasises the complete engineering lifecycle from data ingestion through to reporting.

---

# Project Objectives

The objectives of this project are to:

- Build an end-to-end modern data engineering pipeline.
- Extract country data from the REST Countries API.
- Orchestrate data ingestion using Apache Airflow.
- Store raw JSON data in MinIO (S3-compatible object storage).
- Load raw data into Snowflake.
- Transform raw data using dbt following the Bronze → Silver → Gold architecture.
- Produce analytics-ready datasets for reporting.
- Develop interactive dashboards using Power BI and Tableau.
- Document every stage of the project for future reference and interview preparation.

---

# Current Project Scope

The project is being developed incrementally following structured lessons.

## Completed

### Project Setup

- Repository structure created.
- Python virtual environment configured.
- Git repository configured.
- Docker Desktop configured.

### Airflow

- Apache Airflow installed using Astro Runtime.
- Airflow project created.
- DAG development started.
- Airflow environment successfully running.

### MinIO

- MinIO configured using Docker.
- MinIO Console successfully running.
- Bucket structure under development.

### Snowflake

- Snowflake trial account created.
- Warehouse created.
- Database created.
- Schemas created:
  - BRONZE
  - SILVER
  - GOLD
  - ANALYTICS

### dbt

- dbt Core installed.
- dbt-snowflake adapter installed.
- dbt project created.
- `profiles.yml` configured.
- `dbt_project.yml` configured.
- Successful connection established between dbt and Snowflake.

---

## Currently In Progress

- API extraction debugging.
- Airflow DAG refinement.
- MinIO bucket configuration.
- Loading raw JSON into Snowflake Bronze layer.

---

## Planned

- Bronze Layer
- Silver Layer
- Gold Layer
- Analytics Layer
- Power BI Dashboard
- Tableau Dashboard
- dbt Documentation
- GitHub Documentation

---

# Technology Stack

## Programming

- Python

## Orchestration

- Apache Airflow
- Astro Runtime

## Object Storage

- MinIO (S3 Compatible)

## Data Warehouse

- Snowflake

## Transformation

- dbt Core
- dbt-snowflake

## Database

- PostgreSQL (Airflow Metadata Database)

## Containerisation

- Docker
- Docker Compose

## Version Control

- Git
- GitHub

## Analytics (Planned)

- Power BI
- Tableau

---

# Data Source

## REST Countries API

The project currently uses the REST Countries API as its primary data source.

The API returns country information including:

- Country name
- Official name
- Population
- Capital city
- Region
- Sub-region
- Languages
- Currencies
- Time zones
- Borders
- Latitude & Longitude
- Country codes
- Flags

---

# Current Architecture

The current implementation follows this architecture:

```text
REST Countries API
        │
        ▼
Apache Airflow
        │
        ▼
MinIO (S3)
        │
        ▼
Snowflake
        │
        ▼
dbt
        │
        ▼
Analytics
```

The architecture will be expanded as additional components are completed.

---

# Current Deliverables

The following deliverables have been completed:

- Project repository
- Airflow environment
- MinIO environment
- Snowflake environment
- dbt environment
- Snowflake schemas
- Airflow DAG framework
- Project documentation framework

---

# Expected Final Deliverables

When the project is completed it will include:

- Automated Airflow pipeline
- MinIO object storage
- Snowflake Bronze layer
- dbt Bronze models
- dbt Silver models
- dbt Gold models
- Analytics marts
- Power BI dashboards
- Tableau dashboards
- dbt documentation
- End-to-end architecture documentation
- Operations runbook
- Troubleshooting guide
- Engineering knowledge base

---

# Development Approach

This project is being developed using an incremental lesson-based approach.

Each lesson focuses on a single component before moving to the next stage.

Every stage is:

- Implemented
- Tested
- Documented
- Validated

before progressing.

This approach ensures the project reflects a realistic production engineering workflow rather than simply producing the final output.

---

# Document Maintenance

This document represents the **current state** of the project.

It will be updated throughout development as new components are completed.

Future documents provide detailed information on:

- Architecture
- Development setup
- Operations
- Airflow
- MinIO
- Snowflake
- dbt
- Deployment
- Troubleshooting
- Lessons learned