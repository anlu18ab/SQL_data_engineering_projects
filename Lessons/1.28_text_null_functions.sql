SELECT LENGTH ('HELLO');

SELECT LOWER ('HELLO');
SELECT UPPER ('Hello');

SELECT LEFT('Hello',4);
SELECT SUBSTRING('Hello',3,2);

SELECT CONCAT('HELLO','+','DOC');

-- Takes out blanc spaces
SELECT TRIM(' HELLO. ');

SELECT REPLACE('SQL','Q','_');
SELECT REGEXP_REPLACE('data.berd@gmail.com', '^.*(@)', '\1');

-- Cleanup using Text Functions
WITH title_lower AS (
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)

SELECT  
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Engineer'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientist%' THEN 'Data Scientist'
        ELSE 'Other'
    END AS job_title_category
    FROM title_lower
ORDER BY RANDOM()
LIMIT 30;

SELECT NULLIF(10,10);

SELECT COALESCE(NULL, 1, 2);

SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;

-- Simplify with Coalesce
SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE
        WHEN     COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'missing'
        WHEN     COALESCE(salary_year_avg, salary_hour_avg * 2080) THEN 'low'
        WHEN     COALESCE(salary_year_avg, salary_hour_avg * 2080) THEN 'medium'
        ELSE 'high'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC;