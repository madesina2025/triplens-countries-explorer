# TripLens Countries Explorer

# dbt Guide

**Version:** 1.0

---

# Overview

dbt (Data Build Tool) is the transformation layer of the TripLens Countries Explorer project.

It is responsible for transforming raw data stored in Snowflake into structured, analytics-ready datasets using the Medallion Architecture (Bronze → Silver → Gold).

The project follows an ELT approach where data is first loaded into Snowflake before being transformed by dbt.

---

# Purpose

Within TripLens, dbt is used to:

- Transform raw JSON data into structured datasets.
- Build the Bronze, Silver and Gold layers.
- Organise SQL transformations into reusable models.
- Apply business rules and data standardisation.
- Improve data quality through automated testing.
- Track historical changes using snapshots.
- Validate source freshness.
- Generate project documentation and data lineage.

---

# Project Structure

```text
dbt/
└── dbt_triplens/
    ├── analyses/
    ├── macros/
    ├── models/
    │   ├── bronze/
    │   ├── silver/
    │   └── gold/
    ├── seeds/
    ├── snapshots/
    ├── tests/
    ├── dbt_project.yml
    ├── packages.yml
    └── profiles.yml
```

---

# Transformation Architecture

```text
REST Countries API
        │
        ▼
MinIO
        │
        ▼
Snowflake RAW
        │
        ▼
Bronze
        │
        ▼
Silver
        │
        ▼
Gold
        │
        ▼
Analytics
        │
        ▼
Power BI / Tableau
```

---

# Layer Responsibilities

## Bronze

Purpose

- Read raw data from Snowflake.
- Preserve the source data.
- Apply minimal transformations.
- Standardise column names.

---

## Silver

Purpose

- Flatten nested JSON.
- Clean and standardise data.
- Handle missing values.
- Remove duplicates.
- Apply business validation.

---

## Gold

Purpose

- Build business-ready models.
- Create dimensions.
- Create fact tables.
- Optimise datasets for reporting and analytics.

---

# Current Implementation

The following components have been implemented within the dbt project.

## Project Configuration

- ✅ dbt Core installed
- ✅ dbt-snowflake adapter configured
- ✅ `dbt_project.yml` configured
- ✅ `profiles.yml` configured
- ✅ `packages.yml` configured
- ✅ Successful connection to Snowflake

---

## Snowflake Integration

- ✅ Connected to Snowflake warehouse
- ✅ Connected to TRIPLENS database
- ✅ Connected to BRONZE, SILVER, GOLD and ANALYTICS schemas

---

## Project Features

- ✅ Bronze → Silver → Gold architecture
- ✅ Incremental models
- ✅ Snapshots
- ✅ Source freshness checks
- ✅ Generic tests
- ✅ Custom macros
- ✅ Modular project structure
- ✅ Model documentation
- ✅ Data lineage generation

---

# Data Quality

Current validation includes:

- Unique tests
- Not Null tests
- Accepted Values tests
- Relationship tests
- Source Freshness validation

Additional business validation rules will be added as new models are developed.

---

# Documentation

dbt automatically generates:

- Project documentation
- Model documentation
- Dependency graph
- Data lineage
- Column descriptions

These artefacts provide visibility into the transformation pipeline and model dependencies.

---

# Current Development Status

| Component | Status |
|-----------|--------|
| dbt Environment | ✅ Complete |
| Snowflake Connection | ✅ Complete |
| Packages | ✅ Installed |
| Documentation | ✅ Configured |
| Lineage | ✅ Configured |
| Bronze Models | 🚧 In Progress |
| Silver Models | 📅 Planned |
| Gold Models | 📅 Planned |
| Analytics Models | 📅 Planned |

---

# Development Standards

The project follows these principles:

- Layered architecture
- Modular SQL models
- Reusable transformations
- Version-controlled development
- Automated validation
- Consistent naming conventions
- Documentation-first approach

---

# Next Development Phase

The next stage of development focuses on:

- Completing Bronze models.
- Building Silver transformation models.
- Developing Gold business models.
- Creating analytics-ready datasets for Power BI and Tableau.

---

# Related Documents

- `01_ARCHITECTURE.md`
- `05_MINIO_GUIDE.md`
- `06_SNOWFLAKE_GUIDE.md`
- `08_TROUBLESHOOTING.md`


# dbt Commands

Navigate to the dbt project.

```bash
cd dbt/dbt_triplens
```

---

## Activate Virtual Environment

```bash
source ../../venv/bin/activate
```

---

## Verify dbt Installation

```bash
dbt --version
```

---

## Verify Snowflake Connection

```bash
dbt debug
```

---

## Install Packages

```bash
dbt deps
```

Downloads packages defined in `packages.yml`.

---

## Parse the Project

```bash
dbt parse
```

Checks project syntax without executing models.

---

## Compile Models

```bash
dbt compile
```

Compiles SQL models without running them.

---

## Run All Models

```bash
dbt run
```

Executes every model in the project.

---

## Run a Specific Model

```bash
dbt run --select <model_name>
```

Example

```bash
dbt run --select stg_countries
```

---

## Run a Folder

```bash
dbt run --select bronze
```

Examples

```bash
dbt run --select silver
```

```bash
dbt run --select gold
```

---

## Run with Full Refresh

```bash
dbt run --full-refresh
```

Rebuilds incremental models from scratch.

---

## Execute Tests

```bash
dbt test
```

Runs all configured tests.

---

## Execute Tests for One Model

```bash
dbt test --select <model_name>
```

---

## Execute Snapshots

```bash
dbt snapshot
```

Captures historical changes.

---

## Check Source Freshness

```bash
dbt source freshness
```

Validates freshness of configured sources.

---

## Generate Documentation

```bash
dbt docs generate
```

Creates project documentation and lineage.

---

## View Documentation

```bash
dbt docs serve
```

Opens the local documentation site.

---

## List Available Resources

```bash
dbt ls
```

Lists all models, tests, snapshots, sources and macros.

---

## Clean Build Artifacts

```bash
dbt clean
```

Removes generated files.

---

## Seed Data

```bash
dbt seed
```

Loads CSV seed files into Snowflake.

---

## Build Project

```bash
dbt build
```

Runs:

- Models
- Tests
- Snapshots
- Seeds

according to project dependencies.

---

## Run a Macro

```bash
dbt run-operation <macro_name>
```

Example

```bash
dbt run-operation generate_schema_name
```

---

## Display Help

```bash
dbt --help
```

# Typical Development Workflow

```bash
cd dbt/dbt_triplens

source ../../venv/bin/activate

dbt debug

dbt deps

dbt parse

dbt compile

dbt run

dbt test

dbt docs generate

dbt docs serve
```