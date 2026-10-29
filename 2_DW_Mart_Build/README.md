# Data Warehouse & Mart Build: Production ETL Pupeline
An end-to-end data engineering pipeline that transforms raw CSV files from Google Cloud Storage into a normalized star schema data warehouse, then builds analytical data marts.

![EDA Project Overview](..//Images/1_2_Project2_Data_Pipeline.png)

## Executive Summary (for Hiring Managers)
- **Pipeline scope:** Built a complete **ETL pipeline** from raw CSVs to star schema warehouse to analytical marts

- **Data modeling:** Designed a **star schema** with fact tables, dimensions, and bridge tables for many-to-many relationships

- **ETL development:** Implemented **extract, transform, load** processes with idempotent operations and data quality checks

 - **Mart architecture:** Created **specialized data marts** (flat, skills, priority) with additive measures and incremental update patterns


## Problem and Context
Raw job posting data arrives as flat CSV files in Google Cloud Storage, this project prepares the data in order to make it ready for analysts to generate insights. Among the questions asked we have:
- Which skills are most in-demand over time?
- What are hiring trends by company and location?
- How do salary patterns vary by role and skill?

**Challenge:** Data teams need a single source of truth system to enable consistent, reliable analysis across the organization, such as a data warehouse. Additionally, specialized data marts are useful to optimize resources by pre-aggregating data for specific business use cases, reducing query complexity and improving performance for common analytical patterns.

**Solution:** End-to-end ETL pipeline that extracts CSVs from cloud storage, normalizes them into a star schema warehouse (separating facts from dimensions), and creates specialized data marts optimized for specific use cases (flat queries, skill demand analysis, priority role tracking).

## Tech Stack
- **Database:** DuckDB (file-based OLAP database)
- **Language:** SQL (DDL for schema design, DML for data loading and transformation)
- **Data Model:** Star schema (fact + dimension + bridge tables)
- **Development:** VS Code for SQL editing + Terminal for DuckDB CLI execution
- **Automation:** Master SQL script for pipeline orchestration
- **Version Control:** Git/GitHub for versioned pipeline scripts
- **Storage:** Google Cloud Storage for source CSV files

## Pipeline Architecture
The pipeline transforms job posting CSVs from Google Cloud Storage into a normalized star schema data warehouse, then builds specialized analytical data marts.

### Data Warehouse
The data warehouse implements a star schema with `company_dim`, `skills_dim`, `job_postings_fact`, and `skills_job_dim` tables.
- **SQL Files:**
    - [`01_create_tables_dw.sql`](01_create_tables_dw.sql)
     – Defines star schema with 4 core tables
    - [`02_load_schema_dw.sql`](02_load_schema_dw.sql) – Extracts CSVs from GCS and loads into warehouse tables
- **Purpose:** Star schema serving as single source of truth for analytical queries
- **Grain:** One row per job posting in the fact table (`job_postings_fact`)

### Flat Mart
Denormalized table with all dimensions for ad-hoc queries.
- **SQL File:** [`03_create_flat_mart.sql`](03_create_flat_mart.sql) – Builds denormalized table with all dimensions joined
- **Purpose:** Denormalized table for quick ad-hoc queries
- **Grain:** One row per job posting with all dimensions joined

### Skills Mart
Time-series skill demand analysis with additive measures.
- **SQL File:** [`04_create_skills_marts.sql`](04_create_skills_marts.sql) 04_create_skills_mart.sql – Builds time-series skill demand mart
- **Purpose:** Time-series analysis of skill demand over time with additive measures
-  **Grain:** `skill_id` + `month_start_date` + `job_title_short`
- **Key Features:** All measures are additive (counts/sums) for safe re-aggregation

### Priority Mart
Priority role tracking with incremental updates using MERGE operations.
- **SQL Files:**
    - [`05_create_priority_mart.sql`](05_create_priority_mart.sql) – Initial build of priority roles and jobs snapshot
    - [`06_update_priority_mart.sql`](06_update_priority_mart.sql) – **Incremental update using MERGE** (upsert pattern)
- **Purpose:** Track priority roles and job snapshots with incremental update capabilities
- **Grain:** One row per job posting with priority level assignment
- **Key Features:** **MERGE operations for incremental updates** - demonstrates production-ready upsert patterns (INSERT, UPDATE, DELETE in single statement)

## Data Engineering Skills Demonstrated
### ETL Pipeline Development
- **Extract:** Direct CSV loading from Google Cloud Storage using DuckDB
- **Transform:** Data normalization, type conversion (`CAST`, `DATE_TRUNC`), and quality filtering
- **Load:** Table creation with `DROP TABLE IF EXISTS` patterns
- **Incremental updates:** `MERGE` operations for upsert patterns (`INSERT`, `UPDATE`, `DELETE` in single statement)
- **Orchestration:** Master SQL script (build_dw_marts.sql) for automated pipeline execution

### Dimensional Modeling
- **Star Schema Design:** Fact table (`job_postings_fact`) with dimension tables (`company_dim`, `skills_dim`)
- **Grain Definition:** Proper fact table granularity (skill+month, company+title+location+month)
- **Additive Measures:** Counts and sums that can be safely re-aggregated at any level

### SQL Advanced Techniques
- **DDL Operations:** `CREATE TABLE`, `DROP TABLE`, `CREATE SCHEMA` for schema management
- **DML Operations:** `INSERT INTO ... SELECT` with explicit column mapping from CSV sources
- **MERGE Operations:** Incremental updates using `MERGE INTO` with `WHEN MATCHED`, `WHEN NOT MATCHED`, and `WHEN NOT MATCHED BY SOURCE` clauses for production-ready upsert patterns
- **CTEs:** Common Table Expressions for complex transformations and boolean flag conversions
- **Date Functions:** `DATE_TRUNC`('month'), `EXTRACT`(quarter) for temporal dimension creation
- **String Functions:** `STRING_AGG` for concatenation, `REPLACE` for data cleaning
- **Boolean Logic:** `CASE WHEN` conversions for aggregating flags (remote, health insurance, no degree)

### Data Quality & Production Practices
- **Idempotency:** All scripts safely rerunnable without side effects
- **Data Validation:** Verification queries at each pipeline step to ensure data integrity
- **Type Safety:** Proper data type definitions (`VARCHAR`, `INTEGER`, `DOUBLE`, `BOOLEAN`, `TIMESTAMP`)
- **Schema Organization:** Separate schemas (`flat_mart`, `skills_mart`, `priority_mart`) for logical separation
- **Error Handling:** Structured script execution with clear error messages and progress reporting