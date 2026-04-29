CREATE DATABASE IF NOT EXISTS pandemic;
USE pandemic;
SELECT COUNT(*) AS total_records FROM infectious_cases;
USE pandemic;
SELECT COUNT(*) AS total_records FROM infectious_cases;
USE pandemic;
CREATE TABLE IF NOT EXISTS entities (entity_id INT AUTO_INCREMENT PRIMARY KEY, entity_code VARCHAR(20), entity_name VARCHAR(255) NOT NULL);
INSERT INTO entities (entity_name, entity_code)
SELECT DISTINCT Entity, Code FROM infectious_cases;
CREATE TABLE IF NOT EXISTS infectious_cases_norm AS
SELECT 
    e.entity_id, ic.Year, ic.Number_yaws, ic.polio_cases, ic.cases_guinea_worm,ic.Number_rabies,ic.Number_malaria,
    ic.Number_hiv,ic.Number_tuberculosis,ic.Number_smallpox,ic.Number_cholera_cases
FROM infectious_cases ic
JOIN entities e ON ic.Entity = e.entity_name 
    AND (ic.Code = e.entity_code OR (ic.Code IS NULL AND e.entity_code IS NULL));
SELECT * FROM infectious_cases_norm LIMIT 10;
SELECT Year,
    MAKEDATE(Year, 1) AS start_of_year_date,
    CURDATE() AS today_date,TIMESTAMPDIFF(YEAR, MAKEDATE(Year, 1), CURDATE()) AS diff_in_years
FROM infectious_cases_norm LIMIT 10;
SELECT 
    e.entity_name,
    AVG(ic.polio_cases) AS avg_polio,
    MIN(ic.polio_cases) AS min_polio,
    MAX(ic.polio_cases) AS max_polio,
    SUM(ic.Number_malaria) AS total_malaria
FROM infectious_cases_norm ic
JOIN entities e ON ic.entity_id = e.entity_id
GROUP BY e.entity_name
ORDER BY avg_polio DESC;
