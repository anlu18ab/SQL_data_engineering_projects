

-- STEP 1: DW - create star schema tables
.read 01_create_tables_dw.sql

-- STEP 2: DW - load data from CSV files into tables
.read 02_load_schema_dw.sql