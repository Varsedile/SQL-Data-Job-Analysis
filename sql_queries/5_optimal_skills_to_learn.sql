SELECT sd.skills AS skill_name, ROUND(AVG(salary_year_avg), -3) AS avg_salary, COUNT(job_id) AS jobs_posted
FROM job_postings
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
GROUP BY sd.skills
HAVING COUNT(job_id) > 10
ORDER BY avg_salary DESC, jobs_posted DESC
LIMIT 25;