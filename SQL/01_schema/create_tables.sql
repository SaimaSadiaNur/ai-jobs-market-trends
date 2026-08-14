create database job_market_analytics;

-- CREATE DIMENSION TABLES

CREATE TABLE dim_country (
    country_id SERIAL PRIMARY KEY,
    country TEXT UNIQUE
);

CREATE TABLE dim_job_role (
    role_id SERIAL PRIMARY KEY,
    job_role TEXT UNIQUE
);

CREATE TABLE dim_specialization (
    specialization_id SERIAL PRIMARY KEY,
    ai_specialization TEXT UNIQUE
);

-- CREATE FACT TABLE

CREATE TABLE job_postings (
    id INT PRIMARY KEY,
    country_id INT REFERENCES dim_country(country_id),
    role_id INT REFERENCES dim_job_role(role_id),
    specialization_id INT REFERENCES dim_specialization(specialization_id),
    experience_level TEXT,
    experience_years INT,
    salary_usd NUMERIC,
    bonus_usd NUMERIC,
    education_required TEXT,
    industry TEXT,
    company_size TEXT,
    work_mode TEXT,
    year INT,
    weekly_hours NUMERIC,
    company_rating NUMERIC,
    job_openings INT,
    hiring_difficulty_score NUMERIC,
    layoff_risk NUMERIC,
    ai_adoption_score INT,
    company_funding_billion NUMERIC,
    economic_index NUMERIC,
    ai_maturity_years INT,
    offer_acceptance_rate NUMERIC,
    tax_rate_percent NUMERIC,
    vacation_days INT,
    skill_demand_score INT,
    automation_risk INT,
    job_security_score INT,
    career_growth_score INT,
    work_life_balance_score INT,
    promotion_speed INT,
    salary_percentile INT,
    cost_of_living_index NUMERIC,
    employee_satisfaction INT
);