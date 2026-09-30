DROP TABLE IF EXISTS job_postings, company_dim, skills_dim, skills_job_dim;

CREATE TABLE IF NOT EXISTS job_postings(
    job_id BIGINT PRIMARY KEY,
    company_id BIGINT,
    job_title_short TEXT,
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC
);

CREATE TABLE IF NOT EXISTS company_dim (
    company_id BIGINT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

CREATE TABLE IF NOT EXISTS skills_dim (
    skill_id BIGINT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

CREATE TABLE IF NOT EXISTS skills_job_dim (
    job_id BIGINT REFERENCES job_postings(job_id),
    skill_id BIGINT REFERENCES skills_dim(skill_id)
);

COPY job_postings FROM 'csv_files/job_postings.csv' WITH (FORMAT csv, HEADER true, DELIMITER E'\t', QUOTE '"', NULL '');
COPY company_dim FROM 'csv_files/company_info.csv' WITH (FORMAT csv, HEADER true, DELIMITER E'\t', QUOTE '"', NULL '');
COPY skills_dim FROM 'csv_files/skill_info.csv' WITH (FORMAT csv, HEADER true, DELIMITER E'\t', QUOTE '"', NULL '');
COPY skills_job_dim FROM 'csv_files/id_info.csv' WITH (FORMAT csv, HEADER true, DELIMITER E'\t', QUOTE '"', NULL '');
