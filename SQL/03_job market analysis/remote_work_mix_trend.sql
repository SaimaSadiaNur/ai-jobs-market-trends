-- Remote work mix trend

CREATE VIEW vw_remote_work_mix_trend AS
SELECT
    jp.year::int AS year,
    jp.work_mode,
    COUNT(*) AS postings,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY jp.year::int), 2) AS pct_of_year
FROM job_postings jp
GROUP BY jp.year::int, jp.work_mode
ORDER BY year, work_mode;