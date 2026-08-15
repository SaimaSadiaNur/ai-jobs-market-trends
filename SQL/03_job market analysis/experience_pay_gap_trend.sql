-- Experience-level pay gap trend

CREATE VIEW vw_experience_pay_gap_trend AS
WITH exp_salary_cte AS (
    SELECT experience_level, year::int AS year, AVG(salary_usd) AS avg_salary
    FROM job_postings
    GROUP BY experience_level, year::int
)
SELECT
    year,
    MAX(CASE WHEN experience_level = 'Entry' THEN avg_salary END) AS entry_salary,
    MAX(CASE WHEN experience_level = 'Senior' THEN avg_salary END) AS senior_salary,
    ROUND(
        MAX(CASE WHEN experience_level = 'Senior' THEN avg_salary END)
        - MAX(CASE WHEN experience_level = 'Entry' THEN avg_salary END), 0
    ) AS pay_gap_absolute,
    ROUND(
        (MAX(CASE WHEN experience_level = 'Senior' THEN avg_salary END)
         - MAX(CASE WHEN experience_level = 'Entry' THEN avg_salary END))
        / MAX(CASE WHEN experience_level = 'Entry' THEN avg_salary END) * 100, 2
    ) AS pay_gap_pct
FROM exp_salary_cte
GROUP BY year
ORDER BY year;