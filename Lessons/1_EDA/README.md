# Exploratory Data Analysis w/ SQL: Job Market Analysis

This is a SQL project that analyzes the Scandinavian job market (Sweden, Denmark, and Norway) for Data Engineering and Data Scientist positions. 
**The abilities demonstrated in this project are analytical SQL, design efficient queries and data-driven insights**

## Executive Summary
Project scope

Data modeling

Analytics

Outcomes

TL/DR: 

1. [`01_top_demanding_skills.sql`](01_top_demanding_skills.sql) - demand analysis with multi-table joins
2. [`02_top_payings_skills.sql`](./02_top_payings_skills.sql) - salary analysis with aggregations
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) - combined demand/salary optimization query


## Problem and Context
With an ever-increasing number of tools for data engineers and data scientist, **which skills are the most demanded and the highest paid?** and **what is the optimal sill set that balances demand and compensation**

The project goes through a **data warehouse** built using a **start schema design**. The warehouse structure consists of:

![Data Warehouse](..//Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact`- Central table that contains job posting details (job titles, locations, salaries, etc.)
- **Dimenstion Tables:**
    - `company_dim`- Company information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skill_job_dim`- Resolves the many-to-many relationship between job postings and skills

## Tech Stack
- Query Engine: DuckDB was used for OLAP-style analytical queries
- Language: SQL
- Data Model: Star schema with fact + dimension + bridge tables
- Development: VS Code for SQL editing + Terminal for DuckDB CLI
- Version Control: Git/GitHub for versioned SQL scripts

## Analysis Overview
### Query Structure
1. **[Top Demanded Skills](./01_top_demanding_skills.sql)**
2. **[Top Paying Skills](./02_top_payings_skills.sql)**
3. **[Optimal Skills](./03_optimal_skills.sql)**

### Key Insights
- Core Languages: The most demanded tasks by count are Python and SQL.
- Cloud Platforms: Azure is slightly ahead of AWS with 441 and 295, respectively.
- Infra and Tooling
- Big Data Tools

## SQL Skills Demonstration
### Query Design & Optimization

### Data Analysis Techniques
