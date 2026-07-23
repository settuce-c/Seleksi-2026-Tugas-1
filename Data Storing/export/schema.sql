DROP TABLE IF EXISTS anime_producers CASCADE;
DROP TABLE IF EXISTS anime_studios CASCADE;
DROP TABLE IF EXISTS anime_genres CASCADE;
DROP TABLE IF EXISTS producers CASCADE;
DROP TABLE IF EXISTS studios CASCADE;
DROP TABLE IF EXISTS genres CASCADE;
DROP TABLE IF EXISTS anime CASCADE;

CREATE TABLE anime (
    anime_id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    rank INTEGER NOT NULL CHECK (rank > 0),
    score DECIMAL(3,2) CHECK (score >= 0 AND score <= 10),
    members INTEGER CHECK (members >= 0),
    episodes INTEGER CHECK (episodes >= 0),
    status VARCHAR(50),
    aired VARCHAR(255),
    duration_minutes INTEGER CHECK (duration_minutes >= 0),
    rating VARCHAR(100),
    url TEXT UNIQUE NOT NULL
);

CREATE TABLE genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE studios (
    studio_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE producers (
    producer_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL
);

CREATE TABLE anime_genres (
    anime_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    PRIMARY KEY (anime_id, genre_id),
    FOREIGN KEY (anime_id)
        REFERENCES anime(anime_id)
        ON DELETE CASCADE,
    FOREIGN KEY (genre_id)
        REFERENCES genres(genre_id)
        ON DELETE CASCADE
);

CREATE TABLE anime_studios (
    anime_id INTEGER NOT NULL,
    studio_id INTEGER NOT NULL,
    PRIMARY KEY (anime_id, studio_id),
    FOREIGN KEY (anime_id)
        REFERENCES anime(anime_id)
        ON DELETE CASCADE,
    FOREIGN KEY (studio_id)
        REFERENCES studios(studio_id)
        ON DELETE CASCADE
);

CREATE TABLE anime_producers (
    anime_id INTEGER NOT NULL,
    producer_id INTEGER NOT NULL,
    PRIMARY KEY (anime_id, producer_id),
    FOREIGN KEY (anime_id)
        REFERENCES anime(anime_id)
        ON DELETE CASCADE,
    FOREIGN KEY (producer_id)
        REFERENCES producers(producer_id)
        ON DELETE CASCADE
);

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
