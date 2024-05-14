/*
What are the top paying data analyst jobs?
Deliverables:
    - Top 10 highest paying roles that are available remotely
    - Why? Highlight the common trends for example most common skills for these top paying jobs
    - Focus on specific salaries within certain ranges removing nulls and anomalies
*/

-- selected the most important columns and removed NULL salary values
SELECT
    job_id,
    job_title,
    company_dim.name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM job_postings_fact
-- If would be interesting to add company information so lets add left join
-- then add company name in the SELECT section above ^^
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title_short = 'Data Analyst'
    AND job_location LIKE '%Anywhere%'
ORDER BY
    salary_year_avg DESC
LIMIT 10