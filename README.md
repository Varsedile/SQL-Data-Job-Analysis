# Job Analysis Data in SQL

In this project, I explored the Job Analysis data using SQL.

### 1. What were the highest paying jobs in the Data Analyst field?
*Where you could work remotely.*

```sql
SELECT job_title_short, job_title, job_location, job_country, salary_year_avg, cd.name AS company_name
FROM job_postings AS jp
LEFT JOIN company_dim AS cd ON jp.company_id = cd.company_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;
```

The highest paid job had a salary of $650,000 in a company called Mantys.

### 2. What were the most sought after skills in the highest 10 paying jobs?
*Where you could work remotely.*

```sql
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
```

The most sought after skill for Data Analysts were, to no one's surprise, SQL (programming) with 7 requirements.

### 3. What was the highest asked skills for a data analyst?
*And where you could work from home.*

```sql
SELECT sd.skills AS skill_name, COUNT(job_id) AS jobs_posted
FROM job_postings
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE job_work_from_home = TRUE
    AND job_title_short = 'Data Analyst'
GROUP BY sd.skills
ORDER BY jobs_posted DESC
LIMIT 5;
```

It was once again SQL with 725 requirements.

### What was the average salary by skill?
*For a data analyst.*

```sql
SELECT sd.skills AS skill_name, ROUND(AVG(salary_year_avg)) AS avg_salary
FROM job_postings
INNER JOIN skills_job_dim AS sjd USING (job_id)
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skill_name
HAVING AVG(salary_year_avg) > 100000
ORDER BY avg_salary DESC;
```

The highest was svn with a whopping $400,000.

### What are the most optimal skills to learn in reference with jobs posted and average salary?
*For a data analyst, and who can work from home.*

```sql
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
```

Go is the most optimal skill, with 27 jobs posted, and a salary of $115,000, but others like confluence, snowflake and hadoop are not far behind with a difference of just ~$1000.
