# TripLens Countries Explorer
# Documentation Structure

---

# Documentation Structure

```text
docs/

├── README.md
│
├── 00_PROJECT_OVERVIEW.md
├── 01_ARCHITECTURE.md
├── 02_DEVELOPMENT_SETUP.md
├── 03_OPERATIONS_RUNBOOK.md
├── 04_AIRFLOW_GUIDE.md
├── 05_MINIO_GUIDE.md
├── 06_SNOWFLAKE_GUIDE.md
├── 07_DBT_GUIDE.md
├── 08_TROUBLESHOOTING.md
├── 09_DEPLOYMENT.md
├── 10_PROJECT_HISTORY.md
├── 11_LESSONS_LEARNED.md
├── 12_DECISIONS_AND_RATIONALE.md
├── 13_SECURITY_AND_SECRETS.md
├── 14_PERFORMANCE_OPTIMISATION.md
├── 15_FUTURE_IMPROVEMENTS.md
│
├── architecture/
│   ├── high_level_architecture.png
│   ├── data_flow.drawio
│   ├── airflow_dag.png
│   ├── dbt_lineage.png
│   └── sequence_diagram.png
│
├── screenshots/
│   ├── airflow/
│   ├── minio/
│   ├── snowflake/
│   ├── dbt/
│   ├── powerbi/
│   └── troubleshooting/
│
├── commands/
│   ├── airflow_commands.md
│   ├── docker_commands.md
│   ├── postgres_commands.md
│   ├── minio_commands.md
│   ├── snowflake_commands.md
│   ├── dbt_commands.md
│   ├── git_commands.md
│   └── linux_commands.md
│
├── sql/
│   ├── create_tables.sql
│   ├── create_stage.sql
│   ├── create_file_format.sql
│   ├── copy_into.sql
│   └── useful_queries.sql
│
├── api/
│   ├── restcountries.md
│   └── sample_responses.json
│
├── environment/
│   ├── environment_variables.md
│   ├── ports.md
│   ├── dependencies.md
│   └── versions.md
│
└── troubleshooting/
    ├── airflow.md
    ├── docker.md
    ├── minio.md
    ├── snowflake.md
    ├── dbt.md
    └── networking.md
```

---

# README.md

The main entry point into the project.

## Purpose

Provide a high-level summary of the project and guide users to the relevant documentation.

## Suggested Contents

- Project Summary
- Business Problem
- Solution Overview
- Architecture Diagram
- Technology Stack
- Folder Structure
- Quick Start Guide
- Pipeline Flow
- Screenshots
- Documentation Links
- Project Status
- Known Issues
- Future Enhancements

---

# 00_PROJECT_OVERVIEW.md

## Purpose

Introduce the project and explain its business value.

## Contents

- Business Problem
- Project Objectives
- Scope
- Technology Stack
- Data Sources
- Expected Outputs
- Key Deliverables

---

# 01_ARCHITECTURE.md

## Purpose

Describe the end-to-end architecture and explain how data flows through the system.

## Pipeline

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

Snowflake Bronze

        │

        ▼

dbt Bronze

        │

        ▼

dbt Silver

        │

        ▼

dbt Gold

        │

        ▼

Power BI / Tableau
```

## Include

- Architecture diagrams
- Data flow
- Component descriptions
- Design decisions
- Security considerations

---

# 02_DEVELOPMENT_SETUP.md

## Purpose

Provide complete instructions to recreate the project from scratch.

## Contents

### Software Installation

- Homebrew
- Python
- Virtual Environment
- Docker Desktop
- Astro CLI
- PostgreSQL
- VS Code
- Git

### Project Setup

- Clone repository
- Install Python packages
- Install dbt packages
- Configure `.env`
- Configure `set_env.sh`
- Configure Snowflake
- Configure MinIO

### Initial Startup

- PostgreSQL
- Docker
- Astro
- Airflow
- MinIO

---

# 03_OPERATIONS_RUNBOOK.md

## Purpose

Daily operational guide for running and maintaining the project.

## Include

### Startup Checklist

- Activate virtual environment
- Load environment variables
- Start PostgreSQL
- Start Astro
- Verify services
- Open Airflow
- Open MinIO

### Shutdown Checklist

- Stop Astro
- Stop PostgreSQL
- Stop Docker containers

### Restart Procedures

- Restart Airflow
- Restart Docker
- Restart PostgreSQL

### Health Checks

Commands to verify:

- PostgreSQL
- Docker
- Airflow
- MinIO
- Snowflake

### Common Commands

```bash
brew services list
docker ps
docker ps -a
lsof -i :5432
lsof -i :8080
lsof -i :29100
lsof -i :29101
```

### Docker Commands

```bash
docker ps
docker stop
docker restart
docker logs
docker rm
```

### Astro Commands

```bash
astro dev start
astro dev stop
astro dev restart
astro dev kill
astro dev logs
```

### Ports

| Service | Port |
|----------|------|
| Airflow | 8080 |
| PostgreSQL | 5432 |
| MinIO API | 29100 |
| MinIO Console | 29101 |

---

# 04_AIRFLOW_GUIDE.md

## Purpose

Document everything related to Apache Airflow.

## Contents

- DAG Structure
- TaskFlow API
- Python Operators
- Task Dependencies
- XCom
- Variables
- Connections
- Scheduler
- Webserver
- Logs
- Triggering DAGs
- Testing DAGs

---

# 05_MINIO_GUIDE.md

## Purpose

Document the MinIO object storage implementation.

## Contents

- Buckets
- Objects
- Folder Structure
- API Endpoint
- Console
- Credentials
- boto3 Configuration
- Uploading Files
- Downloading Files
- Bucket Management
- Troubleshooting

---

# 06_SNOWFLAKE_GUIDE.md

## Purpose

Document the Snowflake implementation.

## Contents

- Warehouses
- Databases
- Schemas
- Roles
- Users
- File Formats
- Internal Stages
- External Stages
- PUT
- COPY INTO
- VARIANT Data Type
- JSON Loading
- Warehouse Management
- Cost Optimisation
- Troubleshooting

---

# 07_DBT_GUIDE.md

## Purpose

Document the dbt implementation.

## Contents

- Project Structure
- dbt_project.yml
- profiles.yml
- Models
- Sources
- Seeds
- Snapshots
- Tests
- Macros
- Materializations
- Compile
- Run
- Test
- Documentation
- Lineage Graph

---

# 08_TROUBLESHOOTING.md

## Purpose

Capture every issue encountered during development.

## For Every Issue Record

- Problem
- Symptoms
- Root Cause
- Resolution
- Commands Used
- Screenshots (where applicable)

### Example

#### Snowflake Warehouse Suspended

**Cause**

Trial expired.

**Resolution**

- Create new account
- Update environment variables
- Restart Astro

---

#### MinIO Authentication Failed

**Cause**

Environment variables were not loaded.

**Resolution**

```bash
source set_env.sh
astro dev restart
```

---

#### Port Already in Use

**Resolution**

```bash
lsof -i :5432
kill -9 PID
```

---

# 09_DEPLOYMENT.md

## Purpose

Document deployment procedures.

## Contents

- Docker
- GitHub
- Production Deployment
- Cloud Deployment
- Deployment Checklist
- Environment Promotion

---

# 10_PROJECT_HISTORY.md

## Purpose

Maintain a development journal.

### Example Entry

## 2026-07-04

### Completed

- Installed MinIO
- Connected Airflow
- Connected Snowflake
- Fixed warehouse issue
- Configured environment variables
- Fixed dbt path
- Created internal stage
- Updated DAG

### Lessons

- Cosmos configuration
- Airflow TaskFlow API
- Docker networking

---

# 11_LESSONS_LEARNED.md

## Purpose

Capture key learning outcomes throughout the project.

### Example

Today I learned:

- Airflow TaskFlow API
- Environment Variables
- Docker Networking
- MinIO Authentication
- Snowflake Stages
- dbt Execution
- Production Debugging

---

# 12_DECISIONS_AND_RATIONALE.md

## Purpose

Document architectural decisions and explain why they were made.

### Examples

- Why MinIO instead of AWS S3 for local development?
- Why Apache Airflow instead of Prefect?
- Why Snowflake instead of PostgreSQL?
- Why dbt for transformations?
- Why Bronze → Silver → Gold architecture?
- Why use Cosmos for dbt orchestration?

This document is especially valuable during technical interviews and design discussions.

---

# 13_SECURITY_AND_SECRETS.md

## Purpose

Document how sensitive information is managed.

## Include

- `.env`
- `set_env.sh`
- Environment Variables
- Secret Management
- `.gitignore`
- Credential Rotation
- Best Practices

> **Never commit actual credentials or secrets to GitHub.**

---

# 14_PERFORMANCE_OPTIMISATION.md

## Purpose

Record performance improvements and tuning decisions.

## Include

- SQL optimisation
- Airflow performance tuning
- dbt incremental models
- Snowflake warehouse sizing
- Parallel execution
- API optimisation
- Caching strategies

---

# 15_FUTURE_IMPROVEMENTS.md

## Purpose

Maintain a backlog of enhancements.

### Examples

- Incremental loading
- Change Data Capture (CDC)
- Great Expectations integration
- Terraform infrastructure
- GitHub Actions CI/CD
- Kubernetes deployment
- Data Quality Monitoring
- Observability Dashboard

---

# Long-Term Engineering Knowledge Base

After completing TripLens, create a reusable engineering handbook that can support all future projects.

```text
Engineering_Handbook/

Docker.md
Airflow.md
Snowflake.md
dbt.md
Kafka.md
Spark.md
Terraform.md
Azure.md
AWS.md
Python.md
PostgreSQL.md
Git.md
Linux.md
PowerBI.md
```

## Purpose

The Engineering Handbook should evolve into a personal reference library that captures:

- Technology notes
- Commands
- Best practices
- Troubleshooting procedures
- Deployment strategies
- Performance tuning
- Lessons learned

As additional portfolio projects are completed (Urban Intelligence, Reddit Streaming, MetroPeak, Credit Card Fraud Detection, etc.), continue expanding this handbook.

### Long-Term Goals

1. Rapid onboarding to future projects.
2. Structured preparation for technical interviews.
3. A reusable engineering reference for production environments.
4. Consistent documentation standards across all portfolio projects.
5. Continuous knowledge accumulation throughout your engineering career.