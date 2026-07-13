SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_country = 'India'
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25 ;



WITH skill_salary AS (
    SELECT 
        job_title_short,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short 
            ORDER BY AVG(salary_year_avg) DESC
        ) AS rn
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short IN ('Data Scientist', 'Data Analyst', 'Data Engineer')
      AND job_country = 'India'
      AND salary_year_avg IS NOT NULL
    GROUP BY job_title_short, skills_dim.skills
)
SELECT job_title_short, skills, avg_salary
FROM skill_salary
WHERE rn <= 25
ORDER BY job_title_short, avg_salary DESC;


