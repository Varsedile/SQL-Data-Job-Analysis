WITH highest_jobs AS (
    SELECT job_id
    FROM job_postings AS jp
    LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)

SELECT sd.skills AS skill_name, COUNT(sd.skills) AS count_skills, sd.type AS skill_type
FROM highest_jobs
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
GROUP BY sd.skills, sd.type
ORDER BY count_skills DESC;