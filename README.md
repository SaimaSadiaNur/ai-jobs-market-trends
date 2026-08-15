# AI & Data Jobs Market Trends (2020–2026)

A SQL + Power BI analysis of 90,000+ global AI/data job postings, examining how salary, 
job quality, and market demand have shifted across roles, specializations, and countries 
from 2020 to 2026.

## Project Overview
This project answers eight trend-analysis questions using a PostgreSQL star schema and 
window-function-driven SQL views, visualized in a single-page Power BI dashboard.

**Dataset:** [Global AI & Data Jobs Salary Dataset](<kaggle-link>) (Kaggle) — 90,000 rows, 
35 columns, 2020–2026, 12 countries, 8 job roles, 8 AI specializations.

## Questions Answered
- How have salaries trended by role, 2020–2026?
- How has demand shifted across AI specializations over time?
- How has the remote/hybrid/onsite mix changed?
- How does cost-of-living-adjusted (real) salary compare across countries?
- Is job quality (security, work-life balance, satisfaction) improving or declining?
- How is perceived automation risk trending by role?
- Is the entry-vs-senior pay gap widening or narrowing?
- Are companies finding it harder to hire over time?

## Tech Stack
- **PostgreSQL** — star schema (dimension + fact tables), CTEs, window functions 
  (`LAG`, `PERCENT_RANK`) for all trend calculations
- **DBeaver** — SQL development and validation
- **Power BI** — dashboard and DAX measures

## Repo Structure
- `sql/01_schema/` — table definitions (dimension + fact tables)
- `sql/02_load/` — raw-to-star-schema load script
- `sql/03_analysis_views/` — one SQL view per analysis question
- `powerbi/` — the Power BI dashboard file
- `docs/screenshots/` — dashboard preview images

## Dashboard Preview
<img width="716" height="377" alt="dashboard_overview" src="https://github.com/user-attachments/assets/36d3ed6d-4ccc-4a2c-909d-ef7c53489b2c" />

## Key Findings

- **Salary growth has been steady but modest** — most roles cluster in the $90K–$110K 
  range with limited swings over 2020–2026, while one role sits persistently lower 
  (~$65K–$70K), suggesting a real, structural pay gap between roles rather than a 
  temporary dip.
- **The highest year-over-year salary growth for a single role was 1.54%**, per the 
  dashboard's Top Growth Role KPI — a modest but positive signal given the broader 
  salary lines look relatively flat.
- **Job quality scores (security, growth, work-life balance, satisfaction) are 
  remarkably stable across roles and years**, all clustering in the low-70s out of 100 
  — suggesting that despite salary and demand shifts, the *day-to-day experience* of 
  AI/data roles hasn't meaningfully changed.
- **Automation risk shows no consistent upward or downward trend** — scores oscillate 
  year to year across all roles rather than climbing steadily, which runs counter to 
  the "AI will replace AI jobs" narrative and is worth calling out as a finding in 
  itself.
- **Entry-level salaries remain consistently well below senior-level pay** across every 
  year in the dataset, with no visible narrowing of the gap over time.
- **Remote/hybrid/onsite work distribution has stayed roughly balanced** across the 
  whole period, without a clear shift toward or away from remote work.
