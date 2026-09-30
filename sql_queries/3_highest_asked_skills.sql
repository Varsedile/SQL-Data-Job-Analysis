SELECT sd.skills AS skill_name, COUNT(job_id) AS jobs_posted
FROM job_postings
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE job_work_from_home = TRUE
    AND job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY jobs_posted DESC
LIMIT 5;