# Exploratory Data Analysis w/ SQL: Job Market Analysis (Scandinavia)

This is a SQL project that analyzes the Scandinavian job market (Sweden, Denmark, and Norway) for Data Engineering and Data Scientist positions. 
**The abilities demonstrated in this project are analytical SQL, design efficient queries and data-driven insights**

![EDA Project Overview](..//Images/1_1_Project1_EDA.png)

## Executive Summary (for Hiring Managers)
- **Project scope:** Built **3 analytical queries** that answer insightful questions about the data engineer market in Scandinavia.
- **Data modeling:** Used **multi-table joins** across fact and dimension tables to extract insights.
- **Analytics:** Applied **aggregations, filtering, and sorting** to find top skills by demand, salary, and value.
- **Outcomes:** Discovered **actionable insights** on the importance of SQL and Python, cloud preference and salary patterns.

**TL/DR:** 

1. [`01_top_demanding_skills.sql`](01_top_demanding_skills.sql) - demand analysis with multi-table joins
2. [`02_top_payings_skills.sql`](./02_top_payings_skills.sql) - salary analysis with aggregations
3. [`03_optimal_skills.sql`](./03_optimal_skills.sql) - combined demand/salary optimization query


## Problem and Context
With an ever-increasing number of tools for data engineers and data scientist, this small project seeks to understand:
- **Which skills are the most demanded and the highest paid?** and 
- **What is the optimal sill set that balances demand and compensation**

The project goes through a **data warehouse** built using a **start schema design**. The warehouse structure consists of:

![Data Warehouse](..//Images/1_2_Data_Warehouse.png)

- **Fact Table:** `job_postings_fact`- Central table that contains job posting details (job titles, locations, salaries, etc.)
- **Dimenstion Tables:**
    - `company_dim`- Company information linked to job postings
    - `skills_dim` - Skills catalog with skill names and types
- **Bridge Table:** `skill_job_dim`- Resolves the many-to-many relationship between job postings and skills

## Tech Stack
- **Query Engine:** DuckDB was used for OLAP-style analytical queries
- **Language:** SQL
- **Data Model:** Star schema with fact + dimension + bridge tables
- **Development:** VS Code for SQL editing + Terminal for DuckDB CLI
- **Version Control:** Git/GitHub for versioned SQL scripts

## Analysis Overview
### Query Structure
1. **[Top Demanded Skills](./01_top_demanding_skills.sql)** – Identifies the 10 most in-demand skills for remote data engineer positions
2. **[Top Paying Skills](./02_top_payings_skills.sql)** – Analyzes the 25 highest-paying skills with salary and demand metrics
3. **[Optimal Skills](./03_optimal_skills.sql)** – Calculates an optimal score using natural log of demand combined with median salary to identify the most valuable skills to learn

### Key Insights
- **Core Languages:** The most demanded tasks by count are Python and SQL.
- **Cloud Platforms:** Azure is slightly ahead of AWS with 441 and 295, respectively.

## SQL Skills Demonstrated
### Query Design & Optimization
- **Complex joins:** Multi-table `INNER JOIN` operations across job_postings_fact, skills_job_dim, and skills_dim
- **Aggregations:** `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering:** Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting:** `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques
- **Grouping:** `GROUP BY` for categorical analysis by skill
- **Mathematical Functions:** `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics:** Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause:** Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling:** Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)
