# TripLens Countries Explorer

# Snowflake Guide

**Version:** 1.0

---

# Overview

Snowflake is the cloud data warehouse used to store, transform and serve data for analytics within the TripLens Countries Explorer project.

It forms the central data platform where raw data is loaded, transformed using dbt and prepared for reporting.

---

# Purpose

Snowflake is responsible for:

- Storing raw data
- Managing the Bronze, Silver and Gold layers
- Executing SQL transformations
- Serving analytics-ready datasets
- Providing a scalable cloud data warehouse

---

# Architecture

```text
MinIO
    ↓
Snowflake Bronze
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

# Database Structure

Current database:

```text
TRIPLENS
```

Schemas:

```text
BRONZE
SILVER
GOLD
ANALYTICS
```

---

# Data Loading

Raw JSON data is loaded from MinIO into the Bronze layer.

The Bronze layer preserves the original source data before transformation.

---

# Data Transformation

dbt is used to transform data through the following layers:

```text
Bronze
    ↓
Silver
    ↓
Gold
```

Each layer has a specific responsibility:

- **Bronze** – Raw data ingestion
- **Silver** – Data cleaning and standardisation
- **Gold** – Analytics-ready models

---

# Current Status

| Component | Status |
|-----------|--------|
| Snowflake Account | ✅ Configured |
| Warehouse | ✅ Created |
| Database | ✅ Created |
| Schemas | ✅ Created |
| Bronze Layer | 🚧 In Progress |
| Silver Layer | Planned |
| Gold Layer | Planned |
| Analytics Layer | Planned |

---

# Future Enhancements

- Incremental loading
- Data quality validation
- Performance optimisation
- Automated warehouse management
- Monitoring and alerting

---

# Related Documents

- 01_ARCHITECTURE.md
- 04_AIRFLOW_GUIDE.md
- 05_MINIO_GUIDE.md
- 07_DBT_GUIDE.md
- 08_TROUBLESHOOTING.md