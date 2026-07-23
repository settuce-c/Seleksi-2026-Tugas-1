--
-- PostgreSQL database dump
--

\restrict tZBG0E74vzLSt8RJAKLNwr1MSuf2JBtRjkOZlyXNUDVyb9wjqEAdZZem94CCFX7

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: anime; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anime (
    anime_id integer NOT NULL,
    title character varying(255) NOT NULL,
    rank integer,
    score numeric(3,2),
    members integer,
    episodes integer,
    status character varying(100),
    aired character varying(255),
    duration_minutes integer,
    rating character varying(100),
    url text
);


ALTER TABLE public.anime OWNER TO postgres;

--
-- Name: anime_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anime_genres (
    anime_id integer NOT NULL,
    genre_id integer NOT NULL
);


ALTER TABLE public.anime_genres OWNER TO postgres;

--
-- Name: anime_producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anime_producers (
    anime_id integer NOT NULL,
    producer_id integer NOT NULL
);


ALTER TABLE public.anime_producers OWNER TO postgres;

--
-- Name: anime_studios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.anime_studios (
    anime_id integer NOT NULL,
    studio_id integer NOT NULL
);


ALTER TABLE public.anime_studios OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.genres (
    genre_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.genres OWNER TO postgres;

--
-- Name: producers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producers (
    producer_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.producers OWNER TO postgres;

--
-- Name: studios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.studios (
    studio_id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.studios OWNER TO postgres;

--
-- Data for Name: anime; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anime (anime_id, title, rank, score, members, episodes, status, aired, duration_minutes, rating, url) FROM stdin;
61316	Re:Zero kara Hajimeru Isekai Seikatsu 4th Season	1	9.16	296568	19	Currently Airing	Apr 8, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/61316/Re_Zero_kara_Hajimeru_Isekai_Seikatsu_4th_Season
61469	Steel Ball Run: JoJo no Kimyou na Bouken	2	9.10	223205	\N	Currently Airing	Mar 19, 2026 to ?	47	R - 17+ (violence & profanity)	https://myanimelist.net/anime/61469/Steel_Ball_Run__JoJo_no_Kimyou_na_Bouken
59193	Mushoku Tensei III: Isekai Ittara Honki Dasu	3	8.82	275117	14	Currently Airing	Jul 6, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/59193/Mushoku_Tensei_III__Isekai_Ittara_Honki_Dasu
21	One Piece	4	8.73	2709071	\N	Currently Airing	Oct 20, 1999 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/21/One_Piece
50250	Chiikawa	5	8.60	23269	\N	Currently Airing	Apr 4, 2022 to ?	1	G - All Ages	https://myanimelist.net/anime/50250/Chiikawa
60988	Tian Guan Cifu Short Films	6	8.49	12204	\N	Currently Airing	Feb 12, 2025 to ?	8	PG-13 - Teens 13 or older	https://myanimelist.net/anime/60988/Tian_Guan_Cifu_Short_Films
55809	Xian Ni	7	8.49	12228	180	Currently Airing	Sep 25, 2023 to ?	25	PG-13 - Teens 13 or older	https://myanimelist.net/anime/55809/Xian_Ni
61483	Tenmaku no Jaadugar	8	8.42	58086	\N	Currently Airing	Jul 4, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61483/Tenmaku_no_Jaadugar
49233	Youjo Senki II	9	8.42	243468	12	Currently Airing	Jul 8, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/49233/Youjo_Senki_II
51039	Doupo Cangqiong: Nian Fan	10	8.41	12676	219	Currently Airing	Jul 31, 2022 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/51039/Doupo_Cangqiong__Nian_Fan
62542	Grand Blue Season 3	11	8.41	88286	12	Currently Airing	Jul 7, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62542/Grand_Blue_Season_3
62076	Super no Ura de Yani Suu Futari	12	8.40	182486	12	Currently Airing	Jul 9, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62076/Super_no_Ura_de_Yani_Suu_Futari
63832	Seihantai na Kimi to Boku 2nd Season	13	8.37	83869	13	Currently Airing	Jul 5, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/63832/Seihantai_na_Kimi_to_Boku_2nd_Season
56524	Tunshi Xingkong 4th Season	14	8.32	6430	175	Currently Airing	Oct 3, 2023 to ?	21	PG-13 - Teens 13 or older	https://myanimelist.net/anime/56524/Tunshi_Xingkong_4th_Season
59953	Mushen Ji	15	8.29	16153	\N	Currently Airing	Oct 27, 2024 to ?	20	PG-13 - Teens 13 or older	https://myanimelist.net/anime/59953/Mushen_Ji
235	Meitantei Conan	16	8.18	380108	\N	Currently Airing	Jan 8, 1996 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/235/Meitantei_Conan
62811	Kimi no Koto ga Daidaidaidaidaisuki na 100-nin no Kanojo 3rd Season	17	8.15	64360	\N	Currently Airing	Jul 5, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62811/Kimi_no_Koto_ga_Daidaidaidaidaisuki_na_100-nin_no_Kanojo_3rd_Season
44042	Holo no Graffiti	18	8.14	58533	\N	Currently Airing	May 5, 2019 to ?	1	PG-13 - Teens 13 or older	https://myanimelist.net/anime/44042/Holo_no_Graffiti
59970	Tensei shitara Slime Datta Ken 4th Season	19	8.13	229875	24	Currently Airing	Apr 3, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/59970/Tensei_shitara_Slime_Datta_Ken_4th_Season
60310	Mairimashita! Iruma-kun 4th Season	20	8.11	86080	24	Currently Airing	Apr 4, 2026 to ?	25	PG-13 - Teens 13 or older	https://myanimelist.net/anime/60310/Mairimashita_Iruma-kun_4th_Season
51836	Douluo Dalu II: Jueshi Tangmen	21	8.04	7391	182	Currently Airing	Jun 24, 2023 to ?	20	PG-13 - Teens 13 or older	https://myanimelist.net/anime/51836/Douluo_Dalu_II__Jueshi_Tangmen
58929	Koukaku Kidoutai (TV)	22	7.97	72332	\N	Currently Airing	Jul 7, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/58929/Koukaku_Kidoutai_TV
62936	Toumei na Yoru ni Kakeru Kimi to, Me ni Mienai Koi wo Shita.	23	7.93	52964	\N	Currently Airing	Jul 6, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62936/Toumei_na_Yoru_ni_Kakeru_Kimi_to_Me_ni_Mienai_Koi_wo_Shita
63240	Fanren Xiu Xian Zhuan: Mulan Zhi Zhan	24	7.91	1557	52	Currently Airing	Jun 13, 2026 to ?	20	PG-13 - Teens 13 or older	https://myanimelist.net/anime/63240/Fanren_Xiu_Xian_Zhuan__Mulan_Zhi_Zhan
62001	Yomi no Tsugai	25	7.87	219323	24	Currently Airing	Apr 4, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/62001/Yomi_no_Tsugai
47405	Wanmei Shijie	26	7.85	14569	286	Currently Airing	Apr 23, 2021 to ?	19	PG-13 - Teens 13 or older	https://myanimelist.net/anime/47405/Wanmei_Shijie
61126	Kimi ga Shinu made Koi wo Shitai	27	7.84	71547	13	Currently Airing	Jul 7, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61126/Kimi_ga_Shinu_made_Koi_wo_Shitai
58878	Sayonara Lara	28	7.84	35540	12	Currently Airing	Jul 6, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/58878/Sayonara_Lara
966	Crayon Shin-chan	29	7.82	94916	\N	Currently Airing	Apr 13, 1992 to ?	21	G - All Ages	https://myanimelist.net/anime/966/Crayon_Shin-chan
57466	Honzuki no Gekokujou: Shisho ni Naru Tame ni wa Shudan wo Erandeiraremasen - Ryoushu no Youjo	30	7.81	85937	24	Currently Airing	Apr 4, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/57466/Honzuki_no_Gekokujou__Shisho_ni_Naru_Tame_ni_wa_Shudan_wo_Erandeiraremasen_-_Ryoushu_no_Youjo
64398	Guangyin Zhi Wai 2	31	7.80	849	52	Currently Airing	Jun 20, 2026 to ?	25	PG-13 - Teens 13 or older	https://myanimelist.net/anime/64398/Guangyin_Zhi_Wai_2
8687	Doraemon (2005)	32	7.78	23612	\N	Currently Airing	Apr 22, 2005 to ?	25	PG - Children	https://myanimelist.net/anime/8687/Doraemon_2005
61240	Futsutsuka na Akujo dewa Gozaimasu ga: Suuguu Chouso Torikae Den	33	7.77	42830	11	Currently Airing	Jul 12, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61240/Futsutsuka_na_Akujo_dewa_Gozaimasu_ga__Suuguu_Chouso_Torikae_Den
62856	Nijusseiki Denki Mokuroku: Eureka Evrika	34	7.75	64140	13	Currently Airing	Jul 5, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62856/Nijusseiki_Denki_Mokuroku__Eureka_Evrika
51289	Zhe Tian	35	7.75	4264	208	Currently Airing	May 3, 2023 to ?	18	PG-13 - Teens 13 or older	https://myanimelist.net/anime/51289/Zhe_Tian
62513	Clevatess II: Majuu no Ou to Itsuwari no Yuusha Denshou	36	7.71	70690	13	Currently Airing	Jul 8, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/62513/Clevatess_II__Majuu_no_Ou_to_Itsuwari_no_Yuusha_Denshou
61048	Neko to Ryuu	37	7.67	31332	\N	Currently Airing	Jul 4, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61048/Neko_to_Ryuu
63150	Otome Kaijuu Caraméliser	38	7.67	46009	\N	Currently Airing	Jul 3, 2026 to ?	24	PG-13 - Teens 13 or older	https://myanimelist.net/anime/63150/Otome_Kaijuu_Caraméliser
55315	Gensou Mangekyou: The Memories of Phantasm	39	7.65	11554	\N	Currently Airing	Aug 12, 2011 to ?	16	PG-13 - Teens 13 or older	https://myanimelist.net/anime/55315/Gensou_Mangekyou__The_Memories_of_Phantasm
63042	Meitantei Precure!	40	7.65	7590	\N	Currently Airing	Feb 1, 2026 to ?	24	G - All Ages	https://myanimelist.net/anime/63042/Meitantei_Precure
61921	Shen Mu: Nian Fan	41	7.59	1153	52	Currently Airing	Aug 8, 2025 to ?	20	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61921/Shen_Mu__Nian_Fan
41409	Wushen Zhuzai	42	7.59	6942	720	Currently Airing	Mar 8, 2020 to ?	8	PG-13 - Teens 13 or older	https://myanimelist.net/anime/41409/Wushen_Zhuzai
60059	Nige Jouzu no Wakagimi 2nd Season	43	7.58	43894	12	Currently Airing	Jul 17, 2026 to ?	23	R - 17+ (violence & profanity)	https://myanimelist.net/anime/60059/Nige_Jouzu_no_Wakagimi_2nd_Season
60534	Koupen-chan	44	7.57	7038	\N	Currently Airing	Apr 6, 2025 to ?	1	G - All Ages	https://myanimelist.net/anime/60534/Koupen-chan
50855	Yamato yo, Towa ni: Rebel 3199	45	7.57	5672	\N	Currently Airing	Jul 19, 2024 to ?	110	PG-13 - Teens 13 or older	https://myanimelist.net/anime/50855/Yamato_yo_Towa_ni__Rebel_3199
61280	Kore Kaite Shine	46	7.56	13221	12	Currently Airing	Jul 3, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/61280/Kore_Kaite_Shine
62430	BanG Dream! Yume∞Mita	47	7.55	8670	\N	Currently Airing	Jul 2, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62430/BanG_Dream_Yume∞Mita
62651	Cang Yuan Tu 3	48	7.54	1255	\N	Currently Airing	Apr 3, 2026 to ?	22	PG-13 - Teens 13 or older	https://myanimelist.net/anime/62651/Cang_Yuan_Tu_3
46488	Tai-Ari deshita. Ojousama wa Kakutou Game nante Shinai	49	7.50	38617	\N	Currently Airing	Jul 7, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/46488/Tai-Ari_deshita_Ojousama_wa_Kakutou_Game_nante_Shinai
63347	World Is Dancing	50	7.47	29832	13	Currently Airing	Jul 2, 2026 to ?	23	PG-13 - Teens 13 or older	https://myanimelist.net/anime/63347/World_Is_Dancing
\.


--
-- Data for Name: anime_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anime_genres (anime_id, genre_id) FROM stdin;
61316	1
61316	2
61316	3
61469	4
61469	5
61469	6
61469	7
59193	5
59193	1
59193	2
59193	8
21	4
21	5
21	2
60988	4
60988	5
60988	1
60988	2
55809	4
55809	5
55809	2
49233	4
49233	2
51039	4
51039	5
51039	2
63832	9
63832	10
56524	4
56524	5
56524	2
56524	11
59953	4
59953	5
59953	2
235	5
235	9
235	6
62811	9
62811	10
59970	4
59970	9
59970	2
60310	9
60310	2
51836	4
51836	5
51836	2
58929	4
58929	6
58929	11
58929	3
62936	1
62936	10
63240	4
63240	5
63240	2
62001	4
62001	5
62001	7
47405	4
47405	5
47405	2
61126	2
61126	12
58878	2
58878	10
966	9
966	8
64398	4
64398	5
64398	2
8687	9
8687	11
61240	2
61240	10
51289	4
51289	5
51289	2
51289	11
62513	4
62513	2
63150	10
63150	7
63042	4
63042	6
61921	4
61921	5
61921	2
41409	4
41409	1
41409	2
60059	5
60059	9
50855	4
50855	1
50855	11
62651	4
62651	5
62651	2
46488	9
46488	12
\.


--
-- Data for Name: anime_producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anime_producers (anime_id, producer_id) FROM stdin;
61316	1
61316	2
61316	3
61316	4
61316	5
61316	6
61469	7
61469	8
61469	9
59193	10
59193	11
59193	2
59193	4
59193	12
59193	13
59193	5
59193	14
59193	15
21	16
21	17
50250	18
60988	19
55809	20
61483	21
61483	22
61483	23
61483	24
49233	1
49233	2
49233	25
49233	5
49233	26
51039	20
51039	27
51039	28
62542	29
62542	30
62542	31
62542	32
62542	33
62542	34
62542	35
62076	36
62076	37
62076	38
62076	39
62076	40
62076	22
62076	41
63832	42
63832	43
63832	29
63832	44
63832	45
63832	46
63832	39
56524	20
59953	19
235	47
235	48
235	49
235	50
235	51
235	52
62811	53
62811	54
62811	55
62811	56
62811	45
62811	57
44042	18
59970	53
59970	30
59970	2
59970	58
59970	12
59970	59
59970	60
59970	26
59970	41
59970	61
59970	57
60310	18
51836	20
51836	62
58929	63
58929	42
58929	30
58929	64
58929	44
58929	65
58929	61
62936	43
62936	1
62936	8
62936	46
62936	66
62936	67
62936	68
63240	19
62001	69
62001	70
62001	71
62001	72
47405	20
61126	73
61126	54
61126	1
61126	2
61126	74
61126	75
61126	76
61126	5
61126	77
58878	47
58878	78
58878	25
58878	5
58878	40
58878	79
58878	23
58878	80
966	21
57466	47
57466	43
57466	54
57466	81
57466	64
57466	82
57466	83
64398	84
64398	85
8687	21
61240	86
61240	44
61240	87
61240	76
61240	14
61240	88
62856	53
62856	89
62856	90
62856	91
62856	92
62856	57
51289	20
62513	1
62513	25
62513	93
62513	94
62513	5
62513	95
62513	96
61048	47
61048	97
61048	81
61048	56
61048	98
61048	99
61048	94
61048	100
61048	79
61048	101
61048	102
61048	103
63150	89
63150	36
63150	81
63150	104
63150	12
63150	105
63150	5
63150	106
63150	107
55315	18
63042	21
63042	91
63042	108
61921	84
41409	20
41409	109
60059	70
60059	42
60059	16
60059	56
60059	45
60059	12
60059	22
60534	110
50855	63
50855	111
50855	43
50855	60
50855	41
50855	61
50855	57
61280	112
61280	10
61280	113
61280	58
61280	114
61280	48
61280	22
62430	115
62430	55
62430	56
62430	116
62430	117
62430	118
62430	22
62651	84
46488	29
46488	1
46488	119
46488	94
46488	5
46488	22
46488	79
63347	43
63347	56
63347	120
63347	121
63347	122
63347	46
63347	123
63347	40
63347	23
63347	124
\.


--
-- Data for Name: anime_studios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.anime_studios (anime_id, studio_id) FROM stdin;
61316	1
61469	2
59193	3
21	4
50250	5
60988	6
55809	7
61483	8
49233	9
51039	10
62542	11
62542	12
62076	13
63832	14
56524	15
59953	15
235	16
62811	17
44042	18
59970	19
60310	20
51836	15
58929	8
62936	21
63240	22
63240	23
62001	24
47405	25
61126	26
58878	27
966	28
57466	29
64398	30
64398	31
8687	28
61240	5
62856	32
51289	22
62513	33
61048	34
63150	35
55315	36
63042	4
61921	23
61921	30
41409	37
41409	38
60059	39
60534	40
50855	41
61280	28
62430	42
62651	43
46488	44
63347	45
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.genres (genre_id, name) FROM stdin;
1	Drama
2	Fantasy
3	Suspense
4	Action
5	Adventure
6	Mystery
7	Supernatural
8	Ecchi
9	Comedy
10	Romance
11	Sci-Fi
12	Girls Love
\.


--
-- Data for Name: producers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.producers (producer_id, name) FROM stdin;
1	AT-X
2	Magic Capsule
3	Memory-Tech
4	Hakuhodo DY Music & Pictures
5	Kadokawa
6	DAXEL
7	Warner Bros. Japan
8	Studio Mausu
9	ONEMUSIC
10	Frontier Works
11	TOHO
12	BS11
13	Egg Firm
14	TOHO Music
15	GREE Entertainment
16	Fuji TV
17	TAP
18	add some
19	bilibili
20	Tencent Video
21	TV Asahi
22	Bit grooove promotion
23	BS Asahi
24	TV Asahi Music
25	Sammy
26	Sony Music Solutions
27	China Literature Limited
28	Wanda Cinemas
29	Mainichi Broadcasting System
30	Kodansha
31	NBCUniversal Entertainment Japan
32	Avex Pictures
33	JR East Marketing & Communications
34	Saber Links
35	qooop
36	TBS
37	Asmik Ace
38	Nichion
39	AbemaTV
40	arma bianca
41	ADK Marketing Solutions
42	Dentsu
43	Shochiku
44	Tohokushinsha Film Corporation
45	Shueisha
46	Shochiku Music Publishing
47	Yomiuri Telecasting
48	Shogakukan
49	Audio Planning U
50	Tokyo Movie
51	Polydor Records
52	Zet
53	Lantis
54	Movic
55	Bushiroad
56	Tokyo MX
57	Bandai Namco Music Live
58	Nippon Television Network
59	Micro Magazine Publishing
60	Bandai Spirits
61	Bandai Namco Filmworks
62	Xuanshi Tangmen
63	Production I.G
64	flying DOG
65	Kansai TV
66	SB Creative
67	Clare Voice
68	viviON
69	Bones
70	Aniplex
71	Square Enix
72	Peerless Gerbera
73	WOWOW
74	Infinite
75	Kadokawa Media House
76	Ichijinsha
77	NewGin
78	Sound Team Don Juan
79	Pia
80	West Japan Marketing Communications
81	KlockWorx
82	Yomiuri TV Enterprise
83	TO Books
84	Youku
85	Bu Keneng de Shijie
86	TV Tokyo
87	TOHO animation
88	Verygoo
89	Pony Canyon
90	Rakuonsha
91	ABC Animation
92	Heart Company
93	Crunchyroll
94	BS NTV
95	INSPION Edge
96	LINE Digital Frontier
97	DAX Production
98	Docomo Anime Store
99	Nippon Television Music
100	MAGNET
101	Bushiroad Move
102	Hike
103	Takarajimasha
104	Glovision
105	Contents Seed
106	Good Smile Film
107	Sankyo
108	ADK Emotions
109	Quyue Technology
110	Stay Luck
111	Satelight
112	VAP
113	Shogakukan-Shueisha Productions
114	Miracle Bus
115	Ultra Super Pictures
116	Good Smile Company
117	Bushiroad Music
118	HoriPro International
119	U-NEXT
120	Toy's Factory
121	CyberAgent
122	Cygames
123	dugout
124	Happinet Media Marketing
\.


--
-- Data for Name: studios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.studios (studio_id, name) FROM stdin;
1	White Fox
2	David Production
3	Studio Bind
4	Toei Animation
5	Doga Kobo
6	Red Dog Culture House
7	BUILD DREAM
8	Science SARU
9	Nut
10	Motion Magic
11	Zero-G
12	Saber Works
13	Asahi Production
14	Lapin Track
15	Sparkly Key Animation Studio
16	TMS Entertainment
17	Bibury Animation Studios
18	Hololive Production
19	8bit
20	Bandai Namco Pictures
21	Makaria
22	Original Force
23	Wonder Cat Animation
24	Bones Film
25	Foch Film
26	ROLL2
27	Kinema Citrus
28	Shin-Ei Animation
29	Wit Studio
30	Yien Animation Studio
31	Flying Fish Studio
32	Kyoto Animation
33	Lay-duce
34	OLM
35	LIDENFILMS
36	Manpuku Jinja
37	Ruo Hong Culture
38	Manhoo Culture
39	CloverWorks
40	Lesprit
41	studio MOTHER
42	Nichicaline
43	Shenman Culture
44	Diomedéa
45	Cypic
\.


--
-- Name: anime_genres anime_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_genres
    ADD CONSTRAINT anime_genres_pkey PRIMARY KEY (anime_id, genre_id);


--
-- Name: anime anime_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime
    ADD CONSTRAINT anime_pkey PRIMARY KEY (anime_id);


--
-- Name: anime_producers anime_producers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_producers
    ADD CONSTRAINT anime_producers_pkey PRIMARY KEY (anime_id, producer_id);


--
-- Name: anime_studios anime_studios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_studios
    ADD CONSTRAINT anime_studios_pkey PRIMARY KEY (anime_id, studio_id);


--
-- Name: anime anime_url_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime
    ADD CONSTRAINT anime_url_key UNIQUE (url);


--
-- Name: genres genres_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_name_key UNIQUE (name);


--
-- Name: genres genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.genres
    ADD CONSTRAINT genres_pkey PRIMARY KEY (genre_id);


--
-- Name: producers producers_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producers_name_key UNIQUE (name);


--
-- Name: producers producers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producers
    ADD CONSTRAINT producers_pkey PRIMARY KEY (producer_id);


--
-- Name: studios studios_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT studios_name_key UNIQUE (name);


--
-- Name: studios studios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.studios
    ADD CONSTRAINT studios_pkey PRIMARY KEY (studio_id);


--
-- Name: idx_anime_genres_anime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_genres_anime ON public.anime_genres USING btree (anime_id);


--
-- Name: idx_anime_genres_genre; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_genres_genre ON public.anime_genres USING btree (genre_id);


--
-- Name: idx_anime_producers_anime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_producers_anime ON public.anime_producers USING btree (anime_id);


--
-- Name: idx_anime_producers_producer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_producers_producer ON public.anime_producers USING btree (producer_id);


--
-- Name: idx_anime_studios_anime; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_studios_anime ON public.anime_studios USING btree (anime_id);


--
-- Name: idx_anime_studios_studio; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_anime_studios_studio ON public.anime_studios USING btree (studio_id);


--
-- Name: anime_genres anime_genres_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_genres
    ADD CONSTRAINT anime_genres_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(anime_id) ON DELETE CASCADE;


--
-- Name: anime_genres anime_genres_genre_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_genres
    ADD CONSTRAINT anime_genres_genre_id_fkey FOREIGN KEY (genre_id) REFERENCES public.genres(genre_id) ON DELETE CASCADE;


--
-- Name: anime_producers anime_producers_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_producers
    ADD CONSTRAINT anime_producers_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(anime_id) ON DELETE CASCADE;


--
-- Name: anime_producers anime_producers_producer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_producers
    ADD CONSTRAINT anime_producers_producer_id_fkey FOREIGN KEY (producer_id) REFERENCES public.producers(producer_id) ON DELETE CASCADE;


--
-- Name: anime_studios anime_studios_anime_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_studios
    ADD CONSTRAINT anime_studios_anime_id_fkey FOREIGN KEY (anime_id) REFERENCES public.anime(anime_id) ON DELETE CASCADE;


--
-- Name: anime_studios anime_studios_studio_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.anime_studios
    ADD CONSTRAINT anime_studios_studio_id_fkey FOREIGN KEY (studio_id) REFERENCES public.studios(studio_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict tZBG0E74vzLSt8RJAKLNwr1MSuf2JBtRjkOZlyXNUDVyb9wjqEAdZZem94CCFX7

