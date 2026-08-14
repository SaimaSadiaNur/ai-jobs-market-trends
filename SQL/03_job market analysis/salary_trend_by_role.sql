-- Salary trend by role/specialization, 2020→2026

create view salary_trend_by_role as 
  WITH salary_by_role_year AS (
    SELECT
        jr.job_role,
        jp.year::int AS year,
        AVG(jp.salary_usd) AS avg_salary
    FROM job_postings jp
    JOIN dim_job_role jr ON jp.role_id = jr.role_id
    GROUP BY jr.job_role, jp.year::int
)
SELECT
    job_role,
    year,
    ROUND(avg_salary, 0) AS avg_salary,
    ROUND(LAG(avg_salary) OVER (
        PARTITION BY job_role
        ORDER BY year
    ), 2) AS prev_year_salary,
    ROUND(
        (avg_salary - LAG(avg_salary) OVER (PARTITION BY job_role ORDER BY year))
        / LAG(avg_salary) OVER (PARTITION BY job_role ORDER BY year) * 100,
        2
    ) AS salary_trend_yoy_change
FROM salary_by_role_year
ORDER BY year, job_role;