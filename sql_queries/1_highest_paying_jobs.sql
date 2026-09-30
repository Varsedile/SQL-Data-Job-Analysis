SELECT job_title_short, job_title, job_location, job_country, salary_year_avg, cd.name AS company_name
FROM job_postings AS jp
LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;