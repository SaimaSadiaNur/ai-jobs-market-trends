-- Real (cost-of-living adjusted) salary trend by country

CREATE VIEW vw_real_salary_trend_by_country AS
WITH real_salary_cte AS (
    SELECT
        c.country,
        jp.year::int AS year,
        AVG(jp.salary_usd) AS avg_nominal_salary,
        AVG(jp.salary_usd / NULLIF(jp.cost_of_living_index, 0)) AS avg_real_salary
    FROM job_postings jp
    JOIN dim_country c ON c.country_id = jp.country_id
    GROUP BY c.country, jp.year::int
)
SELECT
    country, year,
    ROUND(avg_nominal_salary, 0) AS avg_nominal_salary,
    ROUND(avg_real_salary, 0) AS avg_real_salary,
    ROUND(LAG(avg_real_salary) OVER (PARTITION BY country ORDER BY year), 0) AS prev_year_real_salary,
    ROUND(
        (avg_real_salary - LAG(avg_real_salary) OVER (PARTITION BY country ORDER BY year))
        / LAG(avg_real_salary) OVER (PARTITION BY country ORDER BY year) * 100, 2
    ) AS real_salary_yoy_change
FROM real_salary_cte
ORDER BY year, country;