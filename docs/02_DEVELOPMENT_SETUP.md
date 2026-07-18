# TripLens Countries Explorer

# Development Setup

**Version:** 1.0  
**Status:** Active Development

---

# Purpose

This document describes the one-time setup required to prepare a local development environment for the TripLens Countries Explorer project.

Once completed, refer to **03_OPERATIONS_RUNBOOK.md** for daily operation of the project.

---

# Development Environment

| Component | Technology |
|-----------|------------|
| Operating System | macOS |
| IDE | Visual Studio Code |
| Programming Language | Python 3.12 |
| Container Platform | Docker Desktop |
| Workflow Orchestration | Apache Airflow (Astro Runtime) |
| Object Storage | MinIO |
| Data Warehouse | Snowflake |
| Data Transformation | dbt Core |
| Version Control | Git & GitHub |

---

# Prerequisites

Install the following software before cloning the project.

- Git
- Python 3.12+
- Docker Desktop
- Visual Studio Code
- Astro CLI
- Homebrew (macOS)
- Snowflake Account

---

# Project Installation

## Clone the Repository

Clone the project from GitHub.

## Create Virtual Environment

Create a Python virtual environment for project dependencies.

## Install Dependencies

Install all required Python packages from:

```text
requirements.txt
```

---

# Project Structure

```text
triplens_countries_explorer/

├── airflow/
├── dbt/
├── docs/
├── data/
├── assets/
├── requirements.txt
├── Dockerfile
└── README.md
```

---

# Environment Configuration

Configure the following before running the project.

- Python Virtual Environment
- Environment Variables (`.env`)
- `set_env.sh`
- Snowflake Credentials
- MinIO Credentials

---

# Infrastructure Components

The project consists of the following development services.

- Apache Airflow
- PostgreSQL (Airflow Metadata Database)
- MinIO
- Snowflake
- dbt

Each component has its own configuration guide within the `docs` folder.

---

# Verification Checklist

Confirm the following before beginning development.

- Development tools installed
- Repository cloned
- Python environment created
- Dependencies installed
- Environment variables configured
- Snowflake account configured
- Docker Desktop available

---

# Related Documents

- 01_ARCHITECTURE.md
- 03_OPERATIONS_RUNBOOK.md
- 04_AIRFLOW_GUIDE.md
- 05_MINIO_GUIDE.md
- 06_SNOWFLAKE_GUIDE.md
- 07_DBT_GUIDE.md

---

# Document Maintenance

Update this document whenever:

- New software prerequisites are introduced.
- Project dependencies change.
- Development environment requirements are updated.
- Project structure changes.