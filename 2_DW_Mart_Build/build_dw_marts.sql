-- duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- STEP 1: DW - create star schema tables
.read 01_create_tables_dw.sql

-- STEP 2: DW - load data from CSV files into tables
.read 02_load_schema_dw.sql

-- STEP 3: Mart - create flat mart
.read 03_create_flat_mart.sql

-- STEP 4: Mart - Create skills demand mart
.read 04_create_skills_marts.sql