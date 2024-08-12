/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
Focuses on roles with specified salaries, regardless of location
Why? It reveals how different skills impact salary levels for Data Analyst and 
helps identify the most financially rewarding skills to acquire or improve
*/




SELECT 
        skills,
       ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short ='Data Analyst'
      AND salary_year_avg IS NOT NULL
      AND job_work_from_home = TRUE
GROUP BY
        skills
 ORDER BY
         avg_salary DESC       
LIMIT 25;

/*

Here are some quick insights into the trends seen in the top-paying data analysis jobs based on the skills provided:

Big Data and Cloud Technologies:
PySpark stands out as the highest-paying skill with an average salary of $208,172.25, reflecting the increasing demand for handling and processing large-scale data in distributed computing environments.
Databricks ($141,906.60) and GCP ($122,500.00) are also notable, indicating that cloud-based big data platforms are highly valued.

DevOps and Version Control:
Bitbucket ($189,154.50), GitLab ($154,500.00), and Jenkins ($125,436.33) highlight the importance of continuous integration/continuous deployment (CI/CD) pipelines and version control systems in data projects.
Kubernetes ($132,500.00) emphasizes the growing need for containerization and orchestration skills in deploying scalable data solutions.

Machine Learning and AI:
DataRobot ($155,485.50), Scikit-learn ($125,781.25), and Watson ($160,515.00) show that expertise in machine learning frameworks and AI platforms commands high salaries, reflecting the push towards automating insights and decision-making processes.
*/