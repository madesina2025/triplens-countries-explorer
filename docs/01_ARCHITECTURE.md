# TripLens Countries Explorer

# Architecture

Version: 1.0

Status: In Development

---

# Purpose

This document explains the technical architecture of the TripLens Countries Explorer project.

It describes how data flows through the platform from extraction to transformation, and the responsibility of each component within the solution.

The architecture follows a modern ELT (Extract, Load, Transform) design commonly used in cloud-based data engineering platforms.

---

# High-Level Architecture

![TripLens Architecture](architecture/high_level_architecture.png)

---

# Architecture Overview

The TripLens Countries Explorer pipeline consists of six major components.

```text
REST Countries API
        │
        ▼
Apache Airflow
        │
        ▼
MinIO Object Storage
        │
        ▼
Snowflake RAW Layer
        │
        ▼
dbt Transformations
        │
        ▼
Analytics Ready Models
```

Each component has a single responsibility which makes the platform easier to maintain, scale and troubleshoot.

---

# Component Breakdown

## 1. REST Countries API

### Purpose

Acts as the external data source.

### Responsibilities

- Provides country information
- Returns JSON responses
- Supplies the raw dataset used throughout the project

### Data Retrieved

- Country
- Capital
- Region
- Population
- Languages
- Currencies
- Time Zones
- Coordinates
- Flags
- Country Codes

---

## 2. Apache Airflow

### Purpose

Orchestrates the entire pipeline.

### Responsibilities

- Schedule pipeline execution
- Execute extraction tasks
- Upload files to MinIO
- Load data into Snowflake
- Trigger dbt transformations
- Manage task dependencies
- Retry failed tasks
- Produce execution logs

Current DAG

```

triplens-explorer

```

Current Tasks

```

extract_data_from_api
↓
load_data_to_bucket
↓
transfer_to_snowflake
↓
transform_data (dbt)

```

---

## 3. Astro Runtime

### Purpose

Provides the local Airflow development environment.

### Responsibilities

- Runs Airflow inside Docker
- Provides Scheduler
- Provides Triggerer
- Provides Webserver
- Provides Metadata Database

---

## 4. MinIO

### Purpose

Acts as the object storage layer.

### Responsibilities

- Store raw JSON files
- Preserve original API responses
- Simulate Amazon S3 locally
- Provide files for Snowflake ingestion

Current bucket

```

triplens-bucket

```

Current folder structure

```

raw/
countries_raw.json

```

---

## 5. Snowflake

### Purpose

Central cloud data warehouse.

### Responsibilities

- Store raw data
- Store transformed data
- Execute SQL
- Provide scalable analytics

Current database

```

TRIPLENS

```

Current schemas

```

RAW
BRONZE
SILVER
GOLD
ANALYTICS

```

---

## 6. dbt

### Purpose

Transforms raw data into analytics-ready models.

### Responsibilities

- SQL transformations
- Data modelling
- Data quality testing
- Documentation
- Lineage generation

Current architecture

```

RAW
↓

BRONZE
↓

SILVER
↓

GOLD

```

---

# Data Flow

The pipeline currently executes in the following order.

```

REST Countries API

↓

Airflow Extract Task

↓

JSON Response

↓

MinIO

↓

Snowflake RAW

↓

dbt Bronze

↓

dbt Silver

↓

dbt Gold

↓

Power BI / Tableau

```

---

# Technology Responsibilities

| Technology | Responsibility |
|------------|----------------|
| Python | Business logic |
| Airflow | Workflow orchestration |
| Astro | Local Airflow runtime |
| Docker | Containerisation |
| MinIO | Object storage |
| Snowflake | Data warehouse |
| dbt | Data transformation |
| Git | Version control |
| GitHub | Source repository |

---

# Current Architecture Status

| Component | Status |
|-----------|--------|
| API Integration | ✅ Completed |
| Airflow Environment | ✅ Completed |
| Astro Runtime | ✅ Completed |
| Docker | ✅ Completed |
| MinIO | ✅ Completed |
| Snowflake | ✅ Completed |
| dbt Setup | ✅ Completed |
| Bronze Models | 🚧 In Progress |
| Silver Models | Planned |
| Gold Models | Planned |
| Power BI | Planned |
| Tableau | Planned |

---

# Design Principles

The project follows modern data engineering principles.

- Separation of responsibilities
- Modular architecture
- ELT processing
- Containerised development
- Cloud-native tooling
- Scalable transformation layer
- Reproducible environments
- Version-controlled development

---

# Future Enhancements

Planned improvements include:

- Incremental dbt models
- Data quality testing
- Source freshness checks
- CI/CD pipeline
- Automated deployment
- Monitoring and alerting
- Metadata documentation
- Data lineage visualisation

---

# Related Documents

- 00_PROJECT_OVERVIEW.md
- 02_DEVELOPMENT_SETUP.md
- 03_OPERATIONS_RUNBOOK.md
- 04_AIRFLOW_GUIDE.md
- 05_MINIO_GUIDE.md
- 06_SNOWFLAKE_GUIDE.md
- 07_DBT_GUIDE.md

---

# Document Maintenance

This document reflects the current architecture of the project.

It should be updated whenever:

- A new component is introduced
- Data flow changes
- New services are added
- Existing architecture is modified
- Deployment strategy changes