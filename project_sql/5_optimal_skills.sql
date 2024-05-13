/*
Find the optimal skills to learn (both high demand and high salaries)
    - Identify skills associated with high demand and high salaries
    - Focus on remote positions with specific salaries
    - Why? Targeting jobs that offer job stability and financial benefits,
      to help job seekers career development as a data analyst
*/

-- Use properties of Query 3 and 4
-- lets put them both inside a CTE

-- QUERY 3 (top skills), removing LIMIT, ORDER BY, add skill_id to SELECT and change GROUP BY to skill_id
    WITH skills_demand AS (
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.skill_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id
    ORDER BY 
        demand_count DESC
)

-- QUERY 4 (highest paying skills), removing LIMIT, ORDER BY and add skill_id  to SELECT and change GROUP BY to skill_id
, average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_postings_fact.job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_job_dim.skill_id
    ORDER BY 
        avg_salary DESC
)


SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25