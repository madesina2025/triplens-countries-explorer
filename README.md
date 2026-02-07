#  TripLens Countries Explorer  

**Travel-Ready Analytics from Public Data**

## Overview

**TripLens Countries Explorer** is an end-to-end **data engineering pipeline** that transforms public country-level data into **analytics-ready insights** for tourists, travellers, and digital products focused on travel intelligence.

The project enables users to **quickly understand essential information about a country** before making travel or relocation decisions — including:
- Region & continent  
- Official language(s)  
- Currency  
- Time zones  
- Neighbouring countries  
- Other planning-critical attributes  

The pipeline is designed with **production principles** in mind: orchestration, scalability, data modelling, and analytics consumption.

---

## Business Use Case

Travellers often rely on fragmented sources when researching new destinations. TripLens consolidates multiple public data sources into a **single, trusted analytics layer**, enabling:

- Faster decision-making for travellers  
- Reusable datasets for travel platforms  
- BI-ready models for dashboards and reporting  

This project simulates how a real travel intelligence or tourism analytics platform would ingest, process, and expose country-level data.

---

## High-Level Architecture

The pipeline follows a modern **lake → warehouse → analytics** pattern.

### Architecture Flow

1. **External Public APIs** provide raw country data  
2. **Python ingestion layer** extracts and standardises API responses  
3. Data is stored in **Amazon S3 (Data Lake – Raw Zone)**  
4. Raw data is loaded into **Snowflake (Staging / Raw Layer)**  
5. **dbt** transforms raw data into clean, analytics-ready models  
6. Curated datasets are exposed from **Snowflake Analytics Layer**  
7. **Power BI** consumes the analytics layer for dashboards and insights  

---

## Architecture Diagram

> End-to-end data flow from ingestion to analytics

![TripLens Architecture](TripLens_Countries_Explorer_Diagram.drawio.png)

---

## Tech Stack

### Ingestion & Orchestration
- Python  
- Apache Airflow  
- Docker (Astro Runtime)  

### Storage & Processing
- Amazon S3 (Data Lake)  
- Snowflake (Cloud Data Warehouse)  

### Transformation
- dbt (Data Build Tool)  

### Analytics & Visualisation
- Power BI  

### Engineering Practices
- Containerised execution  
- Environment isolation  
- Modular pipeline design  
- Analytics-ready data modelling  

---

## Project Structure

```text
triplens-countries-explorer/
├── airflow/            # Airflow DAGs and orchestration logic
│   ├── dags/
│   ├── include/
│   └── tests/
├── data/               # Raw and processed datasets (local/dev only)
├── data_bank/          # Reference / lookup datasets
├── Dockerfile
├── docker-compose.override.yml
├── requirements.txt
└── README.md


---

### Why this version is strong (quick reassurance)
- No duplication ✅  
- Clear separation of **logic / execution / outputs**  
- Reads well for **engineers, managers, and recruiters**  
- Signals **production thinking**, not tutorial code  

### What to do next (2 commands)
After pasting into `README.md`:

```bash
git add README.md
git commit -m "Docs: clarify pipeline logic, local setup, and outputs"
git push

## Access Services

Once the platform is running locally:

- **Airflow UI**: http://localhost:8080  
- Trigger the `triplens-explorer` DAG from the Airflow UI to execute the pipeline end-to-end.

> Environment variables are managed via a `.env` file and are intentionally **not committed to GitHub**.

---

## Outputs

The pipeline produces the following outputs:

- Clean, analytics-ready country datasets stored in **Snowflake**
- Curated dimensional models suitable for **BI and reporting tools**
- **Power BI dashboards** enabling:
  - Country comparison
  - Regional insights
  - Travel planning and destination analysis

