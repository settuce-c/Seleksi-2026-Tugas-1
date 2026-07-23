import json
import psycopg2


# ==========================
# PostgreSQL Configuration
# ==========================
DB_CONFIG = {
    "host": "localhost",
    "database": "myanimelist_db",
    "user": "postgres",
    "password": "praktikum",
    "port": 5432
}


# ==========================
# Helper
# ==========================
def load_json(path):
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)


def insert_data(cursor, query, data):
    cursor.executemany(query, data)


# ==========================
# Main
# ==========================
def main():
    conn = None

    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cursor = conn.cursor()

        print("Connected to PostgreSQL\n")

        # ==========================
        # Load JSON
        # ==========================
        anime = load_json("data/anime.json")
        genres = load_json("data/genres.json")
        studios = load_json("data/studios.json")
        producers = load_json("data/producers.json")

        anime_genres = load_json("data/anime_genres.json")
        anime_studios = load_json("data/anime_studios.json")
        anime_producers = load_json("data/anime_producers.json")

        # ==========================
        # Genres
        # ==========================
        print("Importing genres...")

        insert_data(
            cursor,
            """
            INSERT INTO genres (genre_id, name)
            VALUES (%s, %s)
            """,
            [
                (
                    g["genre_id"],
                    g["name"]
                )
                for g in genres
            ]
        )

        print(f"✓ {len(genres)} genres imported")

        # ==========================
        # Studios
        # ==========================
        print("Importing studios...")

        insert_data(
            cursor,
            """
            INSERT INTO studios (studio_id, name)
            VALUES (%s, %s)
            """,
            [
                (
                    s["studio_id"],
                    s["name"]
                )
                for s in studios
            ]
        )

        print(f"✓ {len(studios)} studios imported")

        # ==========================
        # Producers
        # ==========================
        print("Importing producers...")

        insert_data(
            cursor,
            """
            INSERT INTO producers (producer_id, name)
            VALUES (%s, %s)
            """,
            [
                (
                    p["producer_id"],
                    p["name"]
                )
                for p in producers
            ]
        )

        print(f"✓ {len(producers)} producers imported")

        # ==========================
        # Anime
        # ==========================
        print("Importing anime...")

        insert_data(
            cursor,
            """
            INSERT INTO anime
            (
                anime_id,
                title,
                rank,
                score,
                members,
                episodes,
                status,
                aired,
                duration_minutes,
                rating,
                url
            )
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """,
            [
                (
                    a["anime_id"],
                    a["title"],
                    a["rank"],
                    a["score"],
                    a["members"],
                    a["episodes"],
                    a["status"],
                    a["aired"],
                    a["duration_minutes"],
                    a["rating"],
                    a["url"]
                )
                for a in anime
            ]
        )

        print(f"✓ {len(anime)} anime imported")

        # ==========================
        # Anime Genres
        # ==========================
        print("Importing anime_genres...")

        insert_data(
            cursor,
            """
            INSERT INTO anime_genres
            (anime_id, genre_id)
            VALUES (%s, %s)
            """,
            [
                (
                    ag["anime_id"],
                    ag["genre_id"]
                )
                for ag in anime_genres
            ]
        )

        print(f"✓ {len(anime_genres)} relations imported")

        # ==========================
        # Anime Studios
        # ==========================
        print("Importing anime_studios...")

        insert_data(
            cursor,
            """
            INSERT INTO anime_studios
            (anime_id, studio_id)
            VALUES (%s, %s)
            """,
            [
                (
                    ast["anime_id"],
                    ast["studio_id"]
                )
                for ast in anime_studios
            ]
        )

        print(f"✓ {len(anime_studios)} relations imported")

        # ==========================
        # Anime Producers
        # ==========================
        print("Importing anime_producers...")

        insert_data(
            cursor,
            """
            INSERT INTO anime_producers
            (anime_id, producer_id)
            VALUES (%s, %s)
            """,
            [
                (
                    ap["anime_id"],
                    ap["producer_id"]
                )
                for ap in anime_producers
            ]
        )

        print(f"✓ {len(anime_producers)} relations imported")

        # ==========================
        # Commit
        # ==========================
        conn.commit()

        print("\n================================")
        print("All data imported successfully!")
        print("================================")

    except Exception as e:
        if conn:
            conn.rollback()

        print("\nERROR:")
        print(e)

    finally:
        if conn:
            cursor.close()
            conn.close()
            print("Connection closed.")


if __name__ == "__main__":
    main()