-- Hiring difficulty vs. offer acceptance trend

CREATE VIEW vw_hiring_difficulty_trend AS
WITH hiring_cte AS (
    SELECT
        jr.job_role,
        jp.year::int AS year,
        AVG(jp.hiring_difficulty_score) AS avg_hiring_difficulty,
        AVG(jp.offer_acceptance_rate) AS avg_offer_acceptance
    FROM job_postings jp
    JOIN dim_job_role jr ON jr.role_id = jp.role_id
    GROUP BY jr.job_role, jp.year::int
)
SELECT
    job_role, year,
    ROUND(avg_hiring_difficulty, 2) AS avg_hiring_difficulty,
    ROUND(avg_offer_acceptance, 2) AS avg_offer_acceptance,
    ROUND(LAG(avg_hiring_difficulty) OVER (PARTITION BY job_role ORDER BY year), 2) AS prev_hiring_difficulty,
    ROUND(LAG(avg_offer_acceptance) OVER (PARTITION BY job_role ORDER BY year), 2) AS prev_offer_acceptance
FROM hiring_cte
ORDER BY year, job_role;
