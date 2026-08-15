-- Automation risk trend by role 
CREATE VIEW vw_automation_risk_trend_by_role AS
WITH automation_cte AS (
    SELECT
        jr.job_role,
        jp.year::int AS year,
        AVG(jp.automation_risk) AS avg_automation_risk
    FROM job_postings jp
    JOIN dim_job_role jr ON jr.role_id = jp.role_id
    GROUP BY jr.job_role, jp.year::int
)
SELECT
    job_role, year,
    ROUND(avg_automation_risk, 2) AS avg_automation_risk,
    ROUND(LAG(avg_automation_risk) OVER (PARTITION BY job_role ORDER BY year), 2) AS prev_year_automation_risk,
    ROUND(avg_automation_risk - LAG(avg_automation_risk) OVER (PARTITION BY job_role ORDER BY year), 2) AS automation_risk_change
FROM automation_cte
ORDER BY year, job_role;

