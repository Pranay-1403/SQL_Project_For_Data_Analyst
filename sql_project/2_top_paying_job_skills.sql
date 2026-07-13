WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Scientist'
    AND job_country = 'India'
    AND salary_year_avg IS NOT NULL
    ORDER BY
    salary_year_avg DESC
    LIMIT 10
) 

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;




WITH ranked_jobs AS (
    SELECT  
        job_id,
        job_title,
        job_title_short,
        salary_year_avg,
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
SELECT 
    ranked_jobs.job_id,
    ranked_jobs.job_title,
    ranked_jobs.job_title_short,
    ranked_jobs.salary_year_avg,
    ranked_jobs.company_name,
    skills_dim.skills
FROM ranked_jobs
INNER JOIN skills_job_dim 
    ON ranked_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE ranked_jobs.rn <= 5
ORDER BY ranked_jobs.job_title_short, ranked_jobs.salary_year_avg DESC;



