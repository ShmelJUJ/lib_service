-- Role: lib_adm
DROP ROLE IF EXISTS lib_adm;
CREATE ROLE lib_adm WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  BYPASSRLS
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:/NdAUU/t6wlAG44Eb6Qt/Q==$ewxncPnB59+baWT4Pb7ikkoL+CfnomqI3Rr7HF18kjM=:O+nGJ3C0MmVjAJXtO9lkCvVw9KhcDGsG9d/kiZhrdh0=';


-- Role: lib_user
DROP ROLE IF EXISTS lib_user;

CREATE ROLE lib_user WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  BYPASSRLS
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:Qgbu2SNImyi49EI1nNAJJQ==$tGf6uGmVINr4RIDtNE++Etv9XzT0SVWgOxhZ8jlLYwg=:uA8oeoUMQ6adh4YQInaRH50AkGYQ9DSRyuBr9JBiuzQ=';

CREATE TABLE public.author (
    author_id integer NOT NULL,
    full_name character varying(100) NOT NULL
);


ALTER TABLE public.author OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16444)
-- Name: author_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.author_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_author_id_seq OWNER TO postgres;

--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 224
-- Name: author_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_author_id_seq OWNED BY public.author.author_id;


--
-- TOC entry 223 (class 1259 OID 16437)
-- Name: author_book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.author_book (
    book_id integer NOT NULL,
    author_id integer NOT NULL
);


ALTER TABLE public.author_book OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16436)
-- Name: author_book_author_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.author_book_author_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_book_author_id_seq OWNER TO postgres;

--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 222
-- Name: author_book_author_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_book_author_id_seq OWNED BY public.author_book.author_id;


--
-- TOC entry 221 (class 1259 OID 16435)
-- Name: author_book_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.author_book_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.author_book_book_id_seq OWNER TO postgres;

--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 221
-- Name: author_book_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.author_book_book_id_seq OWNED BY public.author_book.book_id;


--
-- TOC entry 220 (class 1259 OID 16428)
-- Name: books; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.books (
    book_id integer NOT NULL,
    title character varying(100) NOT NULL,
    release_date date NOT NULL,
    genre character varying(50),
    amount integer NOT NULL,
    CONSTRAINT books_amount_check CHECK ((amount >= 0))
);


ALTER TABLE public.books OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16427)
-- Name: books_book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.books_book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_book_id_seq OWNER TO postgres;

--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 219
-- Name: books_book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.books_book_id_seq OWNED BY public.books.book_id;


--
-- TOC entry 218 (class 1259 OID 16420)
-- Name: issuance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.issuance (
    issuance_id integer NOT NULL,
    book_id integer NOT NULL,
    issuance_date date NOT NULL,
    deadline_date date NOT NULL,
    user_id integer NOT NULL,
    is_returned boolean,
    CONSTRAINT issuance_check CHECK ((deadline_date > issuance_date))
);


ALTER TABLE public.issuance OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16419)
-- Name: issuance_issuance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.issuance_issuance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.issuance_issuance_id_seq OWNER TO postgres;

--
-- TOC entry 4907 (class 0 OID 0)
-- Dependencies: 217
-- Name: issuance_issuance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.issuance_issuance_id_seq OWNED BY public.issuance.issuance_id;


--
-- TOC entry 216 (class 1259 OID 16402)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    login character varying(25),
    pass text,
    user_role character varying(20) NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16401)
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- TOC entry 4909 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- TOC entry 4715 (class 2604 OID 16448)
-- Name: author author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author ALTER COLUMN author_id SET DEFAULT nextval('public.author_author_id_seq'::regclass);


--
-- TOC entry 4713 (class 2604 OID 16440)
-- Name: author_book book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book ALTER COLUMN book_id SET DEFAULT nextval('public.author_book_book_id_seq'::regclass);


--
-- TOC entry 4714 (class 2604 OID 16441)
-- Name: author_book author_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book ALTER COLUMN author_id SET DEFAULT nextval('public.author_book_author_id_seq'::regclass);


--
-- TOC entry 4712 (class 2604 OID 16431)
-- Name: books book_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books ALTER COLUMN book_id SET DEFAULT nextval('public.books_book_id_seq'::regclass);


--
-- TOC entry 4711 (class 2604 OID 16423)
-- Name: issuance issuance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuance ALTER COLUMN issuance_id SET DEFAULT nextval('public.issuance_issuance_id_seq'::regclass);


--
-- TOC entry 4710 (class 2604 OID 16405)
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- TOC entry 4891 (class 0 OID 16445)
-- Dependencies: 225
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author VALUES (1, 'Толстой Л.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (2, 'Лем С.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (3, 'Оруэлл Дж.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (4, 'Буре В.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (5, 'Парилина Е.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (6, 'Сэлинджер Дж.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (7, 'Ильф И.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (8, 'Петров Е.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (9, 'Гримм Я.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (10, 'Гримм В.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (11, 'Ландау Л.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (12, 'Лифшиц Е.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (13, 'Стругацкий А.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (14, 'Стругацкий Б.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (15, 'Ремарк Э.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (16, 'Булгаков М.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (17, 'Лермонтов М.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (18, 'Маяковский В.') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (19, 'Жуль Верн') ON CONFLICT DO NOTHING;
INSERT INTO public.author VALUES (20, 'Марк Твен') ON CONFLICT DO NOTHING;


--
-- TOC entry 4889 (class 0 OID 16437)
-- Dependencies: 223
-- Data for Name: author_book; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.author_book VALUES (1, 1) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (2, 2) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (3, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (4, 4) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (4, 5) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (5, 6) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (6, 7) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (6, 8) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (7, 9) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (7, 10) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (8, 11) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (8, 12) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (9, 13) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (9, 14) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (10, 15) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (11, 16) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (12, 17) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (13, 18) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (14, 19) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (15, 20) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (16, 13) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (16, 14) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (17, 3) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (18, 15) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (19, 19) ON CONFLICT DO NOTHING;
INSERT INTO public.author_book VALUES (20, 20) ON CONFLICT DO NOTHING;


--
-- TOC entry 4886 (class 0 OID 16428)
-- Dependencies: 220
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.books VALUES (1, 'Война и мир', '1869-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (2, 'Солярис', '1961-01-01', 'научная фантастика', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (4, 'Теория вероятностей и математическая статистика', '2013-01-01', 'учебник', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (5, 'Над пропастью во ржи', '1951-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (6, 'Двенадцать стульев', '1928-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (7, 'Сказки братьев Гримм', '1858-01-01', 'фольклор', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (8, 'Курс теоретической физики Ландау и Лифшица', '1960-01-01', 'учебник', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (12, 'Герой нашего времени', '1840-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (13, 'Во весь голос', '1930-01-01', 'поэма', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (16, 'Трудно быть богом', '1964-01-01', 'научная фантастика', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (17, 'Скотный двор', '1945-01-01', 'сатира', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (20, 'Приключения Гекльберри Финна', '1884-01-01', 'сатира', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (19, 'Таинственный остров', '1874-01-01', 'приключение', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (10, 'Три товарища', '1936-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (14, 'Пятнадцатилетний капитан', '1878-01-01', 'приключение', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (11, 'Мастер и Маргарита', '1967-01-01', 'роман', 8) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (18, 'На Западном фронте без перемен', '1929-01-01', 'роман', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (15, 'Приключения Тома Сойера', '1876-01-01', 'приключение', 5) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (9, 'Град обреченный', '1989-01-01', 'научная фантастика', 6) ON CONFLICT DO NOTHING;
INSERT INTO public.books VALUES (3, '1984', '1949-01-01', 'антиутопия', 5) ON CONFLICT DO NOTHING;



ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_pkey PRIMARY KEY (book_id, author_id);


--
-- TOC entry 4733 (class 2606 OID 16450)
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (author_id);


--
-- TOC entry 4729 (class 2606 OID 16434)
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (book_id);


--
-- TOC entry 4727 (class 2606 OID 16426)
-- Name: issuance issuance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuance
    ADD CONSTRAINT issuance_pkey PRIMARY KEY (issuance_id);


--
-- TOC entry 4719 (class 2606 OID 16472)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 4721 (class 2606 OID 16474)
-- Name: users users_login_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key1 UNIQUE (login);


--
-- TOC entry 4723 (class 2606 OID 16476)
-- Name: users users_login_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key2 UNIQUE (login);


--
-- TOC entry 4725 (class 2606 OID 16409)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4736 (class 2606 OID 16466)
-- Name: author_book author_book_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(author_id);


--
-- TOC entry 4737 (class 2606 OID 16461)
-- Name: author_book author_book_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.author_book
    ADD CONSTRAINT author_book_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- TOC entry 4734 (class 2606 OID 16456)
-- Name: issuance issuance_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuance
    ADD CONSTRAINT issuance_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(book_id);


--
-- TOC entry 4735 (class 2606 OID 16451)
-- Name: issuance issuance_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.issuance
    ADD CONSTRAINT issuance_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE author; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.author TO lib_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.author TO lib_user;


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE author_book; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.author_book TO lib_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.author_book TO lib_user;


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE books; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.books TO lib_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.books TO lib_user;


--
-- TOC entry 4906 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE issuance; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.issuance TO lib_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.issuance TO lib_user;


--
-- TOC entry 4908 (class 0 OID 0)
-- Dependencies: 216
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO lib_adm;
GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.users TO lib_user;


-- Completed on 2024-03-16 01:21:00

--
-- PostgreSQL database dump complete
--

