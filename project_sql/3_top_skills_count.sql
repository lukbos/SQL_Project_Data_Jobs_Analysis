/*
We want to know the most in demand skills by count
    Join job postings to skills related tables using inner join
    We want to focus on all job postings
    Why? Return insights on the top 5 most in demand skills,
    Helping Job Seekers know the most valued skills
*/

-- Job_id lets us find skills_id which lets us find skills descriptive data that need to be added to the job posting table

SELECT
    skills_dim.skills,
    COUNT(skills_job_dim.skill_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
-- We're only concerned about data_analysts and work from home options
WHERE 
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_work_from_home = TRUE
-- summarize the count by skill type
GROUP BY 
    skills_dim.skills
-- Top 5 in demand skills only
ORDER BY 
    demand_count DESC
LIMIT 5