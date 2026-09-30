SELECT sd.skills AS skill_name, ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skill_name
HAVING AVG(salary_year_avg) > 100000
ORDER BY avg_salary DESC;
