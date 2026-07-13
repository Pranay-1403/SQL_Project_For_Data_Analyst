SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' 
    AND job_country = 'India'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;



SELECT 
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short IN ('Data Scientist', 'Data Analyst', 'Data Engineer')
  AND job_country = 'India'
GROUP BY skills_dim.skills
ORDER BY demand_count DESC
LIMIT 5;




WITH skill_rank AS (
    SELECT 
        job_title_short,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROW_NUMBER() OVER (
            PARTITION BY job_title_short 
            ORDER BY COUNT(skills_job_dim.job_id) DESC
        ) AS rn
    FROM job_postings_fact
    INNER JOIN skills_job_dim 
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim 
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short IN ('Data Scientist', 'Data Analyst', 'Data Engineer')
      AND job_country = 'India'
    GROUP BY job_title_short, skills_dim.skills
)
SELECT job_title_short, skills, demand_count
FROM skill_rank
WHERE rn <= 5
ORDER BY job_title_short, demand_count DESC;

