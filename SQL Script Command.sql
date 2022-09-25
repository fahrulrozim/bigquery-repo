-- SELECT * FROM `data-to-insights.ecommerce.rev_transactions` LIMIT 1000

-- Check Duplicate Data
-- SELECT
--   (SELECT COUNT(1) FROM (SELECT DISTINCT * from `data-to-insights.ecommerce.rev_transactions`)) as distinct_rows,
--   (SELECT COUNT(1) FROM `data-to-insights.ecommerce.rev_transactions`) as total_rows;

-- Identify Unique Values
-- SELECT DISTINCT * FROM `data-to-insights.ecommerce.rev_transactions`

-- Copy Table to My Projects (Discarding duplicate rows)
-- CREATE TABLE `psychic-force-362917.test_data_fellowship_7.rev_transactions`
-- AS
-- SELECT DISTINCT * FROM `data-to-insights.ecommerce.rev_transactions`

-- Format data Column data type to datetime
-- CREATE OR REPLACE TABLE `psychic-force-362917.test_data_fellowship_7.date_formatted`
-- AS
-- SELECT *, 
--   PARSE_DATE('%Y%m%d', date) AS date_formatted
-- FROM `psychic-force-362917.test_data_fellowship_7.rev_transactions`;

-- Drop Column date with string data type
-- ALTER TABLE `psychic-force-362917.test_data_fellowship_7.date_formatted`
-- DROP COLUMN date;

-- Total transactions per date and country based on the channel grouping
CREATE OR REPLACE TABLE `psychic-force-362917.test_data_fellowship_7.details`
AS
SELECT 
  totals_transactions,
  ARRAY_AGG(STRUCT(date_formatted, geoNetwork_country) ORDER BY date_formatted ASC) as transaction_details
FROM
  `psychic-force-362917.test_data_fellowship_7.date_formatted`
GROUP BY totals_transactions;