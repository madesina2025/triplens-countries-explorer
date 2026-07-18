# TripLens Countries Explorer

# Airflow Guide

**Version:** 1.0

---

# Overview

Apache Airflow is used to orchestrate the TripLens data pipeline.

It coordinates the execution of tasks required to extract data from the REST Countries API, store the raw data, and trigger downstream processing.

---

# Airflow Architecture

Airflow is deployed locally using **Astro Runtime** and runs inside Docker containers.

Core services include:

- Webserver
- Scheduler
- Triggerer
- DAG Processor
- PostgreSQL Metadata Database

---

# Project Structure

```text
airflow/

├── dags/
├── include/
├── plugins/
├── tests/
├── Dockerfile
├── docker-compose.override.yml
├── airflow_settings.yaml
├── requirements.txt
└── packages.txt
```

---

# DAG

Current DAG

```text
triplens-explorer
```

---

# Workflow

Current pipeline:

```text
Extract Data
        ↓
Store Raw JSON
        ↓
Load to Snowflake
        ↓
Run dbt Models
```

The workflow will expand as additional functionality is implemented.

---

# Tasks

Current tasks include:

- Extract data from REST Countries API
- Store raw JSON
- Load data into Snowflake
- Execute dbt transformations

Additional tasks will be introduced as the project evolves.

---

# Dependencies

Task execution follows a sequential dependency model.

```text
Extract
    ↓
Load
    ↓
Transform
```

A task must complete successfully before the next task begins.

---

# Configuration

Airflow configuration includes:

- Astro Runtime
- Docker
- Environment Variables
- Airflow Connections
- Airflow Variables

---

# Monitoring

Use the Airflow UI to monitor:

- DAG status
- Task execution
- Task duration
- Logs
- Retry attempts
- Failures

---

# Logging

Airflow automatically records:

- DAG execution
- Task logs
- Errors
- Retry history
- Execution time

These logs are used for monitoring and troubleshooting.

---

# Current Status

| Component | Status |
|-----------|--------|
| Airflow Environment | ✅ Configured |
| Astro Runtime | ✅ Running |
| DAG Development | 🚧 In Progress |
| API Extraction | 🚧 In Progress |
| Snowflake Integration | 🚧 In Progress |
| dbt Integration | 🚧 In Progress |

---

# Future Enhancements

Planned improvements include:

- Scheduled pipeline execution
- Incremental processing
- Task retries and alerting
- Email notifications
- Pipeline monitoring
- Automated testing

---

# Related Documents

- 01_ARCHITECTURE.md
- 03_OPERATIONS_RUNBOOK.md
- 05_MINIO_GUIDE.md
- 06_SNOWFLAKE_GUIDE.md
- 07_DBT_GUIDE.md
- 08_TROUBLESHOOTING.md