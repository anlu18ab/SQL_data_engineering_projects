/*
Question: What are the most in-demand skills for data engineers?
- Join job postings to inner join table similar to query 2
- Identify the top 10 in-demand skills for data engineers
- Focus on jobs in Sweden
- Why? Retrieves the top 10 skills with the highest demand in the remote job market,
    providing insights into the most valuable skills for data engineers seeking remote work
*/

SELECT 
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM job_postings_fact as jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sd.skill_id = sjd.skill_id
WHERE 
   jpf.job_title_short IN ('Data Engineer', 'Data Scientist')
    AND (jpf.job_location IN ('Denmark', 'Sweden','Norway'))
GROUP BY
    sd.skills
ORDER BY demand_count DESC
LIMIT 10;

/*
┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ python     │          776 │
│ sql        │          660 │
│ azure      │          384 │
│ aws        │          253 │
│ r          │          201 │
│ spark      │          175 │
│ databricks │          171 │
│ power bi   │          144 │
│ git        │          142 │
│ airflow    │          124 │
└────────────┴──────────────┘
*/