"""
MyAnimeList Top Airing Anime Scraper
====================================

This script scrapes currently airing anime data from MyAnimeList
and stores the processed data into separate JSON files.

Data source:
    https://myanimelist.net/topanime.php?type=airing

Main entities:
    - Anime
    - Genre
    - Studio
    - Producer

Relationship entities:
    - Anime-Genre
    - Anime-Studio
    - Anime-Producer

The scraper does NOT use the MyAnimeList API.
It retrieves data directly from publicly accessible web pages
using HTTP GET requests.

Author:
    [YOUR NAME]
    [YOUR NIM]

Requirements:
    pip install requests beautifulsoup4

Usage:
    python scraper.py
"""

import json
import re
import time
from pathlib import Path
from typing import Any, Optional

import requests
from bs4 import BeautifulSoup


# ============================================================
# CONFIGURATION
# ============================================================

BASE_URL = "https://myanimelist.net"
TOP_ANIME_URL = f"{BASE_URL}/topanime.php?type=airing"

# Number of anime to scrape.
# Adjust this value according to the scope of your project.
MAX_ANIME = 50

# Delay between requests to avoid sending requests too frequently.
REQUEST_DELAY = 1.5

# Maximum number of retries when a request fails.
MAX_RETRIES = 3

# Request timeout in seconds.
REQUEST_TIMEOUT = 15

# Output directory.
OUTPUT_DIR = Path(__file__).resolve().parent.parent / "data"


# ============================================================
# HTTP SESSION
# ============================================================

session = requests.Session()

session.headers.update(
    {
        "User-Agent": (
            "Mozilla/5.0 (X11; Linux x86_64) "
            "Basis Data/Admin Basis Data/"
            "basisdata@std.stei.itb.ac.id"
        ),
        "Accept-Language": "en-US,en;q=0.9",
    }
)


# ============================================================
# HELPER FUNCTIONS
# ============================================================

def clean_text(value: Optional[str]) -> Optional[str]:
    """
    Clean unnecessary whitespace from scraped text.

    Args:
        value: Raw text extracted from HTML.

    Returns:
        Cleaned text or None if the input is empty.
    """
    if not value:
        return None

    cleaned = re.sub(r"\s+", " ", value).strip()

    return cleaned if cleaned else None


def parse_integer(value: Optional[str]) -> Optional[int]:
    """
    Convert a string containing numeric characters into an integer.

    Examples:
        '1,234,567' -> 1234567
        '24'        -> 24
        'Unknown'   -> None

    Args:
        value: Raw numeric string.

    Returns:
        Integer value or None if parsing fails.
    """
    if not value:
        return None

    numbers = re.sub(r"[^\d]", "", value)

    if not numbers:
        return None

    return int(numbers)


def parse_float(value: Optional[str]) -> Optional[float]:
    """
    Convert a string into a floating-point number.

    Examples:
        '8.95' -> 8.95
        'N/A'  -> None

    Args:
        value: Raw numeric string.

    Returns:
        Float value or None if parsing fails.
    """
    if not value:
        return None

    match = re.search(r"\d+(?:\.\d+)?", value)

    if not match:
        return None

    return float(match.group())


def parse_episodes(value: Optional[str]) -> Optional[int]:
    """
    Parse the number of episodes from a string.

    Args:
        value: Raw episode information.

    Returns:
        Number of episodes or None.
    """
    if not value:
        return None

    if value.lower() in {"unknown", "n/a", "none"}:
        return None

    return parse_integer(value)


def parse_duration(value: Optional[str]) -> Optional[int]:
    """
    Convert anime duration into minutes.

    Examples:
        '24 min per ep' -> 24
        '1 hr 30 min'   -> 90
        'Unknown'       -> None

    Args:
        value: Raw duration string.

    Returns:
        Duration in minutes or None.
    """
    if not value:
        return None

    value = value.lower()

    hours = re.search(r"(\d+)\s*hr", value)
    minutes = re.search(r"(\d+)\s*min", value)

    total_minutes = 0

    if hours:
        total_minutes += int(hours.group(1)) * 60

    if minutes:
        total_minutes += int(minutes.group(1))

    return total_minutes if total_minutes > 0 else None


def get_page(url: str) -> Optional[BeautifulSoup]:
    """
    Send an HTTP GET request and parse the HTML response.

    The function retries the request if a temporary error occurs.

    Args:
        url: Target URL.

    Returns:
        BeautifulSoup object if successful, otherwise None.
    """
    for attempt in range(1, MAX_RETRIES + 1):
        try:
            response = session.get(
                url,
                timeout=REQUEST_TIMEOUT,
            )

            response.raise_for_status()

            return BeautifulSoup(response.text, "html.parser")

        except requests.RequestException as error:
            print(
                f"[WARNING] Request failed "
                f"(attempt {attempt}/{MAX_RETRIES}): {error}"
            )

            if attempt < MAX_RETRIES:
                time.sleep(REQUEST_DELAY)

    print(f"[ERROR] Failed to retrieve: {url}")

    return None


def save_json(filename: str, data: list[dict[str, Any]]) -> None:
    """
    Save scraped data into a JSON file.

    Args:
        filename: Output filename.
        data: Data to be stored.
    """
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    output_path = OUTPUT_DIR / filename

    with output_path.open(
        "w",
        encoding="utf-8",
    ) as file:
        json.dump(
            data,
            file,
            ensure_ascii=False,
            indent=4,
        )

    print(f"[INFO] Saved {len(data)} records to {output_path}")


# ============================================================
# EXTRACT TOP AIRING ANIME
# ============================================================

def scrape_anime_list() -> list[dict[str, Any]]:
    """
    Scrape the Top Airing Anime ranking page.

    Returns:
        List containing basic anime information and URLs.
    """
    soup = get_page(TOP_ANIME_URL)

    if soup is None:
        return []

    anime_list = []

    ranking_rows = soup.select("tr.ranking-list")

    print(f"[INFO] Found {len(ranking_rows)} anime entries.")

    for row in ranking_rows[:MAX_ANIME]:
        rank_element = row.select_one(".rank .lightLink")

        title_element = row.select_one(
            ".anime_ranking_h3 a"
        )

        score_element = row.select_one(
            ".score-label"
        )

        if not title_element:
            continue

        title = clean_text(
            title_element.get_text()
        )

        anime_url = title_element.get("href")

        rank = parse_integer(
            rank_element.get_text()
            if rank_element
            else None
        )

        score = parse_float(
            score_element.get_text()
            if score_element
            else None
        )

        anime_list.append(
            {
                "anime_id": None,
                "title": title,
                "rank": rank,
                "score": score,
                "url": anime_url,
            }
        )

    return anime_list


# ============================================================
# EXTRACT ANIME DETAIL
# ============================================================

def extract_info_box(
    soup: BeautifulSoup,
    label: str,
) -> Optional[str]:
    """
    Extract information from MyAnimeList's detail information box.

    Args:
        soup: Parsed anime detail page.
        label: Information label to search for.

    Returns:
        Extracted text or None.
    """
    for div in soup.select(
        ".leftside .spaceit_pad"
    ):
        text = clean_text(
            div.get_text(" ", strip=True)
        )

        if text and text.startswith(label):
            value = text.replace(
                label,
                "",
                1,
            ).strip()

            return clean_text(value)

    return None


def extract_list_info(
    soup: BeautifulSoup,
    label: str,
) -> list[str]:
    """
    Extract multiple values from an information field.

    Used for fields such as Genres, Studios, and Producers.

    Args:
        soup: Parsed anime detail page.
        label: Information label.

    Returns:
        List of extracted values.
    """
    for div in soup.select(
        ".leftside .spaceit_pad"
    ):
        text = clean_text(
            div.get_text(" ", strip=True)
        )

        if text and text.startswith(label):
            links = div.select("a")

            return [
                clean_text(link.get_text())
                for link in links
                if clean_text(link.get_text())
            ]

    return []


def scrape_anime_detail(
    anime: dict[str, Any],
) -> Optional[dict[str, Any]]:
    """
    Scrape detailed information from an anime detail page.

    Args:
        anime: Basic anime information.

    Returns:
        Dictionary containing processed anime data.
    """
    url = anime.get("url")

    if not url:
        return None

    print(
        f"[INFO] Scraping detail: "
        f"{anime.get('title')}"
    )

    soup = get_page(url)

    if soup is None:
        return None

    # Extract MAL anime ID from URL.
    match = re.search(
        r"/anime/(\d+)",
        url,
    )

    anime_id = (
        int(match.group(1))
        if match
        else None
    )

    # Extract basic information.
    episodes_raw = extract_info_box(
        soup,
        "Episodes:"
    )

    duration_raw = extract_info_box(
        soup,
        "Duration:"
    )

    aired_raw = extract_info_box(
        soup,
        "Aired:"
    )

    rating = extract_info_box(
        soup,
        "Rating:"
    )

    members_raw = extract_info_box(
        soup,
        "Members:"
    )

    status = extract_info_box(
        soup,
        "Status:"
    )

    genres = extract_list_info(
        soup,
        "Genres:"
    )

    studios = extract_list_info(
        soup,
        "Studios:"
    )

    producers = extract_list_info(
        soup,
        "Producers:"
    )

    return {
        "anime_id": anime_id,
        "title": anime.get("title"),
        "rank": anime.get("rank"),
        "score": anime.get("score"),
        "members": parse_integer(
            members_raw
        ),
        "episodes": parse_episodes(
            episodes_raw
        ),
        "status": clean_text(
            status
        ),
        "aired": clean_text(
            aired_raw
        ),
        "duration_minutes": parse_duration(
            duration_raw
        ),
        "rating": clean_text(
            rating
        ),
        "url": url,
        "genres": genres,
        "studios": studios,
        "producers": producers,
    }


# ============================================================
# NORMALIZATION
# ============================================================

def normalize_data(
    anime_details: list[dict[str, Any]],
) -> dict[str, list[dict[str, Any]]]:
    """
    Normalize scraped data into separate entities.

    This preprocessing step separates anime, genre, studio,
    and producer entities and creates relationship tables.

    Args:
        anime_details: List of scraped anime records.

    Returns:
        Dictionary containing normalized entity data.
    """
    anime_data = []
    genres = []
    studios = []
    producers = []

    anime_genres = []
    anime_studios = []
    anime_producers = []

    genre_map = {}
    studio_map = {}
    producer_map = {}

    for anime in anime_details:
        anime_id = anime["anime_id"]

        if anime_id is None:
            continue

        # --------------------------------------------
        # Anime entity
        # --------------------------------------------

        anime_data.append(
            {
                "anime_id": anime_id,
                "title": anime["title"],
                "rank": anime["rank"],
                "score": anime["score"],
                "members": anime["members"],
                "episodes": anime["episodes"],
                "status": anime["status"],
                "aired": anime["aired"],
                "duration_minutes": anime[
                    "duration_minutes"
                ],
                "rating": anime["rating"],
                "url": anime["url"],
            }
        )

        # --------------------------------------------
        # Genre entity and relationship
        # --------------------------------------------

        for genre_name in anime["genres"]:
            if genre_name not in genre_map:
                genre_id = len(genre_map) + 1

                genre_map[genre_name] = genre_id

                genres.append(
                    {
                        "genre_id": genre_id,
                        "name": genre_name,
                    }
                )

            anime_genres.append(
                {
                    "anime_id": anime_id,
                    "genre_id": genre_map[
                        genre_name
                    ],
                }
            )

        # --------------------------------------------
        # Studio entity and relationship
        # --------------------------------------------

        for studio_name in anime["studios"]:
            if studio_name not in studio_map:
                studio_id = len(studio_map) + 1

                studio_map[studio_name] = studio_id

                studios.append(
                    {
                        "studio_id": studio_id,
                        "name": studio_name,
                    }
                )

            anime_studios.append(
                {
                    "anime_id": anime_id,
                    "studio_id": studio_map[
                        studio_name
                    ],
                }
            )

        # --------------------------------------------
        # Producer entity and relationship
        # --------------------------------------------

        for producer_name in anime["producers"]:
            if producer_name not in producer_map:
                producer_id = len(producer_map) + 1

                producer_map[producer_name] = producer_id

                producers.append(
                    {
                        "producer_id": producer_id,
                        "name": producer_name,
                    }
                )

            anime_producers.append(
                {
                    "anime_id": anime_id,
                    "producer_id": producer_map[
                        producer_name
                    ],
                }
            )

    return {
        "anime": anime_data,
        "genres": genres,
        "studios": studios,
        "producers": producers,
        "anime_genres": anime_genres,
        "anime_studios": anime_studios,
        "anime_producers": anime_producers,
    }


# ============================================================
# MAIN PROGRAM
# ============================================================

def main() -> None:
    """
    Run the complete scraping and preprocessing pipeline.
    """

    print("=" * 60)
    print("MyAnimeList Top Airing Anime Scraper")
    print("=" * 60)

    # Step 1: Scrape anime ranking page.
    anime_list = scrape_anime_list()

    if not anime_list:
        print(
            "[ERROR] No anime data was found."
        )
        return

    print(
        f"[INFO] Starting detail scraping "
        f"for {len(anime_list)} anime."
    )

    # Step 2: Scrape each anime detail page.
    anime_details = []

    for index, anime in enumerate(
        anime_list,
        start=1,
    ):
        print(
            f"[INFO] Progress: "
            f"{index}/{len(anime_list)}"
        )

        detail = scrape_anime_detail(
            anime
        )

        if detail:
            anime_details.append(
                detail
            )

        # Respectful delay between requests.
        if index < len(anime_list):
            time.sleep(
                REQUEST_DELAY
            )

    print(
        f"[INFO] Successfully scraped "
        f"{len(anime_details)} anime."
    )

    # Step 3: Normalize and preprocess data.
    normalized_data = normalize_data(
        anime_details
    )

    # Step 4: Save each entity into a separate JSON file.
    save_json(
        "anime.json",
        normalized_data["anime"],
    )

    save_json(
        "genres.json",
        normalized_data["genres"],
    )

    save_json(
        "studios.json",
        normalized_data["studios"],
    )

    save_json(
        "producers.json",
        normalized_data["producers"],
    )

    save_json(
        "anime_genres.json",
        normalized_data["anime_genres"],
    )

    save_json(
        "anime_studios.json",
        normalized_data["anime_studios"],
    )

    save_json(
        "anime_producers.json",
        normalized_data["anime_producers"],
    )

    print("=" * 60)
    print("Scraping and preprocessing completed.")
    print("=" * 60)


if __name__ == "__main__":
    main()
