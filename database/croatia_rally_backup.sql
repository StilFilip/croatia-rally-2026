--
-- PostgreSQL database dump
--

\restrict gfUoJ3coy9IGytXR1QIdh6RSzZbmTPAbvKWGlyi14hzXJTryDixKmgCrFcyN0sJ

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-11-14 15:44:50

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

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4970 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16427)
-- Name: brzinski_ispit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brzinski_ispit (
    id integer NOT NULL,
    rally_id integer NOT NULL,
    oznaka character varying(20) NOT NULL,
    naziv character varying(150) NOT NULL,
    prolazak integer,
    datum date NOT NULL,
    vrijeme_starta time without time zone NOT NULL,
    duljina_km numeric(6,2) NOT NULL,
    podloga character varying(50) DEFAULT 'Asfalt'::character varying NOT NULL,
    zupanija character varying(100),
    power_stage boolean DEFAULT false NOT NULL,
    start_lokacija_id integer NOT NULL,
    cilj_lokacija_id integer NOT NULL,
    CONSTRAINT chk_ispit_duljina CHECK ((duljina_km > (0)::numeric)),
    CONSTRAINT chk_ispit_prolazak CHECK (((prolazak IS NULL) OR (prolazak >= 1)))
);


ALTER TABLE public.brzinski_ispit OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16426)
-- Name: brzinski_ispit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.brzinski_ispit ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.brzinski_ispit_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 16404)
-- Name: lokacija; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lokacija (
    id integer NOT NULL,
    naziv character varying(150) NOT NULL,
    sirina numeric(10,7) NOT NULL,
    duzina numeric(10,7) NOT NULL,
    CONSTRAINT chk_lokacija_duzina CHECK (((duzina >= ('-180'::integer)::numeric) AND (duzina <= (180)::numeric))),
    CONSTRAINT chk_lokacija_sirina CHECK (((sirina >= ('-90'::integer)::numeric) AND (sirina <= (90)::numeric)))
);


ALTER TABLE public.lokacija OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16403)
-- Name: lokacija_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.lokacija ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.lokacija_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 228 (class 1259 OID 16467)
-- Name: najbrzi_rezultat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.najbrzi_rezultat (
    id integer NOT NULL,
    brzinski_ispit_id integer NOT NULL,
    posada_id integer NOT NULL,
    vrijeme interval NOT NULL,
    CONSTRAINT chk_rezultat_vrijeme CHECK ((vrijeme > '00:00:00'::interval))
);


ALTER TABLE public.najbrzi_rezultat OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16466)
-- Name: najbrzi_rezultat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.najbrzi_rezultat ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.najbrzi_rezultat_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16416)
-- Name: posada; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.posada (
    id integer NOT NULL,
    vozac character varying(100) NOT NULL,
    suvozac character varying(100) NOT NULL
);


ALTER TABLE public.posada OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16415)
-- Name: posada_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.posada ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.posada_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 16390)
-- Name: rally; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rally (
    id integer NOT NULL,
    naziv character varying(150) NOT NULL,
    godina integer NOT NULL,
    datum_pocetka date NOT NULL,
    datum_zavrsetka date NOT NULL,
    lokacija character varying(150),
    CONSTRAINT chk_rally_datumi CHECK ((datum_zavrsetka >= datum_pocetka))
);


ALTER TABLE public.rally OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16389)
-- Name: rally_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.rally ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.rally_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4962 (class 0 OID 16427)
-- Dependencies: 226
-- Data for Name: brzinski_ispit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brzinski_ispit (id, rally_id, oznaka, naziv, prolazak, datum, vrijeme_starta, duljina_km, podloga, zupanija, power_stage, start_lokacija_id, cilj_lokacija_id) FROM stdin;
1	1	SD	Shakedown	\N	2026-04-09	10:01:00	3.44	Asfalt	Primorsko-goranska	f	1	2
2	1	SS1	Vodice - Brest	1	2026-04-10	09:13:00	14.12	Asfalt	Istarska	f	3	4
3	1	SS5	Vodice - Brest	2	2026-04-10	15:15:00	14.12	Asfalt	Istarska	f	3	4
4	1	SS2	Lake Butoniga - Motovun	1	2026-04-10	10:11:00	13.78	Asfalt	Istarska	f	5	6
5	1	SS6	Lake Butoniga - Motovun	2	2026-04-10	16:13:00	13.78	Asfalt	Istarska	f	5	6
6	1	SS3	Beram - Cerovlje	1	2026-04-10	11:14:00	23.78	Asfalt	Istarska	f	7	8
7	1	SS7	Beram - Cerovlje	2	2026-04-10	17:16:00	23.78	Asfalt	Istarska	f	7	8
8	1	SS4	Ucka	1	2026-04-10	12:02:00	11.75	Asfalt	Primorsko-goranska	f	9	10
9	1	SS8	Ucka	2	2026-04-10	18:04:00	11.75	Asfalt	Primorsko-goranska	f	9	10
10	1	SS9	Platak	1	2026-04-11	08:43:00	16.26	Asfalt	Primorsko-goranska	f	11	12
11	1	SS16	Platak	2	2026-04-11	17:22:00	16.26	Asfalt	Primorsko-goranska	f	11	12
12	1	SS10	Ravna Gora - Skrad	1	2026-04-11	09:41:00	10.13	Asfalt	Primorsko-goranska	f	13	14
13	1	SS15	Ravna Gora - Skrad	2	2026-04-11	16:23:00	10.13	Asfalt	Primorsko-goranska	f	13	14
14	1	SS11	Generalski Stol - Zdihovo	1	2026-04-11	11:05:00	22.48	Asfalt	Karlovačka	f	15	16
15	1	SS14	Generalski Stol - Zdihovo	2	2026-04-11	15:05:00	22.48	Asfalt	Karlovačka	f	15	16
16	1	SS12	Pecurkovo Brdo - Mreznicki Novaki	1	2026-04-11	12:03:00	9.11	Asfalt	Karlovačka	f	17	18
17	1	SS13	Pecurkovo Brdo - Mreznicki Novaki	2	2026-04-11	14:12:00	9.11	Asfalt	Karlovačka	f	17	18
18	1	SS17	Bribir - Novi Vinodolski	1	2026-04-12	08:05:00	14.17	Asfalt	Primorsko-goranska	f	19	20
19	1	SS19	Bribir - Novi Vinodolski	2	2026-04-12	10:38:00	14.17	Asfalt	Primorsko-goranska	f	19	20
20	1	SS18	Alan - Senj	1	2026-04-12	09:05:00	14.56	Asfalt	Ličko-senjska	f	21	22
21	1	SS20	Alan - Senj	2	2026-04-12	13:15:00	14.56	Asfalt	Ličko-senjska	t	21	22
\.


--
-- TOC entry 4958 (class 0 OID 16404)
-- Dependencies: 222
-- Data for Name: lokacija; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lokacija (id, naziv, sirina, duzina) FROM stdin;
1	Shakedown - Start	45.3887957	14.4139918
2	Shakedown - Finish	45.3918354	14.4243343
3	SS 1/5 - Start	45.4807958	14.0561422
4	SS 1/5 - Finish	45.4485605	13.9813497
5	SS 2/6 - Start	45.3304776	13.9188410
6	SS 2/6 - Finish	45.3352621	13.8528927
7	SS 3/7 - Start	45.2726228	13.9078818
8	SS 3/7 - Finish	45.2799048	14.0042488
9	SS 4/8 - Start	45.3170143	14.1758335
10	SS 4/8 - Finish	45.3357525	14.2678790
11	SS 9/16 - Start	45.3690638	14.6165880
12	SS 9/16 - Finish	45.3862086	14.5634286
13	SS 10/15 - Start	45.3769955	14.9232420
14	SS 10/15 - Finish	45.4313225	14.9118909
15	SS 11/14 - Start	45.3470661	15.3594455
16	SS 11/14 - Finish	45.4049363	15.2214691
17	SS 12/13 - Start	45.4312182	15.5349365
18	SS 12/13 - Finish	45.3991398	15.4881791
19	SS 17/19 - Start	45.2136927	14.8090912
20	SS 17/19 - Finish	45.1506033	14.7910149
21	SS 18/20 - Start	45.0734724	14.9310936
22	SS 18/20 - Finish	44.9936029	14.9075944
\.


--
-- TOC entry 4964 (class 0 OID 16467)
-- Dependencies: 228
-- Data for Name: najbrzi_rezultat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.najbrzi_rezultat (id, brzinski_ispit_id, posada_id, vrijeme) FROM stdin;
1	11	1	00:08:49.5
2	4	1	00:07:33.9
3	2	1	00:07:59.7
4	7	2	00:13:19.8
5	5	2	00:07:39
6	6	2	00:13:20.5
7	9	3	00:06:50.2
8	3	3	00:08:14.6
9	8	3	00:06:55.3
10	21	4	00:07:03.3
11	19	4	00:07:16.4
12	20	4	00:07:03.2
13	18	4	00:07:10.7
14	13	4	00:05:46.9
15	15	4	00:13:59.5
16	16	4	00:04:49
17	14	4	00:13:44.9
18	12	4	00:05:43
19	10	4	00:08:36.8
20	17	5	00:04:47
\.


--
-- TOC entry 4960 (class 0 OID 16416)
-- Dependencies: 224
-- Data for Name: posada; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.posada (id, vozac, suvozac) FROM stdin;
1	Elfyn Evans	Scott Martin
2	Thierry Neuville	Martijn Wydaeghe
3	Sami Pajari	Marko Salminen
4	Oliver Solberg	Elliott Edmondson
5	Takamoto Katsuta	Aaron Johnston
\.


--
-- TOC entry 4956 (class 0 OID 16390)
-- Dependencies: 220
-- Data for Name: rally; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rally (id, naziv, godina, datum_pocetka, datum_zavrsetka, lokacija) FROM stdin;
1	Croatia Rally	2026	2026-04-09	2026-04-12	Hrvatska
\.


--
-- TOC entry 4971 (class 0 OID 0)
-- Dependencies: 225
-- Name: brzinski_ispit_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brzinski_ispit_id_seq', 21, true);


--
-- TOC entry 4972 (class 0 OID 0)
-- Dependencies: 221
-- Name: lokacija_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lokacija_id_seq', 22, true);


--
-- TOC entry 4973 (class 0 OID 0)
-- Dependencies: 227
-- Name: najbrzi_rezultat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.najbrzi_rezultat_id_seq', 20, true);


--
-- TOC entry 4974 (class 0 OID 0)
-- Dependencies: 223
-- Name: posada_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.posada_id_seq', 5, true);


--
-- TOC entry 4975 (class 0 OID 0)
-- Dependencies: 219
-- Name: rally_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rally_id_seq', 1, true);


--
-- TOC entry 4794 (class 2606 OID 16446)
-- Name: brzinski_ispit brzinski_ispit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT brzinski_ispit_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 16414)
-- Name: lokacija lokacija_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lokacija
    ADD CONSTRAINT lokacija_pkey PRIMARY KEY (id);


--
-- TOC entry 4800 (class 2606 OID 16476)
-- Name: najbrzi_rezultat najbrzi_rezultat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.najbrzi_rezultat
    ADD CONSTRAINT najbrzi_rezultat_pkey PRIMARY KEY (id);


--
-- TOC entry 4790 (class 2606 OID 16423)
-- Name: posada posada_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posada
    ADD CONSTRAINT posada_pkey PRIMARY KEY (id);


--
-- TOC entry 4784 (class 2606 OID 16400)
-- Name: rally rally_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rally
    ADD CONSTRAINT rally_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 16448)
-- Name: brzinski_ispit uq_ispit_oznaka; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT uq_ispit_oznaka UNIQUE (rally_id, oznaka);


--
-- TOC entry 4798 (class 2606 OID 16450)
-- Name: brzinski_ispit uq_ispit_prolazak; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT uq_ispit_prolazak UNIQUE (rally_id, naziv, prolazak);


--
-- TOC entry 4792 (class 2606 OID 16425)
-- Name: posada uq_posada; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.posada
    ADD CONSTRAINT uq_posada UNIQUE (vozac, suvozac);


--
-- TOC entry 4786 (class 2606 OID 16402)
-- Name: rally uq_rally_naziv_godina; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rally
    ADD CONSTRAINT uq_rally_naziv_godina UNIQUE (naziv, godina);


--
-- TOC entry 4802 (class 2606 OID 16478)
-- Name: najbrzi_rezultat uq_rezultat_ispit; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.najbrzi_rezultat
    ADD CONSTRAINT uq_rezultat_ispit UNIQUE (brzinski_ispit_id);


--
-- TOC entry 4803 (class 2606 OID 16461)
-- Name: brzinski_ispit fk_ispit_cilj_lokacija; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT fk_ispit_cilj_lokacija FOREIGN KEY (cilj_lokacija_id) REFERENCES public.lokacija(id);


--
-- TOC entry 4804 (class 2606 OID 16451)
-- Name: brzinski_ispit fk_ispit_rally; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT fk_ispit_rally FOREIGN KEY (rally_id) REFERENCES public.rally(id);


--
-- TOC entry 4805 (class 2606 OID 16456)
-- Name: brzinski_ispit fk_ispit_start_lokacija; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brzinski_ispit
    ADD CONSTRAINT fk_ispit_start_lokacija FOREIGN KEY (start_lokacija_id) REFERENCES public.lokacija(id);


--
-- TOC entry 4806 (class 2606 OID 16479)
-- Name: najbrzi_rezultat fk_rezultat_ispit; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.najbrzi_rezultat
    ADD CONSTRAINT fk_rezultat_ispit FOREIGN KEY (brzinski_ispit_id) REFERENCES public.brzinski_ispit(id);


--
-- TOC entry 4807 (class 2606 OID 16484)
-- Name: najbrzi_rezultat fk_rezultat_posada; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.najbrzi_rezultat
    ADD CONSTRAINT fk_rezultat_posada FOREIGN KEY (posada_id) REFERENCES public.posada(id);


-- Completed on 2026-11-14 15:44:50

--
-- PostgreSQL database dump complete
--

\unrestrict gfUoJ3coy9IGytXR1QIdh6RSzZbmTPAbvKWGlyi14hzXJTryDixKmgCrFcyN0sJ

