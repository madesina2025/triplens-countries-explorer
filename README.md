# TripLens Countries Explorer

**Travel-Ready Analytics from Public Data**

TripLens Countries Explorer is a modern data engineering pipeline that transforms public country-level data into **analytics-ready datasets** for travellers, analysts, and decision-makers exploring new destinations.

The project demonstrates how a real-world travel intelligence or tourism analytics platform would ingest, process, and expose country data using cloud-native and analytics engineering best practices.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Problem Statement](#problem-statement)
3. [Solution Summary](#solution-summary)
4. [High-Level Architecture](#high-level-architecture)
5. [Architecture Diagram](#architecture-diagram)
6. [Data Pipeline Logic](#data-pipeline-logic)
7. [Project Structure](#project-structure)
8. [Prerequisites](#prerequisites)
9. [How to Run Locally](#how-to-run-locally)
10. [Access Services](#access-services)
11. [Outputs](#outputs)
12. [Roadmap & Enhancements](#roadmap--enhancements)

---

## Project Overview

Travellers and travel platforms often rely on fragmented data sources when researching new destinations. TripLens consolidates multiple public data sources into a **single, trusted analytics layer**, enabling:

- Faster decision-making for travellers  
- Reusable datasets for travel and tourism platforms  
- BI-ready models for dashboards and reporting  

The pipeline focuses on essential country attributes such as **region, language, currency, time zones, neighbouring countries**, and other contextual data that influence travel planning and relocation decisions.

---

## Problem Statement

Public country data is widely available but often:

- Distributed across multiple APIs and sources  
- Inconsistent in structure and quality  
- Not optimised for analytics or BI consumption  

This fragmentation makes it difficult to build reliable dashboards or analytics products without significant data engineering effort.

---

## Solution Summary

TripLens addresses this problem by implementing a **lake → warehouse → analytics** architecture that:

- Extracts and standardises public API data using Python  
- Persists raw data in a cloud-based data lake  
- Loads and transforms data in Snowflake using dbt  
- Exposes clean, analytics-ready datasets for BI tools such as Power BI  

The solution is containerised, orchestrated with Airflow, and designed for extensibility.

---

## High-Level Architecture

The pipeline follows a modern batch analytics architecture:

- **Ingestion**: Python-based API extraction orchestrated by Airflow  
- **Storage**: Amazon S3 as the raw data lake  
- **Warehouse**: Snowflake for staging and analytics layers  
- **Transformation**: dbt for data modelling and enrichment  
- **Analytics**: Power BI dashboards for insights and reporting  

---

## Architecture Diagram

End-to-end data flow from ingestion to analytics:

![TripLens Architecture](TripLens_Countries_Explorer_Diagram.drawio.png)

---

## Data Pipeline Logic

1. **Extraction**  
   Python tasks call external public APIs and normalise responses.

2. **Load**  
   Raw JSON/CSV data is persisted to Amazon S3 as the system of record.

3. **Warehouse Ingestion**  
   Snowflake ingests raw data from S3 into staging and raw tables.

4. **Transformation**  
   dbt models apply cleaning, enrichment, and joins to create curated datasets.

5. **Analytics Layer**  
   Final tables are optimised for BI consumption and reporting.

The design supports future extension to additional data sources or real-time ingestion patterns.

---

## Project Structure

--
triplens-countries-explorer/
├── airflow/                 # Airflow DAGs and orchestration logic
│   ├── dags/
│   ├── include/
│   └── tests/
├── data/                    # Raw and processed datasets (local/dev only)
├── data_bank/               # Reference / lookup datasets
├── Dockerfile
├── docker-compose.override.yml
├── requirements.txt
└── README.md

---

## Access Services

Once the platform is running locally, the following services are available:


##  **Apache Airflow UI**: http://localhost:8080  
  Used to monitor, trigger, and manage the `triplens-explorer` DAG.

To execute the pipeline end-to-end:
1. Open the Airflow UI
2. Locate the `triplens-explorer` DAG
3. Trigger the DAG manually to start ingestion, transformation, and data delivery

Environment variables (API keys, credentials, configuration) are managed via a `.env` file and are intentionally **not committed to GitHub**.

---

## Outputs

The pipeline produces **analytics-ready outputs** designed for consumption by BI and downstream applications:

- **Snowflake Analytics Tables**  
  Clean, standardised country datasets optimised for analytical queries.

- **Dimensional Models**  
  Curated dimensions and fact-style tables suitable for reporting and aggregation.

- **Power BI Dashboards**  
  Interactive dashboards enabling:
  - Country-to-country comparison  
  - Regional and continental insights  
  - Travel planning and destination analysis  

These outputs demonstrate how raw public data can be transformed into **decision-ready analytics** using modern data engineering practices.

