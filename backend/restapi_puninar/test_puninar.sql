PGDMP                          z            test_puninar    14.2    14.2     ?           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ?           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            ?           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            ?           1262    16394    test_puninar    DATABASE     k   CREATE DATABASE test_puninar WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_Indonesia.932';
    DROP DATABASE test_puninar;
                postgres    false            ?            1259    16471    check_in_records    TABLE     ?   CREATE TABLE public.check_in_records (
    id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    datetime timestamp without time zone,
    imageurl character varying(255)
);
 $   DROP TABLE public.check_in_records;
       public         heap    postgres    false            ?            1259    16470    check_in_records_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.check_in_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE public.check_in_records_id_seq;
       public          postgres    false    210            ?           0    0    check_in_records_id_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE public.check_in_records_id_seq OWNED BY public.check_in_records.id;
          public          postgres    false    209            ?            1259    16478    check_out_records    TABLE     ?   CREATE TABLE public.check_out_records (
    id integer NOT NULL,
    latitude double precision,
    longitude double precision,
    datetime timestamp without time zone,
    imageurl character varying(255)
);
 %   DROP TABLE public.check_out_records;
       public         heap    postgres    false            ?            1259    16477    check_out_records_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.check_out_records_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.check_out_records_id_seq;
       public          postgres    false    212            ?           0    0    check_out_records_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.check_out_records_id_seq OWNED BY public.check_out_records.id;
          public          postgres    false    211            a           2604    16474    check_in_records id    DEFAULT     z   ALTER TABLE ONLY public.check_in_records ALTER COLUMN id SET DEFAULT nextval('public.check_in_records_id_seq'::regclass);
 B   ALTER TABLE public.check_in_records ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    209    210    210            b           2604    16481    check_out_records id    DEFAULT     |   ALTER TABLE ONLY public.check_out_records ALTER COLUMN id SET DEFAULT nextval('public.check_out_records_id_seq'::regclass);
 C   ALTER TABLE public.check_out_records ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    212    212            ?          0    16471    check_in_records 
   TABLE DATA           W   COPY public.check_in_records (id, latitude, longitude, datetime, imageurl) FROM stdin;
    public          postgres    false    210          ?          0    16478    check_out_records 
   TABLE DATA           X   COPY public.check_out_records (id, latitude, longitude, datetime, imageurl) FROM stdin;
    public          postgres    false    212   ?       ?           0    0    check_in_records_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.check_in_records_id_seq', 2, true);
          public          postgres    false    209            ?           0    0    check_out_records_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.check_out_records_id_seq', 2, true);
          public          postgres    false    211            d           2606    16476 &   check_in_records check_in_records_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.check_in_records
    ADD CONSTRAINT check_in_records_pkey PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.check_in_records DROP CONSTRAINT check_in_records_pkey;
       public            postgres    false    210            f           2606    16483 (   check_out_records check_out_records_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.check_out_records
    ADD CONSTRAINT check_out_records_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.check_out_records DROP CONSTRAINT check_out_records_pkey;
       public            postgres    false    212            ?   ?   x???R?0 k?
?.\?H?yc?W?$?@H??/Z??;K????s?qPH???!@?'??hdT=kM?Qk?Ʈ??Sb??????%?e?P?K??w??Ů|?N?w3?
?\%??&ߓM?gz[?{?'?0?|??&???4{??A?????=8&vh??,?k??c?i/5?񘼖Iޠ#?7'=?:M??wն?/aoJ?      ?   ?   x??KR?0 ?p
7??0L>$T?r?)?L̀<??^?????????dm7⤐<?8v?D??????g4j?&X?}?V?<????Uj?^E?9??p٪?????C??????vY??F???Zr?w?5٥>??v\???(6N?@?O`???KE8-,Ƒӣ??~2h??I?{Y_yo?C??/-?y[??89h??(?9E?E{?????U????J?     