# Tugas Seleksi 1 Asisten Basis Data 2026

## Author

**Nama:** Zahra Zahidah Putri Ruchwijaya

**NIM:** 18224058

---

# Step 1 Data Scraping & Preprocessing

## Deskripsi

Project ini bertujuan untuk melakukan scraping data Top Airing Anime dari website MyAnimeList menggunakan Python. Data yang diperoleh kemudian diproses (preprocessing), dinormalisasi menjadi beberapa file JSON, dan diimplementasikan ke dalam database relasional menggunakan PostgreSQL.

Website yang digunakan:

https://myanimelist.net/topanime.php?type=airing

Topik ini dipilih karena adanya ketertarikan terhadap anime sehingga struktur data yang tersedia lebih mudah dipahami dan hasil scraping lebih mudah divalidasi.

---

## Cara Menjalankan Scraper

1. Clone repository.

```bash
git clone <repository-url>
```

2. Masuk ke folder project.

```bash
cd "Data Scraping"
```

3. Install dependency.

```bash
pip install requests beautifulsoup4 lxml
```

4. Jalankan scraper.

```bash
python src/code/scraper.py
```

5. Setelah proses scraping selesai, hasil akan disimpan ke folder

```
Data Scraping/data/
```

berupa beberapa file JSON.

6. Untuk memuat hasil scraping ke dalam database PostgreSQL yang sudah dibuat pada Step 3, jalankan skrip pemuatan data.

```bash
python src/load_data.py
```

---

## Struktur File JSON

Data hasil scraping dinormalisasi menjadi tujuh buah file JSON pada folder `Data Scraping/data`.

| File | Deskripsi |
|------|-----------|
| anime.json | Menyimpan informasi utama setiap anime |
| genres.json | Menyimpan daftar genre |
| studios.json | Menyimpan daftar studio |
| producers.json | Menyimpan daftar producer |
| anime_genres.json | Relasi banyak ke banyak antara anime dan genre |
| anime_studios.json | Relasi banyak ke banyak antara anime dan studio |
| anime_producers.json | Relasi banyak ke banyak antara anime dan producer |

### Contoh Struktur Data

### anime.json

```json
{
    "anime_id": 61316,
    "title": "Re:Zero kara Hajimeru Isekai Seikatsu 4th Season",
    "rank": 1,
    "score": 9.16,
    "members": 296568,
    "episodes": 19,
    "status": "Currently Airing",
    "aired": "Apr 8, 2026 to ?",
    "duration_minutes": 23,
    "rating": "R 17+ (violence & profanity)",
    "url": "https://myanimelist.net/..."
}
```

### genres.json

```json
{
    "genre_id": 1,
    "name": "Drama"
}
```

### studios.json

```json
{
    "studio_id": 10,
    "name": "Motion Magic"
}
```

### producers.json

```json
{
    "producer_id": 1,
    "name": "AT X"
}
```

### anime_genres.json

```json
{
    "anime_id": 61316,
    "genre_id": 1
}
```

### anime_studios.json

```json
{
    "anime_id": 61316,
    "studio_id": 1
}
```

### anime_producers.json

```json
{
    "anime_id": 61316,
    "producer_id": 1
}
```

---

# Step 2 Data Modelling

## Entity

Database terdiri atas tujuh buah tabel.

| Tabel | Primary Key |
|--------|-------------|
| anime | anime_id |
| genres | genre_id |
| studios | studio_id |
| producers | producer_id |
| anime_genres | (anime_id, genre_id) |
| anime_studios | (anime_id, studio_id) |
| anime_producers | (anime_id, producer_id) |

Tiga tabel terakhir merupakan junction table yang merepresentasikan hubungan banyak ke banyak.

---

## Entity Relationship Diagram (ERD)

![ERD](Data%20Storing/design/ERD.png)

---

## Diagram Relasional

![Relational Diagram](Data%20Storing/design/relational_diagram.png)

---

## Translasi ERD ke Database Relasional

ERD diterjemahkan ke dalam model relasional dengan menerapkan normalisasi terhadap hubungan banyak ke banyak.

Relasi antara anime dengan genre, studio, dan producer dipisahkan menggunakan junction table sehingga tidak terjadi redundansi data.

Setiap junction table menggunakan:

* Composite primary key
* Foreign key
* Referential integrity
* On delete cascade

---

# Step 3 Data Storing

## DBMS

Database diimplementasikan menggunakan PostgreSQL.

Tabel yang dibuat terdiri atas:

* anime
* genres
* studios
* producers
* anime_genres
* anime_studios
* anime_producers

Seluruh query pembuatan tabel tersedia pada file

```
Data Storing/export/schema.sql
```

Hasil export lengkap database beserta isinya tersedia pada file

```
Data Storing/export/myanimelist_db.sql
```

---

## Index

Untuk meningkatkan performa query pada junction table, ditambahkan beberapa index.

```sql
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
```

---

## Import Data

Seluruh data JSON diimpor menggunakan script

```
Data Scraping/src/load_data.py
```

Cara menjalankan (dari root folder repository):

```bash
python "Data Scraping/src/load_data.py"
```

Output:

```
Connected to PostgreSQL

12 genres imported
45 studios imported
124 producers imported
50 anime imported
102 anime_genres imported
55 anime_studios imported
228 anime_producers imported

All data imported successfully.
```

---

## Screenshot

Bukti hasil query SELECT terhadap database yang telah diisi.

```sql
SELECT title, score
FROM anime
WHERE score > 8.5;
```

![Query 1](Data%20Storing/screenshot/query_bukti1.png)

![Query 2](Data%20Storing/screenshot/query_bukti2.png)

![Query 3](Data%20Storing/screenshot/query_bukti3.png)

![Query 4](Data%20Storing/screenshot/query_bukti4.png)

![Query 5](Data%20Storing/screenshot/query_bukti5.png)

---

# Struktur Folder

```
.
├── Data Scraping
│   ├── data
│   └── src
│       ├── code
│       │   └── scraper.py
│       └── load_data.py
├── Data Storing
│   ├── design
│   │   ├── ERD.png
│   │   └── relational_diagram.png
│   ├── export
│   │   ├── myanimelist_db.sql
│   │   └── schema.sql
│   ├── screenshot
│   │   ├── query_bukti1.png
│   │   ├── query_bukti2.png
│   │   ├── query_bukti3.png
│   │   ├── query_bukti4.png
│   │   └── query_bukti5.png
│   └── src
└── README.md
```

---

# Referensi

* MyAnimeList
* BeautifulSoup4 Documentation
* Requests Documentation
* PostgreSQL Documentation
* psycopg2 Documentation

---

# Penggunaan AI

AI digunakan sebagai alat bantu selama proses pengerjaan tugas, terutama pada:

* Memberikan penjelasan mengenai konsep ERD dan diagram relasional.
* Membantu debugging error selama implementasi PostgreSQL.
* Memberikan masukan terkait normalisasi database.
* Membantu penyusunan dokumentasi README.
* Memberikan contoh query SQL untuk pengujian database.

Bagian yang tetap dikerjakan secara mandiri meliputi:

* Menentukan topik scraping.
* Mengembangkan scraper menggunakan Python.
* Melakukan preprocessing data hasil scraping.
* Menyusun desain ERD dan diagram relasional.
* Mengimplementasikan database PostgreSQL.
* Melakukan pengujian hasil scraping dan proses import data.

Seluruh hasil yang diberikan AI telah dipelajari kembali, disesuaikan dengan kebutuhan project, serta diuji sebelum digunakan.
