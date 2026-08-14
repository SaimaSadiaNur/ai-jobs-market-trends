-- Specialization demand shift over time

create view specialization_demand_shift as
WITH demand_rank_cte AS (
    SELECT 
        ds.ai_specialization,
        SUM(jp.job_openings) AS total_job_share,
        jp.year::int AS year,
        PERCENT_RANK() OVER (
            PARTITION BY jp.year::int 
            ORDER BY SUM(jp.job_openings) ASC
        ) AS demand_rank
    FROM job_postings jp 
    JOIN dim_specialization ds 
        ON ds.specialization_id = jp.specialization_id
    GROUP BY ds.ai_specialization, jp.year::int
)
SELECT 
    ai_specialization,
    year,
    total_job_share,
    demand_rank,
    LAG(demand_rank) OVER (
        PARTITION BY ai_specialization 
        ORDER BY year
    ) AS prev_year_demand_rank
FROM demand_rank_cte
ORDER BY year, demand_rank asc;





