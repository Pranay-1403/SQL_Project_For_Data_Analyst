SELECT	
	job_id,
	job_title,
	job_title_short,
	job_country,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Scientist'
      AND job_country = 'India'
      AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10; 




WITH ranked_jobs AS (
    SELECT
        job_id,
        job_title,
        job_title_short,
        job_country,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short 
            ORDER BY salary_year_avg DESC
        ) AS rn
    FROM job_postings_fact
    LEFT JOIN company_dim 
        ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short IN ('Data Scientist', 'Data Analyst', 'Data Engineer')
      AND job_country = 'India'
      AND salary_year_avg IS NOT NULL
)
SELECT *
FROM ranked_jobs
WHERE rn <= 5
ORDER BY job_title_short, salary_year_avg DESC;



