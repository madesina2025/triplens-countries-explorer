# TripLens Countries Explorer — Analytics Engineering Architecture

## Project Goal

TripLens is an end-to-end analytics engineering project that uses Snowflake and dbt to transform raw country data into clean, analytics-ready models for Power BI and Tableau.

## Data Flow

REST Countries API / JSON
→ Snowflake Bronze
→ dbt Silver
→ dbt Gold
→ dbt Analytics Marts
→ Power BI / Tableau

## Layers

### Bronze Layer
Stores raw country JSON data with minimal transformation.

### Silver Layer
Cleans, standardises and flattens country data into reliable analytical tables.

### Gold Layer
Creates dimensions and facts for reporting.

### Analytics Marts
Creates dashboard-ready summary tables.

## BI Outputs

- Executive Overview
- Regional Comparison
- Country Explorer
- Population Ranking
- Language and Currency Analysis