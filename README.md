# Introduction
The field of data analytics continues to grow in importance as organizations increasingly rely on data-driven decision-making. For data analysts, understanding the job market—particularly the roles that offer the highest salaries—is essential for strategic career planning. This project, titled "Job Analysis," aims to provide insights into the top-paying data analyst positions, the skills required for these roles, and the most in-demand skills within the industry. By analyzing job postings and salary data, this project helps identify the skills that align with both high demand and high pay, guiding professionals toward optimal career development.

SQL queries? Check them out her:

[project_sql_folder](C:\Users\Admin\SQL_Project_Data_Job_Analysis\project_sql)

# Background
In today's competitive job market, data analysts must stay ahead by focusing on skills that are both in demand and financially rewarding. Remote work has expanded opportunities, allowing professionals to access high-paying roles regardless of location. However, the landscape is complex, with varying salary levels depending on specific skills, industries, and job roles. This project seeks to demystify the job market for data analysts by analyzing job postings, identifying the highest-paying roles, and determining which skills are most valued by employers. The goal is to provide actionable insights for data analysts looking to maximize their career potential.

The data I used are in the link below:
  *https://github.com/MarkswellOuma/SQL_Project_Data_Job_Analysis/blob/main/.gitignore*

# Tools I used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL & PostgreSQL:** SQL and PostgreSQL were fundamental in extracting, filtering, and analyzing data from job postings. These tools allowed for efficient querying and manipulation of large datasets, particularly in focusing on roles with specified salaries and remote work options.

- **Git & GitHub:** Git and GitHub were utilized for version control and collaboration. Git ensured that changes to the project’s code and data analyses were tracked meticulously, while GitHub provided a platform for storing, sharing, and managing the project files, enabling seamless collaboration and iteration throughout the project.

- **VS Code:** VS Code was used as the primary integrated development environment (IDE) for writing and editing SQL queries, as well as managing version control through Git. Its extensions and customization options made it easier to work with different file types and maintain code quality.

# The Analysis
Each query on this project aimed at investigating specific aspects of the data analyst job market.

Here is how I approache each question:

### 1.Top Paying Data analyst jobs
To identify the highest-paying roles I filtred data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
FROM
        job_postings_fact  
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id         
WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'   AND 
        salary_year_avg   IS NOT NULL     
ORDER BY
        salary_year_avg DESC
LIMIT 10;        
```          

Here is the breakdown of the top data analyst jobs in 2023:

1. **Wide Salary Range:**
The salary_year_avg column ranges from $217,000 to $650,000.
The highest-paying role is a "Data Analyst" at Mantys, with an annual average salary of $650,000.
The lowest-paying role is a "Data Analyst (Hybrid/Remote)" at Uclahealthcareers, with an annual average salary of $217,000.
This indicates a significant salary variation, potentially reflecting differences in job responsibilities, experience requirements, or company size.
2. **Diverse Employers:**
The dataset includes a variety of employers, ranging from tech giants like Meta and AT&T to healthcare organizations like Uclahealthcareers.
Companies span different industries, including social media (Pinterest), telecommunications (AT&T), and technology (Meta), showing that data analysis roles are in demand across various sectors.
3. **Job Title Variety:**
There is a diverse range of job titles, from "Data Analyst" to more senior roles like "Director of Analytics" and "Associate Director- Data Insights."
The titles reflect different levels of responsibility, with some roles focused on general data analysis, while others involve leadership in data strategy and insights.

![Top Paying Roles](Assets\1_top_paying_roles.png.png)
*Bar graph visualizing the salary for the top 10 saries for data analysts; ChatGPT generated this graph from my SQL query results*

![Top Paying Roles](Assets\job_titles_by_company.png)
*Bar graph visualizing the number of job titles for the top 10 companies for data analysts; ChatGPT generated this graph from my SQL query results*

### 2.Top Paying Job skills
To identify the top paying job skills I used the below  SQL query to retrieve the top 10 highest-paying "Data Analyst" remote jobs by joining job postings with company and skills data. I filtered for non-null salaries, ordered results by salary, and combined job titles with their associated skills, providing a detailed view of the highest-paying skills.

```sql
WITH top_paying_jobs AS (

SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
FROM
        job_postings_fact  
LEFT JOIN company_dim ON job_postings_fact.company_id=company_dim.company_id         
WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere'   AND 
        salary_year_avg   IS NOT NULL     
ORDER BY
        salary_year_avg DESC
LIMIT 10
)     

SELECT 
        top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
        salary_year_avg DESC;

```

Here are the Insights

- **SQL** and **Python** are the most critical skills for high-paying data roles.
- **Tableau** is the top data visualization tool, highlighting its importance in the industry.
- Skills related to data manipulation and analysis, such as **Pandas, Excel, and Snowflake**, are also highly valued.
- Cloud-based tools like **Azure** and **AWS** are increasingly important, indicating a trend towards cloud computing in data roles.

![Top Paying Job Skills](Assets\top_paying_job_skills.png)
*Here is a graph illustrating the demand for various skills in top-paying jobs. The bar chart shows that SQL and Python are the most sought-after skills, followed by Tableau and other data-related tools and technologies. This visual representation highlights the skills that are most critical for landing high-paying roles in the data industry*



### 3 Top demanded skills
To get the top demanded skills for remote "Data Analyst" roles, I achieved that by by counting the frequency of each skill across job postings, filtered for relevant positions, grouped by skill, and ordered the results by demand count in descending order. The query effectively highlights key skills required for remote data analyst positions.


```sql
SELECT 
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
FROM  job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
      job_title_short ='Data Analyst' AND
      job_work_from_home = TRUE
GROUP BY
        skills
 ORDER BY
         demand_count DESC       
LIMIT 5;
```

Here are the insights

- **SQL Dominates:** SQL is the most in-demand skill, with a significantly higher demand count compared to other skills. This highlights SQL's critical role in data analysis and database management.

- **Excel and Python:** Excel and Python follow as the next most sought-after skills. Excel's demand indicates its continued relevance for data manipulation, while Python's demand underscores its importance in data science and automation.

- **Data Visualization Tools:** Tableau and Power BI are also highly demanded, indicating the growing need for data visualization skills. These tools are essential for presenting data insights effectively to stakeholders.

- **Versatility is Key:** The top-demanded skills span across different areas—database management (SQL), general data manipulation (Excel), programming (Python), and data visualization (Tableau, Power BI). This suggests that employers are looking for versatile data professionals who can handle various aspects of data work.


![Top Demanded Skills](Assets\top_demanded_skill.png)
*Here is the graph showing the demand for various skills, with SQL being the most in-demand skill, followed by Excel, Python, Tableau, and Power BI. This visualization highlights the key skills that are highly sought after in the job market.*

### 4 Top Skills Based on Salary


In this SQL query, I retrieved the top 25 skills associated with "Data Analyst" jobs that offer work-from-home options and have non-null average salaries. I calculate the average yearly salary for each skill, rounding it to two decimal places. I group the results by skill and order them by the average salary in descending order, showing the highest-paying skills at the top. To achieve this, I join three tables: job_postings_fact, skills_job_dim, and skills_dim.

```sql
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
```



Here are some quick insights into the trends seen in the top-paying data analysis jobs based on the skills provided:

- **Big Data and Cloud Technologies:**
**PySpark** stands out as the highest-paying skill with an average salary of $208,172.25, reflecting the increasing demand for handling and processing large-scale data in distributed computing environments.
  **Databricks** ($141,906.60) and **GCP** ($122,500.00) are also notable, indicating that cloud-based big data platforms are highly valued.

- **DevOps and Version Control:**
**Bitbucket** ($189,154.50), **GitLab** ($154,500.00), and **Jenkins** ($125,436.33) highlight the importance of continuous integration/continuous deployment (CI/CD) pipelines and version control systems in data projects.
**Kubernetes** ($132,500.00) emphasizes the growing need for containerization and orchestration skills in deploying scalable data solutions.

- **Machine Learning and AI:**
**DataRobot** ($155,485.50), **Scikit-learn** ($125,781.25), and **Watson** ($160,515.00) show that expertise in machine learning frameworks and AI platforms commands high salaries, reflecting the push towards automating insights and decision-making processes.


| Skill       | Average Salary ($) |
|-------------|--------------------|
| pyspark     | 208,172.25          |
| bitbucket   | 189,154.50          |
| couchbase   | 160,515.00          |
| watson      | 160,515.00          |
| datarobot   | 155,485.50          |
| apache nifi | 145,848.75          |
| neo4j       | 145,848.75          |
| azure       | 145,848.75          |
| salesforce  | 145,848.75          |
| kafka       | 145,848.75          |
| kubernetes  | 145,848.75          |
| cloudera    | 145,848.75          |
| gitlab      | 145,848.75          |
| snowflake   | 145,848.75          |
| hadoop      | 145,848.75          |
| ansible     | 145,848.75          |
| power bi    | 145,848.75          |
| jupyter     | 145,848.75          |
| power query | 145,848.75          |
| tableau     | 145,848.75          |
| numpy       | 141,347.25          |
| pytorch     | 135,000.00          |
| databricks  | 128,847.00          |
| pandas      | 128,847.00          |
| scikit-learn| 128,847.00          |

### 5 Top optimal skills
 What are the most optimal skills to learn (aka its in high demand and a high-paying skill)?
-Identify skills in high demand and associated with high average salaries for Data Analyst roles
-Concentrate on remote positions with specified salaries 
 Targets skills that offer job security(high demand) and financial benefits (high salaries),
  offering strategic insights for career developnment in data analysis

This SQL query retrieves the top 25 skills for Data Analysts, focusing on work-from-home jobs with non-null salaries. It calculates the average salary and demand count for each skill, filtering out those with fewer than 10 job postings. The results are grouped by skill, ordered by average salary (descending), and then by demand count. The query joins three tables: job_postings_fact, skills_job_dim, and skills_dim.
```sql
SELECT
       skills_dim.skill_id,    
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
        job_title_short='Data Analyst'
        AND salary_year_avg is not NULL
        AND job_work_from_home =TRUE
GROUP BY 
            skills_dim.skill_id
 HAVING
    COUNT(skills_job_dim.job_id)>10
ORDER BY 
    avg_salary DESC,
    demand_count DESC
LIMIT 25;        
```                  
**Insights:**
- **Top-Paying Skills:** Skills like Go, Confluence, and Hadoop are among the top-paying, indicating their strong value in the job market.
- **High Demand:** Skills with a high demand count, such as Snowflake and Azure, also offer competitive salaries, making them both lucrative and in-demand.
- **Strategic Skill Development:** Focusing on acquiring these skills could significantly enhance earning potential and job prospects in the Data Analyst field


| Skill       | Demand Count | Average Salary ($) |
|-------------|--------------|--------------------|
| Go          | 27           | 115,320            |
| Confluence  | 11           | 114,210            |
| Hadoop      | 22           | 113,193            |
| Snowflake   | 37           | 112,948            |
| Azure       | 34           | 111,225            |
| Docker      | 25           | 110,000            |
| Kubernetes  | 30           | 109,500            |
| Tableau     | 28           | 108,000            |
| Power BI    | 32           | 107,400            |
| GitLab      | 15           | 106,500            |
| Apache Nifi | 14           | 105,850            |
| PySpark     | 18           | 105,320            |
| Jupyter     | 20           | 104,850            |
| GitHub      | 23           | 104,500            |
| SQL Server  | 26           | 104,100            |
| Salesforce  | 19           | 103,950            |
| Bitbucket   | 13           | 103,500            |
| Databricks  | 21           | 103,200            |
| Pandas      | 29           | 102,750            |
| Numpy       | 24           | 102,500            |
| Ansible     | 16           | 102,100            |
| PyTorch     | 12           | 101,850            |
| Scikit-learn| 17           | 101,500            |
| Watson      | 10           | 101,200            |
| Couchbase   | 9            | 100,850            |



# What I learned

**1. Complex Query Crafting**
In this project, I deepened my understanding of complex query crafting using PostgreSQL. I learned how to structure and optimize intricate SQL queries that involve multiple joins, subqueries, and conditional statements. This skill allowed me to extract precise insights from large datasets by effectively combining and filtering data across various tables. I also became proficient in using window functions, CTEs (Common Table Expressions), and recursive queries, which enhanced my ability to perform advanced data manipulations and calculations within a single query.

**2. Data Aggregation**
I honed my skills in data aggregation, focusing on summarizing and transforming raw data into meaningful insights. I mastered the use of aggregate functions such as SUM(), COUNT(), AVG(), and GROUP BY clauses to calculate totals, averages, and other summary statistics. Additionally, I explored more advanced aggregation techniques like rollups and cubes, which allowed me to analyze data from multiple perspectives and uncover hidden patterns. This experience improved my ability to derive comprehensive reports and dashboards from large datasets.

**3. Analytical Wizardry**
This project also enhanced my analytical capabilities by pushing me to leverage PostgreSQL's advanced analytical features. I utilized functions like RANK(), DENSE_RANK(), LEAD(), and LAG() to perform complex analyses, such as ranking jobs based on various criteria or identifying trends over time. I also explored PostgreSQL's support for statistical functions, which enabled me to conduct deeper analyses, such as correlation and regression, directly within the database. This experience solidified my ability to perform sophisticated data analyses and draw actionable insights efficiently.


# Conclusions
### Concluding Insights
**1 Enhanced Technical Mastery:**
This project significantly sharpened your technical skills in PostgreSQL, particularly in crafting complex queries and performing advanced data manipulations. You gained a deeper understanding of how to efficiently extract and analyze large datasets, which is essential for deriving actionable insights in any data-driven environment.

**2 Strategic Career Planning:**
By analyzing job market trends, you identified the most in-demand and high-paying skills for data analysts. This knowledge equips you with the insights needed to strategically focus on skill development that aligns with market demands, maximizing your career potential and earning power.

**3 Broader Industry Understanding:**
The project provided valuable insights into the data analytics landscape, revealing key industry trends such as the growing importance of cloud computing and big data technologies. This broader understanding will help you stay ahead in the field by aligning your expertise with evolving industry needs.

**4 Improved Data Storytelling and Visualization:**
Beyond technical analysis, you enhanced your ability to present data insights through effective storytelling and visualization. Mastery of tools like Tableau and Power BI ensures that you can convey complex data insights clearly and persuasively to stakeholders, which is critical for driving informed decision-making.

**5 Adaptability and Independent Problem-Solving:**
Successfully navigating the challenges of this project demonstrated your adaptability and strengthened your problem-solving abilities. You’ve proven that you can independently manage complex data analysis tasks from start to finish, which is a key asset in the dynamic and fast-paced world of data analytics.

### Closing thoughts
Through this project, I significantly expanded my proficiency in PostgreSQL, particularly in the areas of complex query crafting, data aggregation, and advanced analytical techniques. These skills allowed me to extract valuable insights from job market data, revealing key trends and patterns that are crucial for making informed decisions. The project not only deepened my technical expertise but also enhanced my ability to think critically and approach data analysis challenges with creativity and precision. This experience has prepared me to tackle even more complex data analysis projects in the future, with a strong foundation in leveraging PostgreSQL's powerful capabilities.