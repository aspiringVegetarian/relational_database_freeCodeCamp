--
-- PostgreSQL database dump
--

-- Dumped from database version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)
-- Dumped by pg_dump version 12.9 (Ubuntu 12.9-2.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
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
-- Name: game_data; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.game_data (
    game_data_id integer NOT NULL,
    games_played integer DEFAULT 0 NOT NULL,
    best_game integer DEFAULT 0,
    username_id integer
);


ALTER TABLE public.game_data OWNER TO freecodecamp;

--
-- Name: game_data_game_data_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.game_data_game_data_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_data_game_data_id_seq OWNER TO freecodecamp;

--
-- Name: game_data_game_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.game_data_game_data_id_seq OWNED BY public.game_data.game_data_id;


--
-- Name: usernames; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.usernames (
    username_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.usernames OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.usernames_username_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usernames_username_id_seq OWNER TO freecodecamp;

--
-- Name: usernames_username_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.usernames_username_id_seq OWNED BY public.usernames.username_id;


--
-- Name: game_data game_data_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_data ALTER COLUMN game_data_id SET DEFAULT nextval('public.game_data_game_data_id_seq'::regclass);


--
-- Name: usernames username_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames ALTER COLUMN username_id SET DEFAULT nextval('public.usernames_username_id_seq'::regclass);


--
-- Data for Name: game_data; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.game_data VALUES (2, 0, 0, 10);
INSERT INTO public.game_data VALUES (3, 0, 0, 11);
INSERT INTO public.game_data VALUES (4, 0, 0, 12);
INSERT INTO public.game_data VALUES (5, 0, 0, 13);
INSERT INTO public.game_data VALUES (6, 0, 0, 14);
INSERT INTO public.game_data VALUES (7, 0, 0, 15);
INSERT INTO public.game_data VALUES (8, 0, 0, 16);
INSERT INTO public.game_data VALUES (9, 0, 0, 17);
INSERT INTO public.game_data VALUES (10, 0, 0, 18);
INSERT INTO public.game_data VALUES (11, 0, 0, 19);
INSERT INTO public.game_data VALUES (12, 0, 0, 20);
INSERT INTO public.game_data VALUES (13, 0, 0, 21);
INSERT INTO public.game_data VALUES (14, 0, 0, 22);
INSERT INTO public.game_data VALUES (15, 0, 0, 23);


--
-- Data for Name: usernames; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.usernames VALUES (10, 'test');
INSERT INTO public.usernames VALUES (11, 'tester');
INSERT INTO public.usernames VALUES (12, 'tester1');
INSERT INTO public.usernames VALUES (13, 'user_1685320554351');
INSERT INTO public.usernames VALUES (14, 'user_1685320554350');
INSERT INTO public.usernames VALUES (15, 'user_1685320599845');
INSERT INTO public.usernames VALUES (16, 'user_1685320599844');
INSERT INTO public.usernames VALUES (17, 'ts');
INSERT INTO public.usernames VALUES (18, 'user_1685320651545');
INSERT INTO public.usernames VALUES (19, 'user_1685320651544');
INSERT INTO public.usernames VALUES (20, 'user_1685320782810');
INSERT INTO public.usernames VALUES (21, 'user_1685320782808');
INSERT INTO public.usernames VALUES (22, 'user_1685321206132');
INSERT INTO public.usernames VALUES (23, 'user_1685321206131');


--
-- Name: game_data_game_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.game_data_game_data_id_seq', 15, true);


--
-- Name: usernames_username_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.usernames_username_id_seq', 23, true);


--
-- Name: game_data game_data_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_pkey PRIMARY KEY (game_data_id);


--
-- Name: usernames usernames_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_pkey PRIMARY KEY (username_id);


--
-- Name: usernames usernames_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.usernames
    ADD CONSTRAINT usernames_username_key UNIQUE (username);


--
-- Name: game_data game_data_username_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.game_data
    ADD CONSTRAINT game_data_username_id_fkey FOREIGN KEY (username_id) REFERENCES public.usernames(username_id);


--
-- PostgreSQL database dump complete
--

