CREATE INDEX idx_anime_genres_anime
ON anime_genres(anime_id);

CREATE INDEX idx_anime_genres_genre
ON anime_genres(genre_id);

CREATE INDEX idx_anime_studios_anime
ON anime_studios(anime_id);

CREATE INDEX idx_anime_studios_studio
ON anime_studios(studio_id);

CREATE INDEX idx_anime_producers_anime
ON anime_producers(anime_id);

CREATE INDEX idx_anime_producers_producer
ON anime_producers(producer_id);


-- QUERY OPTIMIZATION 1
-- Menampilkan anime dengan genre Action.

-- BEFORE
EXPLAIN ANALYZE
SELECT a.title, g.name
FROM anime a
JOIN anime_genres ag
    ON a.anime_id = ag.anime_id
JOIN genres g
    ON ag.genre_id = g.genre_id
WHERE g.name = 'Action';

-- AFTER
EXPLAIN ANALYZE
SELECT a.title, g.name
FROM genres g
JOIN anime_genres ag
    ON g.genre_id = ag.genre_id
JOIN anime a
    ON ag.anime_id = a.anime_id
WHERE g.name = 'Action';



-- QUERY OPTIMIZATION 2
-- Menampilkan anime beserta studionya.

-- BEFORE
EXPLAIN ANALYZE
SELECT a.title, s.name
FROM anime a
JOIN anime_studios ast
    ON a.anime_id = ast.anime_id
JOIN studios s
    ON ast.studio_id = s.studio_id;

-- AFTER
EXPLAIN ANALYZE
SELECT
    a.title,
    s.name
FROM studios s
JOIN anime_studios ast
    ON s.studio_id = ast.studio_id
JOIN anime a
    ON ast.anime_id = a.anime_id;



-- QUERY OPTIMIZATION 3
-- Menghitung jumlah anime pada setiap genre.

-- BEFORE
EXPLAIN ANALYZE
SELECT
    g.name,
    COUNT(*)
FROM genres g
JOIN anime_genres ag
    ON g.genre_id = ag.genre_id
GROUP BY g.name
ORDER BY COUNT(*) DESC;

-- AFTER
EXPLAIN ANALYZE
SELECT
    g.name,
    COUNT(ag.anime_id)
FROM genres g
LEFT JOIN anime_genres ag
    ON g.genre_id = ag.genre_id
GROUP BY g.genre_id, g.name
ORDER BY COUNT(ag.anime_id) DESC;
