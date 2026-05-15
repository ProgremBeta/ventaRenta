--
-- PostgreSQL database dump
--

\restrict jV5K5a5FuHahmgz9hzuQvwROEbjP8NXGo2mGzyyo5hw4I77lm5waDwbEoLPzSKx

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
-- Name: alertas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alertas (
    id integer NOT NULL,
    usuario_id integer,
    tipo character varying(50) NOT NULL,
    descripcion text NOT NULL,
    visto boolean DEFAULT false,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.alertas OWNER TO postgres;

--
-- Name: alertas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.alertas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alertas_id_seq OWNER TO postgres;

--
-- Name: alertas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.alertas_id_seq OWNED BY public.alertas.id;


--
-- Name: categorias_dispositivos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias_dispositivos (
    id integer NOT NULL,
    nombre character varying(150),
    descripcion text,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categorias_dispositivos OWNER TO postgres;

--
-- Name: categorias_dispositivos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_dispositivos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_dispositivos_id_seq OWNER TO postgres;

--
-- Name: categorias_dispositivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_dispositivos_id_seq OWNED BY public.categorias_dispositivos.id;


--
-- Name: categorias_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categorias_productos (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.categorias_productos OWNER TO postgres;

--
-- Name: categorias_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categorias_productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_productos_id_seq OWNER TO postgres;

--
-- Name: categorias_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categorias_productos_id_seq OWNED BY public.categorias_productos.id;


--
-- Name: clientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    telefono character varying(30),
    puntos integer DEFAULT 0,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO postgres;

--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO postgres;

--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: detalles_deudas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalles_deudas (
    id integer NOT NULL,
    deuda_id integer,
    origen_tipo character varying(50),
    origen_id integer,
    descripcion text,
    monto_pagado numeric(10,2) DEFAULT 0,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalles_deudas OWNER TO postgres;

--
-- Name: detalles_deudas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalles_deudas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalles_deudas_id_seq OWNER TO postgres;

--
-- Name: detalles_deudas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalles_deudas_id_seq OWNED BY public.detalles_deudas.id;


--
-- Name: detalles_rentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalles_rentas (
    id integer NOT NULL,
    renta_id integer,
    dispositivo_id integer,
    precio_hora numeric(10,2) NOT NULL,
    tiempo_total interval NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalles_rentas OWNER TO postgres;

--
-- Name: detalles_rentas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalles_rentas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalles_rentas_id_seq OWNER TO postgres;

--
-- Name: detalles_rentas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalles_rentas_id_seq OWNED BY public.detalles_rentas.id;


--
-- Name: detalles_ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.detalles_ventas (
    id integer NOT NULL,
    venta_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    sub_total numeric(10,2) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.detalles_ventas OWNER TO postgres;

--
-- Name: detalles_ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.detalles_ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalles_ventas_id_seq OWNER TO postgres;

--
-- Name: detalles_ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.detalles_ventas_id_seq OWNED BY public.detalles_ventas.id;


--
-- Name: deudas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.deudas (
    id integer NOT NULL,
    cliente_id integer,
    monto_total numeric(10,2),
    monto_pagado numeric(10,2) DEFAULT 0,
    saldo numeric(10,2),
    estado character varying(50),
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.deudas OWNER TO postgres;

--
-- Name: deudas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.deudas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deudas_id_seq OWNER TO postgres;

--
-- Name: deudas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.deudas_id_seq OWNED BY public.deudas.id;


--
-- Name: dispositivos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dispositivos (
    id integer NOT NULL,
    nombre character varying(150),
    categoria_id integer NOT NULL,
    precio_hora numeric(10,2),
    estado character varying(50),
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.dispositivos OWNER TO postgres;

--
-- Name: dispositivos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dispositivos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dispositivos_id_seq OWNER TO postgres;

--
-- Name: dispositivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dispositivos_id_seq OWNED BY public.dispositivos.id;


--
-- Name: inventario_productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inventario_productos (
    id integer NOT NULL,
    producto_id integer,
    stock integer NOT NULL,
    stock_minimo integer DEFAULT 0,
    activo boolean DEFAULT true,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventario_productos OWNER TO postgres;

--
-- Name: inventario_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.inventario_productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_productos_id_seq OWNER TO postgres;

--
-- Name: inventario_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.inventario_productos_id_seq OWNED BY public.inventario_productos.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    usuario_id integer,
    accion character varying(150) NOT NULL,
    descripcion text,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO postgres;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: metodos_pagos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.metodos_pagos (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    descripcion text,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.metodos_pagos OWNER TO postgres;

--
-- Name: metodos_pagos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.metodos_pagos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.metodos_pagos_id_seq OWNER TO postgres;

--
-- Name: metodos_pagos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.metodos_pagos_id_seq OWNED BY public.metodos_pagos.id;


--
-- Name: pagos_deudas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pagos_deudas (
    id integer NOT NULL,
    deuda_id integer,
    monto numeric(10,2),
    metodo_pago integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pagos_deudas OWNER TO postgres;

--
-- Name: pagos_deudas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pagos_deudas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_deudas_id_seq OWNER TO postgres;

--
-- Name: pagos_deudas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pagos_deudas_id_seq OWNED BY public.pagos_deudas.id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    categoria_id integer NOT NULL,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productos OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO postgres;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: rentas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rentas (
    id integer NOT NULL,
    usuario_id integer,
    cliente_id integer,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    tiempo_total interval,
    precio_total numeric(10,2),
    metodo_pago integer,
    estado character varying(50),
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.rentas OWNER TO postgres;

--
-- Name: rentas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rentas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentas_id_seq OWNER TO postgres;

--
-- Name: rentas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rentas_id_seq OWNED BY public.rentas.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    identificacion character varying(20) NOT NULL,
    nombre character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    telefono character varying(30),
    contrasena_hash text NOT NULL,
    rol_id integer NOT NULL,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: ventas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ventas (
    id integer NOT NULL,
    usuario_id integer,
    cliente_id integer,
    total numeric(10,2) NOT NULL,
    metodo_pago integer,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ventas OWNER TO postgres;

--
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_id_seq OWNER TO postgres;

--
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- Name: alertas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertas ALTER COLUMN id SET DEFAULT nextval('public.alertas_id_seq'::regclass);


--
-- Name: categorias_dispositivos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_dispositivos ALTER COLUMN id SET DEFAULT nextval('public.categorias_dispositivos_id_seq'::regclass);


--
-- Name: categorias_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_productos ALTER COLUMN id SET DEFAULT nextval('public.categorias_productos_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: detalles_deudas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_deudas ALTER COLUMN id SET DEFAULT nextval('public.detalles_deudas_id_seq'::regclass);


--
-- Name: detalles_rentas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_rentas ALTER COLUMN id SET DEFAULT nextval('public.detalles_rentas_id_seq'::regclass);


--
-- Name: detalles_ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_ventas ALTER COLUMN id SET DEFAULT nextval('public.detalles_ventas_id_seq'::regclass);


--
-- Name: deudas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deudas ALTER COLUMN id SET DEFAULT nextval('public.deudas_id_seq'::regclass);


--
-- Name: dispositivos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispositivos ALTER COLUMN id SET DEFAULT nextval('public.dispositivos_id_seq'::regclass);


--
-- Name: inventario_productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_productos ALTER COLUMN id SET DEFAULT nextval('public.inventario_productos_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: metodos_pagos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagos ALTER COLUMN id SET DEFAULT nextval('public.metodos_pagos_id_seq'::regclass);


--
-- Name: pagos_deudas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_deudas ALTER COLUMN id SET DEFAULT nextval('public.pagos_deudas_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Name: rentas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas ALTER COLUMN id SET DEFAULT nextval('public.rentas_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- Data for Name: alertas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alertas (id, usuario_id, tipo, descripcion, visto, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: categorias_dispositivos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias_dispositivos (id, nombre, descripcion, activo, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: categorias_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categorias_productos (id, nombre, descripcion, activo, fecha_creacion) FROM stdin;
1	relojeria	todo lo que tenga que ver con relojes	t	2026-05-04 23:13:19.94379-05
\.


--
-- Data for Name: clientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.clientes (id, nombre, email, telefono, puntos, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: detalles_deudas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalles_deudas (id, deuda_id, origen_tipo, origen_id, descripcion, monto_pagado, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: detalles_rentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalles_rentas (id, renta_id, dispositivo_id, precio_hora, tiempo_total, sub_total, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: detalles_ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.detalles_ventas (id, venta_id, producto_id, cantidad, precio_unitario, sub_total, fecha_creacion) FROM stdin;
1	1	1	5	15000.00	75000.00	2026-05-04 23:33:08.921118-05
2	2	1	10	15000.00	150000.00	2026-05-04 23:39:12.592348-05
3	3	1	1	15000.00	15000.00	2026-05-12 10:44:07.218323-05
\.


--
-- Data for Name: deudas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.deudas (id, cliente_id, monto_total, monto_pagado, saldo, estado, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: dispositivos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dispositivos (id, nombre, categoria_id, precio_hora, estado, activo, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: inventario_productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.inventario_productos (id, producto_id, stock, stock_minimo, activo, fecha_actualizacion) FROM stdin;
1	1	4	2	\N	2026-05-04 23:25:50.653588-05
3	2	0	2	\N	2026-05-12 10:44:38.745101-05
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, usuario_id, accion, descripcion, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: metodos_pagos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.metodos_pagos (id, nombre, descripcion, fecha_creacion) FROM stdin;
1	efectivo	todo tipo de pago hecho en efectivo	2026-05-04 23:33:00.193703-05
\.


--
-- Data for Name: pagos_deudas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pagos_deudas (id, deuda_id, monto, metodo_pago, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: productos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productos (id, nombre, descripcion, precio, categoria_id, activo, fecha_creacion) FROM stdin;
1	reloj	para ver la hora	15000.00	1	t	2026-05-04 23:25:50.644026-05
2	platos	para ver la comer	15000.00	1	t	2026-05-12 10:44:38.740262-05
\.


--
-- Data for Name: rentas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rentas (id, usuario_id, cliente_id, fecha_inicio, fecha_fin, tiempo_total, precio_total, metodo_pago, estado, fecha_creacion) FROM stdin;
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, nombre, activo, fecha_creacion) FROM stdin;
1	ignacio	t	2026-05-04 16:17:34.193812-05
2	cliente	t	2026-05-04 17:02:21.373561-05
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, identificacion, nombre, email, telefono, contrasena_hash, rol_id, activo, fecha_creacion) FROM stdin;
7	1059696994	ignacio	betancurj86@gmail.com	3017985344	$2b$05$f9PZzZoAxYCP14ro19ZWA.lCo4aACKOGRa4Pyg/3Nyyg0rEU9us7G	1	t	2026-05-04 17:06:05.657506-05
\.


--
-- Data for Name: ventas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ventas (id, usuario_id, cliente_id, total, metodo_pago, fecha_creacion) FROM stdin;
1	7	\N	75000.00	1	2026-05-04 23:33:08.91416-05
2	7	\N	150000.00	1	2026-05-04 23:39:12.585452-05
3	7	\N	15000.00	1	2026-05-12 10:44:07.207848-05
\.


--
-- Name: alertas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.alertas_id_seq', 1, false);


--
-- Name: categorias_dispositivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_dispositivos_id_seq', 1, false);


--
-- Name: categorias_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categorias_productos_id_seq', 1, true);


--
-- Name: clientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clientes_id_seq', 1, false);


--
-- Name: detalles_deudas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalles_deudas_id_seq', 1, false);


--
-- Name: detalles_rentas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalles_rentas_id_seq', 1, false);


--
-- Name: detalles_ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.detalles_ventas_id_seq', 3, true);


--
-- Name: deudas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.deudas_id_seq', 1, false);


--
-- Name: dispositivos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dispositivos_id_seq', 1, false);


--
-- Name: inventario_productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.inventario_productos_id_seq', 3, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 1, false);


--
-- Name: metodos_pagos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.metodos_pagos_id_seq', 1, true);


--
-- Name: pagos_deudas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pagos_deudas_id_seq', 1, false);


--
-- Name: productos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productos_id_seq', 2, true);


--
-- Name: rentas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rentas_id_seq', 1, false);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 8, true);


--
-- Name: ventas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ventas_id_seq', 3, true);


--
-- Name: alertas alertas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_pkey PRIMARY KEY (id);


--
-- Name: categorias_dispositivos categorias_dispositivos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_dispositivos
    ADD CONSTRAINT categorias_dispositivos_pkey PRIMARY KEY (id);


--
-- Name: categorias_productos categorias_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categorias_productos
    ADD CONSTRAINT categorias_productos_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: detalles_deudas detalles_deudas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_deudas
    ADD CONSTRAINT detalles_deudas_pkey PRIMARY KEY (id);


--
-- Name: detalles_rentas detalles_rentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_rentas
    ADD CONSTRAINT detalles_rentas_pkey PRIMARY KEY (id);


--
-- Name: detalles_ventas detalles_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_ventas
    ADD CONSTRAINT detalles_ventas_pkey PRIMARY KEY (id);


--
-- Name: deudas deudas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deudas
    ADD CONSTRAINT deudas_pkey PRIMARY KEY (id);


--
-- Name: dispositivos dispositivos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_pkey PRIMARY KEY (id);


--
-- Name: inventario_productos inventario_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_pkey PRIMARY KEY (id);


--
-- Name: inventario_productos inventario_productos_producto_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_producto_id_key UNIQUE (producto_id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: metodos_pagos metodos_pagos_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagos
    ADD CONSTRAINT metodos_pagos_nombre_key UNIQUE (nombre);


--
-- Name: metodos_pagos metodos_pagos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.metodos_pagos
    ADD CONSTRAINT metodos_pagos_pkey PRIMARY KEY (id);


--
-- Name: pagos_deudas pagos_deudas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_deudas
    ADD CONSTRAINT pagos_deudas_pkey PRIMARY KEY (id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: rentas rentas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_pkey PRIMARY KEY (id);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_identificacion_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_identificacion_key UNIQUE (identificacion);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- Name: idx_detalles_rentas_renta; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalles_rentas_renta ON public.detalles_rentas USING btree (renta_id);


--
-- Name: idx_detalles_ventas_venta; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_detalles_ventas_venta ON public.detalles_ventas USING btree (venta_id);


--
-- Name: idx_deudas_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_deudas_cliente ON public.deudas USING btree (cliente_id);


--
-- Name: idx_dispositivos_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dispositivos_categoria ON public.dispositivos USING btree (categoria_id);


--
-- Name: idx_inventario_producto; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_inventario_producto ON public.inventario_productos USING btree (producto_id);


--
-- Name: idx_logs_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_logs_usuario ON public.logs USING btree (usuario_id);


--
-- Name: idx_pagos_deuda; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pagos_deuda ON public.pagos_deudas USING btree (deuda_id);


--
-- Name: idx_productos_categoria; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_productos_categoria ON public.productos USING btree (categoria_id);


--
-- Name: idx_rentas_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rentas_cliente ON public.rentas USING btree (cliente_id);


--
-- Name: idx_rentas_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rentas_fecha ON public.rentas USING btree (fecha_inicio);


--
-- Name: idx_rentas_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rentas_usuario ON public.rentas USING btree (usuario_id);


--
-- Name: idx_usuarios_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_email ON public.usuarios USING btree (email);


--
-- Name: idx_usuarios_identificacion; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usuarios_identificacion ON public.usuarios USING btree (identificacion);


--
-- Name: idx_ventas_cliente; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ventas_cliente ON public.ventas USING btree (cliente_id);


--
-- Name: idx_ventas_fecha; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ventas_fecha ON public.ventas USING btree (fecha_creacion);


--
-- Name: idx_ventas_usuario; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ventas_usuario ON public.ventas USING btree (usuario_id);


--
-- Name: alertas alertas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: detalles_deudas detalles_deudas_deuda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_deudas
    ADD CONSTRAINT detalles_deudas_deuda_id_fkey FOREIGN KEY (deuda_id) REFERENCES public.deudas(id) ON DELETE CASCADE;


--
-- Name: detalles_rentas detalles_rentas_dispositivo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_rentas
    ADD CONSTRAINT detalles_rentas_dispositivo_id_fkey FOREIGN KEY (dispositivo_id) REFERENCES public.dispositivos(id);


--
-- Name: detalles_rentas detalles_rentas_renta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_rentas
    ADD CONSTRAINT detalles_rentas_renta_id_fkey FOREIGN KEY (renta_id) REFERENCES public.rentas(id) ON DELETE CASCADE;


--
-- Name: detalles_ventas detalles_ventas_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_ventas
    ADD CONSTRAINT detalles_ventas_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- Name: detalles_ventas detalles_ventas_venta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.detalles_ventas
    ADD CONSTRAINT detalles_ventas_venta_id_fkey FOREIGN KEY (venta_id) REFERENCES public.ventas(id) ON DELETE CASCADE;


--
-- Name: deudas deudas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.deudas
    ADD CONSTRAINT deudas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: dispositivos dispositivos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias_dispositivos(id);


--
-- Name: inventario_productos inventario_productos_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: logs logs_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: pagos_deudas pagos_deudas_deuda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_deudas
    ADD CONSTRAINT pagos_deudas_deuda_id_fkey FOREIGN KEY (deuda_id) REFERENCES public.deudas(id) ON DELETE CASCADE;


--
-- Name: pagos_deudas pagos_deudas_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pagos_deudas
    ADD CONSTRAINT pagos_deudas_metodo_pago_fkey FOREIGN KEY (metodo_pago) REFERENCES public.metodos_pagos(id);


--
-- Name: productos productos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias_productos(id);


--
-- Name: rentas rentas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: rentas rentas_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_metodo_pago_fkey FOREIGN KEY (metodo_pago) REFERENCES public.metodos_pagos(id);


--
-- Name: rentas rentas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: usuarios usuarios_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- Name: ventas ventas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: ventas ventas_metodo_pago_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_metodo_pago_fkey FOREIGN KEY (metodo_pago) REFERENCES public.metodos_pagos(id);


--
-- Name: ventas ventas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- PostgreSQL database dump complete
--

\unrestrict jV5K5a5FuHahmgz9hzuQvwROEbjP8NXGo2mGzyyo5hw4I77lm5waDwbEoLPzSKx

