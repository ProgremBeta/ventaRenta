--
-- PostgreSQL database dump
--

\restrict Zxb9KIHJc2XJRxoK48p1wdfPD4xthbda2EXSKf85tG2hmDdSUebicyaMq6tIq75

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
-- Name: alertas; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.alertas (
    id integer NOT NULL,
    usuario_id integer,
    tipo character varying(50) NOT NULL,
    descripcion text NOT NULL,
    leida boolean DEFAULT false,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.alertas OWNER TO ignacio;

--
-- Name: alertas_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.alertas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.alertas_id_seq OWNER TO ignacio;

--
-- Name: alertas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.alertas_id_seq OWNED BY public.alertas.id;


--
-- Name: categorias_dispositivo; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.categorias_dispositivo (
    id integer NOT NULL,
    nombre character varying(100)
);


ALTER TABLE public.categorias_dispositivo OWNER TO ignacio;

--
-- Name: categorias_dispositivo_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.categorias_dispositivo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_dispositivo_id_seq OWNER TO ignacio;

--
-- Name: categorias_dispositivo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.categorias_dispositivo_id_seq OWNED BY public.categorias_dispositivo.id;


--
-- Name: categorias_producto; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.categorias_producto (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL
);


ALTER TABLE public.categorias_producto OWNER TO ignacio;

--
-- Name: categorias_producto_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.categorias_producto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categorias_producto_id_seq OWNER TO ignacio;

--
-- Name: categorias_producto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.categorias_producto_id_seq OWNED BY public.categorias_producto.id;


--
-- Name: clientes; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.clientes (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    email character varying(150),
    telefono character varying(20),
    puntos integer DEFAULT 0,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clientes OWNER TO ignacio;

--
-- Name: clientes_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.clientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.clientes_id_seq OWNER TO ignacio;

--
-- Name: clientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.clientes_id_seq OWNED BY public.clientes.id;


--
-- Name: detalle_ventas; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.detalle_ventas (
    id integer NOT NULL,
    venta_id integer,
    producto_id integer,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2),
    subtotal numeric(10,2)
);


ALTER TABLE public.detalle_ventas OWNER TO ignacio;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.detalle_ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.detalle_ventas_id_seq OWNER TO ignacio;

--
-- Name: detalle_ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.detalle_ventas_id_seq OWNED BY public.detalle_ventas.id;


--
-- Name: deudas; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.deudas (
    id integer NOT NULL,
    cliente_id integer,
    origen_tipo character varying(50),
    origen_id integer,
    monto_total numeric(10,2),
    monto_pagado numeric(10,2) DEFAULT 0,
    saldo numeric(10,2),
    estado character varying(50),
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.deudas OWNER TO ignacio;

--
-- Name: deudas_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.deudas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deudas_id_seq OWNER TO ignacio;

--
-- Name: deudas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.deudas_id_seq OWNED BY public.deudas.id;


--
-- Name: dispositivos; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.dispositivos (
    id integer NOT NULL,
    nombre character varying(150),
    categoria_id integer NOT NULL,
    precio_hora numeric(10,2),
    estado character varying(50),
    activo boolean DEFAULT true
);


ALTER TABLE public.dispositivos OWNER TO ignacio;

--
-- Name: dispositivos_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.dispositivos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.dispositivos_id_seq OWNER TO ignacio;

--
-- Name: dispositivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.dispositivos_id_seq OWNED BY public.dispositivos.id;


--
-- Name: inventario_productos; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.inventario_productos (
    id integer NOT NULL,
    producto_id integer,
    stock integer NOT NULL,
    fecha_actualizacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.inventario_productos OWNER TO ignacio;

--
-- Name: inventario_productos_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.inventario_productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.inventario_productos_id_seq OWNER TO ignacio;

--
-- Name: inventario_productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.inventario_productos_id_seq OWNED BY public.inventario_productos.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    usuario_id integer,
    accion character varying(100),
    descripcion text,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO ignacio;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO ignacio;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: pagos_deuda; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.pagos_deuda (
    id integer NOT NULL,
    deuda_id integer,
    monto numeric(10,2),
    metodo_pago character varying(50),
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.pagos_deuda OWNER TO ignacio;

--
-- Name: pagos_deuda_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.pagos_deuda_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pagos_deuda_id_seq OWNER TO ignacio;

--
-- Name: pagos_deuda_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.pagos_deuda_id_seq OWNED BY public.pagos_deuda.id;


--
-- Name: productos; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.productos (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    descripcion text,
    precio numeric(10,2) NOT NULL,
    categoria_id integer NOT NULL,
    activo boolean DEFAULT true
);


ALTER TABLE public.productos OWNER TO ignacio;

--
-- Name: productos_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productos_id_seq OWNER TO ignacio;

--
-- Name: productos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;


--
-- Name: renta_dispositivos; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.renta_dispositivos (
    id integer NOT NULL,
    renta_id integer,
    dispositivo_id integer,
    precio_hora numeric(10,2)
);


ALTER TABLE public.renta_dispositivos OWNER TO ignacio;

--
-- Name: renta_dispositivos_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.renta_dispositivos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.renta_dispositivos_id_seq OWNER TO ignacio;

--
-- Name: renta_dispositivos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.renta_dispositivos_id_seq OWNED BY public.renta_dispositivos.id;


--
-- Name: rentas; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.rentas (
    id integer NOT NULL,
    cliente_id integer,
    usuario_id integer,
    fecha_inicio timestamp with time zone,
    fecha_fin timestamp with time zone,
    tiempo_total interval,
    precio_total numeric(10,2),
    metodo_pago character varying(50),
    estado character varying(50)
);


ALTER TABLE public.rentas OWNER TO ignacio;

--
-- Name: rentas_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.rentas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rentas_id_seq OWNER TO ignacio;

--
-- Name: rentas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.rentas_id_seq OWNED BY public.rentas.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO ignacio;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO ignacio;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(150) NOT NULL,
    email character varying(150) NOT NULL,
    telefono character varying(20) NOT NULL,
    contrasena_hash text NOT NULL,
    rol_id integer NOT NULL,
    activo boolean DEFAULT true,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.usuarios OWNER TO ignacio;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO ignacio;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: ventas; Type: TABLE; Schema: public; Owner: ignacio
--

CREATE TABLE public.ventas (
    id integer NOT NULL,
    usuario_id integer,
    cliente_id integer,
    total numeric(10,2) NOT NULL,
    metodo_pago character varying(50) NOT NULL,
    fecha_creacion timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ventas OWNER TO ignacio;

--
-- Name: ventas_id_seq; Type: SEQUENCE; Schema: public; Owner: ignacio
--

CREATE SEQUENCE public.ventas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ventas_id_seq OWNER TO ignacio;

--
-- Name: ventas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ignacio
--

ALTER SEQUENCE public.ventas_id_seq OWNED BY public.ventas.id;


--
-- Name: alertas id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.alertas ALTER COLUMN id SET DEFAULT nextval('public.alertas_id_seq'::regclass);


--
-- Name: categorias_dispositivo id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.categorias_dispositivo ALTER COLUMN id SET DEFAULT nextval('public.categorias_dispositivo_id_seq'::regclass);


--
-- Name: categorias_producto id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.categorias_producto ALTER COLUMN id SET DEFAULT nextval('public.categorias_producto_id_seq'::regclass);


--
-- Name: clientes id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.clientes ALTER COLUMN id SET DEFAULT nextval('public.clientes_id_seq'::regclass);


--
-- Name: detalle_ventas id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.detalle_ventas ALTER COLUMN id SET DEFAULT nextval('public.detalle_ventas_id_seq'::regclass);


--
-- Name: deudas id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.deudas ALTER COLUMN id SET DEFAULT nextval('public.deudas_id_seq'::regclass);


--
-- Name: dispositivos id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.dispositivos ALTER COLUMN id SET DEFAULT nextval('public.dispositivos_id_seq'::regclass);


--
-- Name: inventario_productos id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.inventario_productos ALTER COLUMN id SET DEFAULT nextval('public.inventario_productos_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: pagos_deuda id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.pagos_deuda ALTER COLUMN id SET DEFAULT nextval('public.pagos_deuda_id_seq'::regclass);


--
-- Name: productos id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);


--
-- Name: renta_dispositivos id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.renta_dispositivos ALTER COLUMN id SET DEFAULT nextval('public.renta_dispositivos_id_seq'::regclass);


--
-- Name: rentas id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.rentas ALTER COLUMN id SET DEFAULT nextval('public.rentas_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Name: ventas id; Type: DEFAULT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.ventas ALTER COLUMN id SET DEFAULT nextval('public.ventas_id_seq'::regclass);


--
-- Name: alertas alertas_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_pkey PRIMARY KEY (id);


--
-- Name: categorias_dispositivo categorias_dispositivo_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.categorias_dispositivo
    ADD CONSTRAINT categorias_dispositivo_pkey PRIMARY KEY (id);


--
-- Name: categorias_producto categorias_producto_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.categorias_producto
    ADD CONSTRAINT categorias_producto_pkey PRIMARY KEY (id);


--
-- Name: clientes clientes_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (id);


--
-- Name: detalle_ventas detalle_ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_pkey PRIMARY KEY (id);


--
-- Name: deudas deudas_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.deudas
    ADD CONSTRAINT deudas_pkey PRIMARY KEY (id);


--
-- Name: dispositivos dispositivos_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_pkey PRIMARY KEY (id);


--
-- Name: inventario_productos inventario_productos_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_pkey PRIMARY KEY (id);


--
-- Name: inventario_productos inventario_productos_producto_id_key; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_producto_id_key UNIQUE (producto_id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: pagos_deuda pagos_deuda_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.pagos_deuda
    ADD CONSTRAINT pagos_deuda_pkey PRIMARY KEY (id);


--
-- Name: productos productos_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);


--
-- Name: renta_dispositivos renta_dispositivos_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.renta_dispositivos
    ADD CONSTRAINT renta_dispositivos_pkey PRIMARY KEY (id);


--
-- Name: rentas rentas_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_pkey PRIMARY KEY (id);


--
-- Name: roles roles_nombre_key; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_nombre_key UNIQUE (nombre);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: ventas ventas_pkey; Type: CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id);


--
-- Name: alertas alertas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.alertas
    ADD CONSTRAINT alertas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id) ON DELETE CASCADE;


--
-- Name: detalle_ventas detalle_ventas_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id);


--
-- Name: detalle_ventas detalle_ventas_venta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.detalle_ventas
    ADD CONSTRAINT detalle_ventas_venta_id_fkey FOREIGN KEY (venta_id) REFERENCES public.ventas(id) ON DELETE CASCADE;


--
-- Name: deudas deudas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.deudas
    ADD CONSTRAINT deudas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: dispositivos dispositivos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.dispositivos
    ADD CONSTRAINT dispositivos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias_dispositivo(id);


--
-- Name: inventario_productos inventario_productos_producto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.inventario_productos
    ADD CONSTRAINT inventario_productos_producto_id_fkey FOREIGN KEY (producto_id) REFERENCES public.productos(id) ON DELETE CASCADE;


--
-- Name: logs logs_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: pagos_deuda pagos_deuda_deuda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.pagos_deuda
    ADD CONSTRAINT pagos_deuda_deuda_id_fkey FOREIGN KEY (deuda_id) REFERENCES public.deudas(id) ON DELETE CASCADE;


--
-- Name: productos productos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES public.categorias_producto(id);


--
-- Name: renta_dispositivos renta_dispositivos_dispositivo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.renta_dispositivos
    ADD CONSTRAINT renta_dispositivos_dispositivo_id_fkey FOREIGN KEY (dispositivo_id) REFERENCES public.dispositivos(id);


--
-- Name: renta_dispositivos renta_dispositivos_renta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.renta_dispositivos
    ADD CONSTRAINT renta_dispositivos_renta_id_fkey FOREIGN KEY (renta_id) REFERENCES public.rentas(id) ON DELETE CASCADE;


--
-- Name: rentas rentas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: rentas rentas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.rentas
    ADD CONSTRAINT rentas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- Name: usuarios usuarios_rol_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_rol_id_fkey FOREIGN KEY (rol_id) REFERENCES public.roles(id);


--
-- Name: ventas ventas_cliente_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(id);


--
-- Name: ventas ventas_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ignacio
--

ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES public.usuarios(id);


--
-- PostgreSQL database dump complete
--

\unrestrict Zxb9KIHJc2XJRxoK48p1wdfPD4xthbda2EXSKf85tG2hmDdSUebicyaMq6tIq75

