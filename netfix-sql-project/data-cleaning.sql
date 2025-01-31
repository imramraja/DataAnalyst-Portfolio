/* 
Netflix Data Cleaning in MySQL
Skills: UPDATE, ALTER TABLE, JOINS, CTE, STR_TO_DATE, String Splitting
*/

-- Clean `director`, `country`, and `cast` columns
UPDATE netflix_titles
SET 
  director = COALESCE(NULLIF(director, ''), 'Unknown'),
  country = COALESCE(NULLIF(country, ''), 'Unknown'),
  cast = COALESCE(NULLIF(cast, ''), 'Unknown');

-- Standardize `date_added` format and split into month/year
ALTER TABLE netflix_titles
ADD COLUMN date_added_month VARCHAR(20),
ADD COLUMN date_added_year INT;

UPDATE netflix_titles
SET 
  date_added_month = SUBSTRING_INDEX(date_added, ' ', 1),
  date_added_year = CAST(SUBSTRING_INDEX(SUBSTRING_INDEX(date_added, ', ', -1), ' ', 1) AS UNSIGNED);

-- Split `duration` into numeric columns
ALTER TABLE netflix_titles
ADD COLUMN duration_min INT,
ADD COLUMN duration_seasons INT;

UPDATE netflix_titles
SET 
  duration_min = CASE 
    WHEN duration LIKE '%min%' THEN REGEXP_SUBSTR(duration, '[0-9]+') 
    ELSE NULL 
  END,
  duration_seasons = CASE 
    WHEN duration LIKE '%Season%' THEN REGEXP_SUBSTR(duration, '[0-9]+') 
    ELSE NULL 
  END;

-- Split `listed_in` into a genres lookup table
CREATE TABLE genres (
    show_id VARCHAR(10),
    genre VARCHAR(100)
);

INSERT INTO genres (show_id, genre)
SELECT 
  show_id, 
  TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(listed_in, ',', n), ',', -1)) AS genre
FROM netflix_titles
JOIN (SELECT 1 AS n UNION SELECT 2 UNION SELECT 3) AS numbers
ON CHAR_LENGTH(listed_in) - CHAR_LENGTH(REPLACE(listed_in, ',', '')) >= n - 1;

-- Remove duplicates using CTE
WITH DuplicatesCTE AS (
  SELECT 
    show_id,
    ROW_NUMBER() OVER (
      PARTITION BY 
        title, 
        type, 
        release_year 
      ORDER BY show_id
    ) AS row_num
  FROM netflix_titles
)
DELETE FROM netflix_titles
WHERE show_id IN (SELECT show_id FROM DuplicatesCTE WHERE row_num > 1);

-- Drop unused columns
ALTER TABLE netflix_titles
DROP COLUMN date_added,
DROP COLUMN duration;
