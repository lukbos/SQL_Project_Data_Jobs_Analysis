/*
What are the skills associated with the top paying roles?
    - Start with the top_paying_jobs query
    - Add columns regarding specific required skills (table join)
    - IMPORTANT: WHY? What are the skills listed in high-paying jobs,
      so we can inform job seekers what skills to develop when learning data analytics
*/

-- Modifying the top_paying_jobs query from earlier, we need a CTE or sub-query
-- Use WITH to make a CTE
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        company_dim.name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        salary_year_avg IS NOT NULL
        AND job_title_short = 'Data Analyst'
        AND job_location LIKE '%Anywhere%'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
-- We want to join top_paying_jobs data and skills data and we don't care about jobs without skills, therefore INNER JOIN
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC

/*
Breakdown:
    SQL is leading with a bold count of 8.
    Python follows closely with a bold count of 7.
    Tableau is also highly sought after, with a bold count of 6.
    Other skills like R, Snowflake, Pandas, and Excel show varying degrees of demand.
The following is a JSON export of the top 10 data analyst jobs,

It only includes entries with skills information:

[
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "sql"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "python"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "r"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "azure"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "databricks"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "aws"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "pandas"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "pyspark"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "jupyter"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "excel"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "tableau"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "power bi"
  },
  {
    "job_id": 552322,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "255829.5",
    "name": "AT&T",
    "skills": "powerpoint"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "name": "Pinterest Job Advertisements",
    "skills": "sql"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "name": "Pinterest Job Advertisements",
    "skills": "python"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "name": "Pinterest Job Advertisements",
    "skills": "r"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "name": "Pinterest Job Advertisements",
    "skills": "hadoop"
  },
  {
    "job_id": 99305,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "232423.0",
    "name": "Pinterest Job Advertisements",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "name": "Uclahealthcareers",
    "skills": "sql"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "name": "Uclahealthcareers",
    "skills": "crystal"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "name": "Uclahealthcareers",
    "skills": "oracle"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "name": "Uclahealthcareers",
    "skills": "tableau"
  },
  {
    "job_id": 1021647,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "217000.0",
    "name": "Uclahealthcareers",
    "skills": "flow"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "sql"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "python"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "go"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "snowflake"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "pandas"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "numpy"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "excel"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "tableau"
  },
  {
    "job_id": 168310,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "205000.0",
    "name": "SmartAsset",
    "skills": "gitlab"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "sql"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "python"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "azure"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "aws"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "oracle"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "snowflake"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "tableau"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "power bi"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "sap"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "jenkins"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "bitbucket"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "atlassian"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "jira"
  },
  {
    "job_id": 731368,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189309.0",
    "name": "Inclusively",
    "skills": "confluence"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "sql"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "python"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "r"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "git"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "bitbucket"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "atlassian"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "jira"
  },
  {
    "job_id": 310660,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "189000.0",
    "name": "Motional",
    "skills": "confluence"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "sql"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "python"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "go"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "snowflake"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "pandas"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "numpy"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "excel"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "tableau"
  },
  {
    "job_id": 1749593,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "186000.0",
    "name": "SmartAsset",
    "skills": "gitlab"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "name": "Get It Recruit - Information Technology",
    "skills": "sql"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "name": "Get It Recruit - Information Technology",
    "skills": "python"
  },
  {
    "job_id": 387860,
    "job_title_short": "Data Analyst",
    "salary_year_avg": "184000.0",
    "name": "Get It Recruit - Information Technology",
    "skills": "r"
  }
]

*/

