-- Dataset: https://www.kaggle.com/datasets/shivamb/netflix-shows

-- 1. Content Type Distribution (Movies vs. TV Shows)
SELECT 
    type,
    COUNT(*) AS count,
    ROUND(COUNT(*)/(SELECT COUNT(*) FROM netflix_titles)*100, 2) AS pct
FROM netflix_titles
GROUP BY type;

-- 2. Top 10 Content-Producing Countries
SELECT 
    country,
    COUNT(*) AS total_content
FROM netflix_titles
WHERE country != 'Unknown'
GROUP BY country
ORDER BY total_content DESC
LIMIT 10;

-- 3. Year-over-Year Content Growth Rate
WITH yearly_content AS (
    SELECT 
        release_year,
        COUNT(*) AS total,
        LAG(COUNT(*), 1) OVER (ORDER BY release_year) AS prev_year
    FROM netflix_titles
    GROUP BY release_year
)
SELECT 
    release_year,
    total,
    ROUND((total - prev_year)/prev_year*100, 2) AS growth_pct
FROM yearly_content;

-- 4. Directors with Cross-Genre Work (Top 10)
SELECT 
    director,
    COUNT(DISTINCT genre) AS unique_genres
FROM netflix_titles nt
JOIN genres g ON nt.show_id = g.show_id
WHERE director != 'Unknown'
GROUP BY director
ORDER BY unique_genres DESC
LIMIT 10;

-- 5. Longest Active Director Careers
SELECT 
    director,
    MAX(release_year) - MIN(release_year) AS career_span
FROM netflix_titles
WHERE director != 'Unknown'
GROUP BY director
HAVING career_span > 0
ORDER BY career_span DESC
LIMIT 5;

-- 6. Month with Highest Content Additions
SELECT 
    date_added_month,
    COUNT(*) AS total_added
FROM netflix_titles
GROUP BY date_added_month
ORDER BY total_added DESC
LIMIT 1;

-- 7. Rating Distribution by Country
SELECT 
    country,
    rating,
    COUNT(*) AS total,
    ROUND(COUNT(*)/SUM(COUNT(*)) OVER (PARTITION BY country)*100, 2) AS pct
FROM netflix_titles
WHERE country != 'Unknown'
GROUP BY country, rating;

-- 8. Average Duration by Content Type
SELECT 
    type,
    CASE 
        WHEN type = 'Movie' THEN ROUND(AVG(duration_min), 0)
        ELSE ROUND(AVG(duration_seasons), 1)
    END AS avg_duration
FROM netflix_titles
GROUP BY type;

-- 9. Genre Popularity Over Time (Last 5 Years)
SELECT 
    genre,
    release_year,
    COUNT(*) AS total_titles
FROM genres g
JOIN netflix_titles nt ON g.show_id = nt.show_id
WHERE release_year >= YEAR(CURDATE()) - 5
GROUP BY genre, release_year
ORDER BY release_year DESC, total_titles DESC;

-- 10. Country Collaborations (Co-Productions)
SELECT 
    TRIM(SUBSTRING_INDEX(country, ',', 1)) AS country1,
    TRIM(SUBSTRING_INDEX(country, ',', -1)) AS country2,
    COUNT(*) AS collaborations
FROM netflix_titles
WHERE country LIKE '%,%'
GROUP BY country1, country2
ORDER BY collaborations DESC
LIMIT 10;

-- 11. Release Year vs. Netflix Addition Lag
SELECT 
    title,
    release_year,
    date_added_year,
    date_added_year - release_year AS years_diff
FROM netflix_titles
WHERE date_added_year IS NOT NULL
ORDER BY years_diff DESC;

-- 12. Genre Trends by Decade
SELECT 
    genre,
    FLOOR(release_year/10)*10 AS decade,
    COUNT(*) AS total_titles
FROM genres g
JOIN netflix_titles nt ON g.show_id = nt.show_id
GROUP BY genre, decade
ORDER BY decade DESC, total_titles DESC;

-- 13. Content Density per Country (% of Total)
SELECT 
    country,
    COUNT(*) AS total,
    ROUND(COUNT(*)/(SELECT COUNT(*) FROM netflix_titles)*100, 2) AS pct
FROM netflix_titles
GROUP BY country
ORDER BY total DESC;

-- 14. Duration vs. Rating Correlation (Movies Only)
SELECT 
    rating,
    ROUND(AVG(duration_min), 0) AS avg_duration
FROM netflix_titles
WHERE type = 'Movie'
GROUP BY rating
ORDER BY avg_duration DESC;

-- 15. Most Frequent Actors (Requires Cast Normalization)
SELECT 
    actor,
    COUNT(*) AS appearances
FROM cast_members
WHERE actor != 'Unknown'
GROUP BY actor
ORDER BY appearances DESC
LIMIT 10;
