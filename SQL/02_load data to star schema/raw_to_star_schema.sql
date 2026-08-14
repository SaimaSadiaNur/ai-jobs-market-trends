-- FILL DATA IN DIMENSION TABLES

INSERT INTO dim_country (country)
SELECT DISTINCT country FROM job_market_raw;

INSERT INTO dim_job_role (job_role)
SELECT DISTINCT job_role FROM job_market_raw;

INSERT INTO dim_specialization (ai_specialization)
SELECT DISTINCT ai_specialization FROM job_market_raw;


-- FILL IN FACT TABLE AND CREATE CONNECTION WITH DIMENSION TABLES

INSERT INTO job_postings (
    id, country_id, role_id, specialization_id, experience_level, experience_years,
    salary_usd, bonus_usd, education_required, industry, company_size, work_mode,
    year, weekly_hours, company_rating, job_openings, hiring_difficulty_score,
    layoff_risk, ai_adoption_score, company_funding_billion, economic_index,
    ai_maturity_years, offer_acceptance_rate, tax_rate_percent, vacation_days,
    skill_demand_score, automation_risk, job_security_score, career_growth_score,
    work_life_balance_score, promotion_speed, salary_percentile,
    cost_of_living_index, employee_satisfaction
)
SELECT
    r.id, c.country_id, jr.role_id, s.specialization_id, r.experience_level, r.experience_years,
    r.salary_usd, r.bonus_usd, r.education_required, r.industry, r.company_size, r.work_mode,
    r.year, r.weekly_hours, r.company_rating, r.job_openings, r.hiring_difficulty_score,
    r.layoff_risk, r.ai_adoption_score, r.company_funding_billion, r.economic_index,
    r.ai_maturity_years, r.offer_acceptance_rate, r.tax_rate_percent, r.vacation_days,
    r.skill_demand_score, r.automation_risk, r.job_security_score, r.career_growth_score,
    r.work_life_balance_score, r.promotion_speed, r.salary_percentile,
    r.cost_of_living_index, r.employee_satisfaction
FROM job_market_raw r
JOIN dim_country c ON c.country = r.country
JOIN dim_job_role jr ON jr.job_role = r.job_role
JOIN dim_specialization s ON s.ai_specialization = r.ai_specialization;

