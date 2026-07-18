# TripLens Countries Explorer

# MinIO Guide

**Version:** 1.0

---

# Overview

MinIO provides S3-compatible object storage for the TripLens data pipeline.

It acts as the project's landing zone, storing raw API data before it is loaded into Snowflake.

---

# Purpose

MinIO is responsible for:

- Storing raw JSON files
- Preserving source data
- Simulating Amazon S3 in a local environment
- Providing a source for Snowflake ingestion

---

# Data Flow

```text
REST Countries API
        ↓
Apache Airflow
        ↓
MinIO
        ↓
Snowflake Bronze
```

---

# Bucket Structure

```text
triplens-bucket/

└── raw/
    └── countries_raw.json
```

---

# File Format

Current file format:

```text
JSON
```

The raw API response is stored without transformation.

---

# Integration

MinIO integrates with:

- Apache Airflow
- Python (boto3)
- Snowflake

---

# Current Status

| Component | Status |
|-----------|--------|
| MinIO Server | ✅ Configured |
| Bucket | ✅ Created |
| Raw Storage | 🚧 In Progress |
| Snowflake Integration | 🚧 In Progress |

---

# Future Enhancements

- Partition raw data
- Version stored files
- Archive historical data
- Support incremental loads

---

# Related Documents

- 01_ARCHITECTURE.md
- 04_AIRFLOW_GUIDE.md
- 06_SNOWFLAKE_GUIDE.md
- 08_TROUBLESHOOTING.md