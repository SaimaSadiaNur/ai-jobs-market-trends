-- Job quality trend (composite)

CREATE VIEW vw_job_quality_trend AS
WITH quality_cte AS (
    SELECT
        jr.job_role,
        jp.year::int AS year,
        AVG((jp.job_security_score + jp.work_life_balance_score + jp.employee_satisfaction) / 3.0) AS avg_quality_score
    FROM job_postings jp
    JOIN dim_job_role jr ON jr.role_id = jp.role_id
    GROUP BY jr.job_role, jp.year::int
)
SELECT
    job_role, year,
    ROUND(avg_quality_score, 2) AS avg_quality_score,
    ROUND(LAG(avg_quality_score) OVER (PARTITION BY job_role ORDER BY year), 2) AS prev_year_quality_score,
    ROUND(
        (avg_quality_score - LAG(avg_quality_score) OVER (PARTITION BY job_role ORDER BY year))
        / LAG(avg_quality_score) OVER (PARTITION BY job_role ORDER BY year) * 100, 2
    ) AS quality_trend_yoy_change
FROM quality_cte
ORDER BY year, job_role;