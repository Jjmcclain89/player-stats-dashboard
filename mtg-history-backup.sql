--
-- PostgreSQL database dump
--

\restrict tXxCu5tWXIT1mAAzAdx4jYeEuXmvmhQycW3uNSIS6oSBIQdFsjrh2ERIDcdMYcL

-- Dumped from database version 16.10
-- Dumped by pg_dump version 16.10

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

--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_updated_at_column() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    date date NOT NULL,
    format character varying(50) NOT NULL
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: TABLE events; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.events IS 'Stores information about tournament events, keyed by JSON event_number';


--
-- Name: notable_qualifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.notable_qualifications (
    id integer NOT NULL,
    player_id integer NOT NULL,
    event_id integer NOT NULL
);


ALTER TABLE public.notable_qualifications OWNER TO postgres;

--
-- Name: notable_qualifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notable_qualifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notable_qualifications_id_seq OWNER TO postgres;

--
-- Name: notable_qualifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notable_qualifications_id_seq OWNED BY public.notable_qualifications.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: TABLE players; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.players IS 'Stores information about Magic: The Gathering players';


--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: results; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.results (
    id integer NOT NULL,
    player_id integer NOT NULL,
    event_id integer NOT NULL,
    day2 boolean DEFAULT false,
    top8 boolean DEFAULT false,
    limited_wins integer DEFAULT 0,
    limited_losses integer DEFAULT 0,
    limited_draws integer DEFAULT 0,
    num_drafts integer DEFAULT 0,
    positive_drafts integer DEFAULT 0,
    negative_drafts integer DEFAULT 0,
    trophy_drafts integer DEFAULT 0,
    no_win_drafts integer DEFAULT 0,
    constructed_wins integer DEFAULT 0,
    constructed_losses integer DEFAULT 0,
    constructed_draws integer DEFAULT 0,
    overall_wins integer DEFAULT 0,
    overall_losses integer DEFAULT 0,
    overall_draws integer DEFAULT 0,
    overall_record character varying(20) DEFAULT 0,
    day1_wins integer DEFAULT 0,
    day1_losses integer DEFAULT 0,
    day1_draws integer DEFAULT 0,
    day2_wins integer DEFAULT 0,
    day2_losses integer DEFAULT 0,
    day2_draws integer DEFAULT 0,
    day3_wins integer DEFAULT 0,
    day3_losses integer DEFAULT 0,
    day3_draws integer DEFAULT 0,
    in_contention boolean DEFAULT false,
    win_streak integer DEFAULT 0,
    loss_streak integer DEFAULT 0,
    streak5 integer DEFAULT 0,
    finish integer DEFAULT 0,
    summary character varying(500),
    team character varying(50),
    deck character varying(50),
    notes character varying(500)
);


ALTER TABLE public.results OWNER TO postgres;

--
-- Name: TABLE results; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE public.results IS 'Junction table linking players and events, storing tournament results and stats';


--
-- Name: results_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.results_id_seq OWNER TO postgres;

--
-- Name: results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.results_id_seq OWNED BY public.results.id;


--
-- Name: notable_qualifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notable_qualifications ALTER COLUMN id SET DEFAULT nextval('public.notable_qualifications_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: results id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results ALTER COLUMN id SET DEFAULT nextval('public.results_id_seq'::regclass);


--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, name, date, format) FROM stdin;
11	EOE	2025-09-28	Modern
13	ECL	2026-01-30	Standard
12	WC31	2025-12-05	Standard
14	SOS	2026-05-01	Standard
4	WC29	2023-09-25	Standard
8	WC30	2024-10-28	Standard
1	Phyrexia	2023-02-19	Pioneer
9	DFT	2025-02-21	Standard
3	LOTR	2023-07-30	Modern
5	MKM	2024-02-26	Pioneer
6	OTJ	2024-04-29	Standard
7	MH3	2024-06-30	Modern
2	MOM	2023-05-05	Standard
10	FF	2025-06-20	Standard
\.


--
-- Data for Name: notable_qualifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notable_qualifications (id, player_id, event_id) FROM stdin;
14	1214	12
15	18	12
16	23	12
17	1048	12
18	1300	12
20	77	12
21	82	12
22	94	12
24	99	12
25	101	12
26	121	12
28	132	12
29	138	12
30	1245	12
31	162	12
33	1220	12
34	182	12
35	186	12
36	188	12
38	200	12
39	202	12
40	215	12
41	217	12
42	220	12
43	221	12
44	226	12
45	228	12
46	1047	12
47	261	12
50	282	12
51	291	12
52	1182	12
53	299	12
54	329	12
55	341	12
56	349	12
57	365	12
58	1302	12
59	1106	12
60	1215	12
61	394	12
62	1187	12
63	398	12
64	401	12
65	406	12
66	447	12
67	448	12
68	449	12
69	451	12
70	468	12
71	476	12
72	1087	12
73	490	12
74	1337	12
75	502	12
76	507	12
77	1280	12
78	525	12
79	1194	12
80	1090	12
81	1206	12
82	543	12
83	545	12
84	565	12
85	569	12
86	575	12
87	588	12
88	1305	12
90	1313	12
91	1060	12
92	633	12
93	643	12
94	1279	12
95	661	12
96	667	12
97	668	12
98	669	12
99	679	12
101	684	12
102	1216	12
103	691	12
104	1251	12
105	711	12
106	723	12
107	728	12
108	732	12
109	1213	12
110	743	12
111	765	12
112	769	12
113	780	12
114	1107	12
116	1046	12
117	809	12
118	811	12
119	816	12
120	818	12
121	1084	12
122	830	12
124	832	12
125	1226	12
126	1201	12
128	890	12
129	903	12
130	929	12
131	931	12
132	935	12
133	937	12
134	1256	12
136	1002	12
137	1008	12
138	1019	12
139	1031	12
140	1036	12
141	1037	12
32	165	12
100	562	12
127	1119	12
27	123	12
48	1277	12
49	1273	12
115	785	12
123	831	12
142	1350	13
143	1351	13
144	1352	13
145	18	13
146	1353	13
147	1234	13
148	1048	13
149	1354	13
150	39	13
151	1355	13
152	1356	13
153	48	13
154	1357	13
155	1358	13
156	1359	13
157	1360	13
158	1165	13
159	1361	13
160	1181	13
161	77	13
162	82	13
163	1203	13
164	1362	13
165	1363	13
166	1364	13
167	1365	13
168	99	13
169	103	13
170	109	13
171	1366	13
172	132	13
173	1052	13
174	1089	13
175	1367	13
176	1368	13
177	1297	13
178	147	13
179	1369	13
180	1370	13
181	1371	13
182	1372	13
183	1373	13
184	1374	13
185	1375	13
186	162	13
187	1224	13
188	1220	13
189	171	13
190	1376	13
191	1377	13
192	1378	13
193	1061	13
194	182	13
195	188	13
196	189	13
197	1379	13
135	1341	12
37	1445	12
19	1346	12
198	196	13
199	1188	13
200	200	13
201	202	13
202	204	13
203	1232	13
204	207	13
205	212	13
206	215	13
207	1380	13
208	217	13
209	220	13
210	221	13
211	1381	13
212	1221	13
213	226	13
214	228	13
215	1263	13
216	1382	13
217	234	13
218	238	13
219	239	13
220	247	13
221	1068	13
222	258	13
223	1235	13
224	1047	13
225	261	13
226	1383	13
227	1384	13
228	1385	13
229	269	13
230	1386	13
231	274	13
232	1277	13
233	1387	13
234	1388	13
235	282	13
236	1217	13
237	291	13
238	1389	13
239	1390	13
240	1391	13
241	1392	13
242	1078	13
243	1050	13
244	310	13
245	312	13
246	1325	13
247	318	13
249	329	13
250	332	13
251	1394	13
252	346	13
253	347	13
254	349	13
255	351	13
256	1062	13
257	1395	13
258	364	13
259	365	13
260	1396	13
261	1397	13
262	1106	13
263	1215	13
264	383	13
265	1398	13
266	394	13
267	398	13
268	401	13
269	403	13
270	406	13
271	1399	13
272	1400	13
273	423	13
274	1401	13
275	439	13
276	1402	13
277	447	13
278	448	13
279	451	13
280	1403	13
281	457	13
282	1404	13
283	1405	13
284	465	13
285	1406	13
286	468	13
287	1407	13
288	476	13
289	477	13
290	1408	13
291	1409	13
292	502	13
293	1410	13
294	1411	13
295	513	13
296	1412	13
297	1413	13
298	1414	13
299	1415	13
300	516	13
301	1416	13
302	529	13
303	1056	13
304	1417	13
305	1418	13
306	1306	13
307	545	13
308	1419	13
309	1420	13
310	1309	13
311	562	13
312	1421	13
313	565	13
314	567	13
315	569	13
316	570	13
317	575	13
318	1422	13
319	1423	13
320	588	13
321	589	13
323	1425	13
324	598	13
325	605	13
326	1426	13
327	1427	13
328	1428	13
329	1231	13
330	1429	13
331	1096	13
332	1227	13
333	1060	13
334	1430	13
335	1431	13
336	1432	13
337	643	13
338	644	13
339	1433	13
340	1434	13
341	1222	13
342	650	13
343	1435	13
344	657	13
345	661	13
346	666	13
347	667	13
348	668	13
349	669	13
350	1436	13
351	1437	13
352	1438	13
353	678	13
354	679	13
355	684	13
356	1049	13
357	1216	13
358	691	13
359	1439	13
360	706	13
361	1440	13
362	711	13
363	1441	13
364	1229	13
365	717	13
366	723	13
367	1442	13
368	1443	13
369	732	13
370	733	13
371	1444	13
372	1445	13
373	1057	13
374	743	13
375	744	13
376	754	13
377	1446	13
379	755	13
380	761	13
381	765	13
382	769	13
378	151	13
383	1225	13
384	1448	13
385	1449	13
386	1450	13
387	1451	13
388	776	13
389	780	13
390	1452	13
391	785	13
392	1046	13
393	792	13
394	794	13
395	1453	13
396	1454	13
397	1233	13
398	1455	13
399	1456	13
400	1457	13
401	1219	13
402	1458	13
403	809	13
404	811	13
405	813	13
406	816	13
407	1084	13
408	830	13
409	1459	13
410	831	13
411	1460	13
412	430	13
413	1461	13
414	1462	13
415	1463	13
416	1464	13
417	1465	13
418	1466	13
419	1201	13
420	1467	13
422	876	13
423	877	13
424	1119	13
425	1230	13
426	882	13
427	1254	13
428	884	13
429	885	13
430	890	13
431	1469	13
432	1470	13
434	1472	13
436	903	13
437	1474	13
438	920	13
439	1475	13
440	1476	13
441	933	13
442	1071	13
443	935	13
444	1477	13
445	937	13
446	1223	13
447	947	13
448	1478	13
449	1479	13
450	1480	13
451	1481	13
452	1482	13
454	1301	13
455	1484	13
456	988	13
457	1485	13
458	993	13
459	998	13
460	1002	13
461	1007	13
462	1008	13
463	1009	13
464	1259	13
465	1156	13
466	1019	13
467	1020	13
468	1486	13
469	1487	13
470	1488	13
471	1489	13
472	1031	13
473	1034	13
474	1490	13
475	1036	13
476	1039	13
477	1491	13
478	592	13
480	328	13
421	875	13
433	897	13
435	1110	13
453	1111	13
481	1508	14
482	1509	14
483	1510	14
484	18	14
485	1511	14
486	1512	14
487	1234	14
488	1048	14
489	1513	14
490	45	14
491	1514	14
492	1356	14
493	48	14
494	1359	14
495	1515	14
496	1516	14
497	1165	14
498	1517	14
499	72	14
500	1181	14
501	1518	14
502	82	14
503	1134	14
504	1365	14
505	99	14
506	101	14
507	1519	14
508	107	14
509	109	14
510	1520	14
511	125	14
512	1521	14
513	132	14
514	1052	14
515	1522	14
516	1368	14
517	1523	14
518	1524	14
519	1525	14
520	154	14
521	162	14
522	165	14
523	1526	14
524	1220	14
525	1527	14
526	1528	14
527	1377	14
528	1529	14
529	1530	14
530	1378	14
531	182	14
532	1531	14
533	188	14
534	1532	14
535	200	14
536	202	14
537	204	14
538	1232	14
539	215	14
540	1533	14
541	217	14
542	221	14
543	1500	14
544	1534	14
545	226	14
546	228	14
547	238	14
548	239	14
549	1535	14
550	247	14
551	248	14
552	1536	14
553	260	14
554	1047	14
555	1537	14
556	261	14
557	1086	14
558	1538	14
559	1385	14
560	269	14
561	1539	14
562	1277	14
563	1540	14
564	1541	14
565	1388	14
566	282	14
567	1542	14
568	1543	14
569	288	14
570	1217	14
571	291	14
572	1544	14
573	1545	14
574	1390	14
575	1050	14
576	312	14
578	329	14
579	341	14
580	1547	14
581	1548	14
582	1549	14
583	347	14
584	1550	14
585	1551	14
586	1062	14
587	1552	14
588	364	14
589	365	14
590	1553	14
591	1554	14
592	1555	14
593	1556	14
594	1106	14
595	1557	14
596	1215	14
597	385	14
598	1558	14
599	1559	14
600	1560	14
601	1202	14
602	394	14
603	398	14
604	403	14
605	406	14
606	1561	14
607	1399	14
608	414	14
609	1562	14
610	1563	14
611	1564	14
612	421	14
613	423	14
614	426	14
615	433	14
616	1565	14
617	1099	14
618	1402	14
619	447	14
620	448	14
621	451	14
622	457	14
623	1566	14
624	1567	14
625	466	14
626	1406	14
627	468	14
628	1568	14
629	1407	14
630	1569	14
631	1570	14
632	484	14
633	1571	14
634	1085	14
636	1573	14
637	1228	14
638	1410	14
639	1574	14
640	513	14
641	1413	14
642	516	14
643	1575	14
644	523	14
646	1416	14
647	1056	14
648	539	14
649	545	14
650	549	14
651	1576	14
652	1577	14
653	1309	14
654	562	14
655	567	14
656	569	14
657	575	14
658	1578	14
659	1422	14
660	1423	14
661	587	14
662	588	14
663	1425	14
664	1316	14
665	600	14
666	601	14
667	605	14
669	1096	14
670	1580	14
671	1227	14
672	1581	14
673	1432	14
674	1582	14
675	1583	14
676	643	14
677	1584	14
678	1222	14
679	650	14
680	661	14
681	663	14
682	667	14
683	668	14
684	1585	14
685	1586	14
686	1587	14
687	1588	14
688	678	14
689	679	14
690	684	14
691	1589	14
692	1189	14
693	1590	14
694	1049	14
695	1216	14
696	1591	14
697	1592	14
698	1593	14
699	700	14
700	1594	14
701	1595	14
702	1596	14
703	704	14
704	706	14
705	711	14
706	1441	14
707	717	14
708	723	14
709	1597	14
710	1598	14
711	735	14
712	1599	14
713	1445	14
714	1057	14
715	743	14
716	744	14
717	1600	14
718	1601	14
719	1602	14
721	765	14
722	1604	14
723	767	14
724	769	14
725	1225	14
726	1605	14
727	1451	14
728	779	14
729	780	14
730	1133	14
731	785	14
732	1606	14
733	1046	14
734	792	14
735	1453	14
736	1607	14
737	1608	14
738	1456	14
739	1219	14
740	809	14
741	1609	14
742	811	14
743	1074	14
744	816	14
745	1610	14
746	1084	14
747	830	14
748	1459	14
749	831	14
750	1611	14
751	1612	14
752	1613	14
753	1063	14
754	1226	14
755	850	14
756	851	14
757	1614	14
758	1615	14
759	1465	14
760	1466	14
761	876	14
762	1616	14
764	1617	14
765	1618	14
766	1619	14
767	1620	14
768	882	14
769	885	14
770	1621	14
771	893	14
772	1622	14
773	1623	14
774	1110	14
775	903	14
776	912	14
777	1624	14
778	920	14
779	1475	14
780	1625	14
781	1626	14
782	935	14
783	937	14
784	939	14
785	1627	14
786	1223	14
787	1628	14
788	947	14
789	1481	14
790	1629	14
791	1630	14
792	1631	14
793	973	14
794	1632	14
795	1502	14
796	1633	14
797	988	14
798	1634	14
799	993	14
800	998	14
801	1002	14
802	1007	14
803	1008	14
804	1009	14
805	1013	14
806	1289	14
807	1635	14
808	1636	14
809	1637	14
811	1019	14
812	1639	14
813	1640	14
814	1030	14
815	1641	14
816	1031	14
817	1642	14
819	1644	14
820	1037	14
821	1645	14
822	1039	14
823	1646	14
824	499	14
826	1018	14
828	621	14
829	1036	14
830	1119	14
831	525	14
832	320	14
833	295	14
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, first_name, last_name) FROM stdin;
1214	Mikko	Airaksinen
1215	Makoto	Horiuchi
1216	Noé	Offman
1217	Sergio	Garcia
1219	Luis	Salvatto
1220	Matthew	Costa
1221	Kenith	D'souza
1222	Collins	Mullen
1223	Cyprien	Tron
1224	Dean	Convery
1225	Maxime	Rayvich
1226	Akira	Shibata
1227	Jacob	Mitchell-Rabaey
1228	Masashiro	Kuroda
1229	Tariq	Patel
1230	Ian	Starkebaum
1231	Henry	Mildenstein
1232	Davor	Detecnik
1233	Sebastian	Sachse
1234	Huaxing	Bai
1235	Marco	Fabrizi
1236	Felippe	Rossello
1238	John	Shindledecker
1239	Zach	Aymie
1240	Lane	Siems
1241	Adrian	Kacperczyk-Perdyan
1242	Paul	Tsao
1243	Gabriele	Vasarri
1244	Keita	Tonouchi
1245	Clement	Choo
1246	Andrew	Jessup
1247	Francesco	Ruvolo
1248	Shi	Yang
1249	Hyuma	Nishi
1250	Benjamin	Graves
1251	Fernando	Palmero García
1252	Jerry	Gao
1253	Xander	Naumenko
1254	Steve	Stillman
1255	Thomas	Sardanelli
1256	Ryan	Waligora
1257	Cristian	Rodríguez
1258	Ittai	Waterson
1259	Tatsuaki	Yajima
1260	Marc	Gargallo
1261	Naoya	Ozawa
1262	Javier	Del Pino Povedano
1263	Jacob	Durish
1264	Perry	Feng
1265	Ryan	Donkin
1266	Makoto	Atsuji
1267	Šarūnas	Liobikas
1268	Forrest	Wang
1269	Wu	Jia
1270	Joe	Leo
1271	Sam	Lewin
1272	Caz	Rodriguez
1273	Mario	Flores
1274	Jacques	van Eeden
1275	Sébastien	Lachance
1276	Sun	Chuan
1277	Pedro	Flores
1278	Hidde	van 't Verlaat
1279	Yasutaka	Nagao
1280	Ivan	Lausevic
1281	Kazuya	Hirabayashi
1282	Maximilian	Höglund
1283	Chris	Song
1284	Koby	Keller
1285	Hunter	Ovington
1286	Justin	Parente
1287	Michał	Lewicki
1288	Carlo	Tummolillo
1289	Matt	Xu
1291	Fernando	Domínguez
1292	Hanbin	Zhou
1293	Chas	Hinkle
1294	Jared	Mazzant
1295	Tyler	Stechman
1296	Calvin	Chen
1297	Justin	Cheung
1298	Trevor	Georgesz
1299	Shoji	Kimura
1300	Jelco	Bodewes
1301	Jennifer	Wang
1302	Jennifer-Rose	Holloway
1303	Eduardo	Dos Santos Vieira
1304	Alex	Bianchi
1305	Raffaele	Mazza
1306	Lucca	LiPuma
1307	André	Faustino
1308	Daniel	Spiegel
1309	Guglielmo	Lupi
1310	Daniel	Staup
1311	Poyuan	Tsao
1312	Félix	Vincent Ardea
1313	Casey	Miller
1314	Adam	Bubar
1315	Wesley	Hickman
1316	Gavin	Meagher
1317	Geoff	Mullin
1318	Ellango	Jothimurugesan
1319	Matt	Carwen
1320	Marco	Vay
1321	Thomas	Chenery
1322	Joan	García Esquerdo
1323	Amber	Thurlow
1324	Andrew	Bailey
1325	Nathan	Goldberg
1326	Mu Ru	Kuo
1327	Jayson	Babin
1328	Lauri	Törnström
1329	Jordan	Poirier
1330	Garrett	Bryan
1331	Sebastian	Kreimendahl
1332	Kieren	Digpal
1333	Burke	Methena
1337	Julian	Korfine
1341	Kunrui	Wang
61	Michael	Bernat
1346	Tom	Bot
1350	David	Åberg
1351	Mary	Amora
1352	Tristan	Anderson
1353	Artem	Arepin
1354	Ian	Barber
1355	Maciej	Barwik
1356	Julio	Bejarano
1357	Ryan	Bellamy
1358	Gavin	Bennett
1359	Denis	Beqiri
1360	Bodie	Bice
1361	Camari	Bolger
1362	Raimundo	Bravo
1363	Wesley	Brito
1364	Steven	Browne
1365	Ryan	Brozovich
1366	Keith	Capstick
1367	Hamail	Cheema
1368	Xinrong	Chen
1369	Jeongwoo	Cho
1370	Nick	Chow
1371	Oscar	Christensen
1372	Gabriel	Clark
1373	Sam	Clayton
1374	Victor	Cochran
1375	Alfonso	Concha
1376	Nick	Cowden
1377	Matheus	Crusius
1378	Xiangjun	Dai
1379	Nicolas	De prada
1380	Alessandro	Dolce
1381	James	Drake
1382	Greg	Dyer
1383	Alessio	Fedi
1384	José Manuel	Fernández
1385	Álvaro	Fernández Torres
1386	Vinnie	Fino
1387	Isaac	Fox
1388	Mae	French
1389	Leo	Gartner
1390	Haven	Gilbert-Avila
1391	Alexander	Gimenez
1392	Aleksa	Glišović
1394	Ryo	Hakoda
1395	Julian	Hecker
1396	Robert	Heredia
1397	Gage	Hergert
1398	Jeff	Howell
1399	Valerie	Jade
1400	Yuanqin	Ji
1401	Reed	Johnston
1402	Matyáš	Kalužný
1403	Ben	Katz
1404	Tyler	Kelly
1405	Omri	Khaykovich
1406	Atsuki	Kihara
1407	Nathan	Kirner
1408	Sangjoon	Kong
1409	Louis	Kray
1410	Etai	Kurtzman
1411	Jacob	Lamothe
1412	Nikolin	Lasku
1413	Benji	Leaf
1414	Noe	Leal, Jr.
1415	Tristan	Lebon
1416	Avi	Lessure
1417	Pierre	Liebsch
1418	Cheng Han	Lin
1419	Samuel	Loy
1420	Ruben	Luna
1421	Alex	MacIsaac
1422	Adrià	Martín
1423	Carlos	Martinez
1425	Spencer	Mazur
1426	Roope	Metsä
1427	Ivan	Meyer
1428	Gabriel	Michaels
1429	Daniel	Miller
1430	JJ	Moffitt
1431	Max	Molesch
1432	Alejandro	Mora
1433	Josh	Moscoe
1434	Julio	Moser
1435	Shinichi	Nagai
1436	James	Newman
1437	Emmett	Neyman
1438	Joe	Nguyen
1439	Max	Outh-Aut
1440	Daniel	Padilla Alfaro
1441	Kellen	Pastore
1442	Anthoane	Perry
1443	Reese	Pfenning
1444	Davide	Pizzutilo
1445	Michael	Plummer
1446	Sibby	Pugliese
1448	Josue	Rebollo
1449	Ferran	Relat
1450	Remington	Rice
1451	Julian	Riedener
1452	Matthew	Robinson
1453	Brennan	Roy
1454	Pasquale	Ruggiero
1455	Raymond	Sainz
1456	Eduardo	Sajgalik
1457	João Jorge	Sales Junior
1458	Jessy	Samek
1459	Coby	Schnepf
1460	Trevor	Sharp
1461	Alison	Silva
1462	Michael	Simonetti
1463	Martin	Sistig
1464	Cristofer	Smith
1465	Petr	Sochůrek
1466	Evan	Sonnenberg-Rhim
1467	Filipe	Sousa
1469	Andrew	Sullano
1470	Hongbin	Sun
1472	Kantaro	Takano
1474	Connor	Taylor
1475	Sebastian	Thaler
1476	Liam	Tiller-Collins
1477	Jay	Toraty
1478	Owen	Turcotte
1479	Chris	Turnbull
1480	Markus	Valori
1481	Jay	van der Heiden
1482	Federico	Velasco
1484	Adam	Wasburn-Moses
1485	Haoran	Wen
1486	Peter	Yeh
1487	Yuta	Yokokawa
1488	Hojun	Yoon
1489	Ronald	Yu
1490	Ethan	Zhang
1491	Yutong	Zou
470	Jin	Kim
328	Nate	Green
1648	Alex	von Stange
1649	Albert	Queralt Garriga
1650	Samuel	Pardee
1651	Antonin	Branis
1652	Alvaro	Fernandez Torres
1653	Carlos	Martínez
1110	Nick	Talbot
1500	Kenith	Dsouza
1501	Raphael	Levy
1502	Rob	Wagner-Krankel
1504	Theo	Jung
1505	Gabriel	Maxson
1508	Junichi	Adachi
1509	January	Adams
1510	Aaron	Angeles
1511	David	Åstrand
1512	William	Au
1513	Edgar	Baumler
1514	Jon	Beitler
1515	George	Berrett
1516	Timo	Bertram
1517	Timothée	Blondiaux
1518	Mike	Boulinguiez
1519	Mike	Byrd
1520	Isabel	Castillo
1521	Winston	Chamora
1522	Arrick	Chaulk
1523	Yang	Chen
1524	Sajan	Cherukad
1525	Vincent	Choy
1526	Nicolas	Cosgrove
1527	Robin	Courtiat
1528	Brian	Coval
1529	Anthony	Cuello
1530	Andrew	Cuneo
1531	Aylin	Davis
1532	Carlo	De Gaetano
1533	Shawn	Doherty
1534	Eleanor	Dubreuil
1535	Terry	Edwards
1536	Neil	Estrada
1537	Noé	Fauquenoi
1538	Hao	Feng
1539	Nico	Ferrigno
1540	Zach	Flynn
1541	Elliot	Fortier
1542	Paul	Gabat
1543	Gregorio	Galeotti
1544	Ryan	Gassaway
1545	Kyle	Gibson
1547	Wappa	Hamada
1548	Masakuni	Hamaguchi
1549	Shinnosuke	Hando
1550	Clément	Harvey
1551	Takuya	Hasegawa
1552	Yang	He
1553	Elijah	Herr
1554	Evan	Higgins
1555	Ethan	Hollen
1556	Jude	Hopkins
1557	Yuta	Hori
1558	Manato	Hosomi
1559	Brendan	Hsu
1560	Nathan	Hu
1561	Mauricio	Iriarte
1562	Amy	James
1563	Jeff	Jao
1564	Maciej	Jezyna
1565	Ryan	Jonns Lewis
1566	David	Kerrigan
1567	Se̍k-un	Khó͘
1568	Adam	Kinnaird
1569	Jake	Koenig
1570	Brandon	Kohrs
1571	Kevin	Kong
1573	Prez	Kuhnke
1574	Curtis	Lam
1575	Rick Hup Beng	Lee
1576	Jorge	Lopez
1577	Ding	Luo
1578	Rafael	Marin
1580	Ryouta	Mishina
1581	Pedro	Molina
1582	Nicolás	Morales Macaya
1583	Vasilios	Morikis
1584	Pier Paolo	Moro
1585	Richard	Nealston
1586	Kye	Nelson
1587	Hei Wo, Johnathan	Ng
1588	Truong Hai	Nguyen
1589	Allen	Norman
1590	Allan	Oca
1591	Atsuya	Okuno
1592	Pietro Maria	Oltolina
1593	Kenji	Onoda
1594	Valentin	Orru
1595	Nick	Osterude
1596	Kenny	Oswald
1597	Gavin	Perry
1598	Guillaume	Petri
1599	Klemen	Pirc
1600	Dylan	Pratt
1601	Jason	Qiu
1602	Joao	Quege
1604	Javier	Ramos
1605	Jason	Reid
1606	Patricio	Roman
1607	Tyson	Roylance
1608	Ivan	Saenz
1609	Vinicio	Sanchez Delgado
1610	Josh	Saruga
1611	Lukas	Schwendinger
1612	Sophi	Seley
1613	Aras	Senyuz
1614	Aedan	Simons-Rudolph
1615	Pierre	Smith
1616	Jonny	Stange
1617	Alejandro	Stefanino
1618	Matthew	Stefansson
1619	Tyler	Steinwand
1620	Elad	Stettner
1621	Miitri	Suorsa
1622	Piotr	Szyiński
1623	Kazuya	Takuwa
1624	Gavin	Teo
1625	Claire	Tian
1626	Oliver	Tomajko
1627	Klarke	Trezise
1628	Mark	Tubola
1629	Luis	Venegas
1630	Gaétan	Verdierre
1631	Evan	Vetter
1632	John	Wager
1633	Austin	Walker
1634	Daniel	Weiss
1635	Yoshitaka	Yamasaki
1636	Kazuki	Yamashita
1637	Enhui	Yang
1639	Jack	Young
1640	Michael NK	Young
1641	Jack	Yudt
1642	Neilson	Zhang
1644	Wentong	Zhang
1645	Chang	Zheng
1646	Ben	Zoz
561	Ben	Lundquist
819	Rei	Sato
572	Sol	Malka
577	Gennaro	Mango
681	Richard	Nixon III
151	John	Puglisi Clark
62	Riccardo	Biava
63	Nicolas	Biekert
64	Santiago	Bigatti
65	Han	Bing
66	Luca	Biondi
67	Ian	Birrell
68	Zacharia	Bishop
69	Nathan	Blackmon
70	Derek	Blaiotta
71	Marc	Blesso
72	Sam	Bogue
73	Nico	Bohny
74	Matthew	Bond
75	Nicolas	Borgel
76	Brian	Boss
77	Chris	Botelho
78	Eliott	Boussaud
79	Lawrence	Bouzane
80	Cliff	Boyardee
81	Adam	Boyd
82	Adam	Brace
83	Max	Bracken
84	Christopher	Brackley
85	Josh	Bradbury
86	Helena	Brake
87	Joey	Brautigam
88	Dan	Bretherton
89	Martin	Breuninger
90	Ben	Broadstone
91	Daniel	Brodie
92	Jake	Browne
93	Damian	Buckley
94	Kai	Budde
95	Albert	Budisanjaya
97	Jesus	Buenrostro
98	Isaac	Bullwinkle
99	Mason	Buonadonna
100	Autumn	Burchett
101	Corey	Burkhart
102	Austin	Bursavich
103	Heathe	Butler
104	Giona	Cai
105	Jared	Calabrese
106	Deane	Calcagni
107	Christian	Calcano
108	Adan	Calzada
109	Marco	Cammilluzzi
110	Rubens	Campana
111	Fabrizio	Campanino
112	Davide ivano	Canonico
113	Tin Mihael	Capar
114	Simone	Caputi
115	Simon	Carisse
116	Chris	Carlile
117	Nick	Carlson
118	Jeff	Carr
119	Malcolm	Carr
120	Michele	Carretta
121	Marcio	Carvalho
122	Vagner	Casatti
123	Javier	Castellán
124	Miguel	Castro
125	Marcelo	Cavalcante
126	Alessandro	Cecconi
127	Eduardo	Cesar
128	Amaz	Chan
129	Pok Man	Chan
130	Sze-Hang	Chan
131	Cheng Yu	Chang
132	Samuel	Chang
133	Robin	Chemnitz
134	Bor Hong	Chen
135	HongXuan	Chen
136	Jeffrey	Chen
137	Mingyang	Chen
138	Szu-Yuan	Chen
139	Yiwen	Chen
140	Newton	Cheng
141	Yu Chiao	Cheng
142	Kelvin	Chew
143	Jeff	Chiang
144	Kotarou	Chiku
145	Justin	Chin
146	Kousuke	Chinen
147	Marvin	Chiong
148	Jaeseok	Cho
149	Paolo	Ciani
150	Mike	Cieszinski
152	Mason	Clark
153	Slater	Claudel
154	Oliver	Coffey
155	Brendan	Cohen
156	Damian	Cohen
157	Federico	Colaianni
158	Jesse	Colford
159	Sean	Collins
160	Agustin	Colombo
161	Alan	Comer
162	Ryan	Condon
163	Jack	Contencin
164	Harry	Cook
165	Albert	Cordobés
166	Kamiel	Cornelissen
167	Renan	Correa
168	Abe	Corrigan
169	Simone	Corsi
171	Dawson	Courson
172	Chris	Cousens
173	Chandler	Cox
174	Brennan	Crawford
175	Paolo	Crispino
176	Joseph	Cruz
177	Cole	Cunningham
178	Gerardo	D'Elia
179	Ricardo	Da Silva
181	Alessandro	Danesi
182	Nam	Dang
183	Chris	Danis
184	Manuel	Danninger
185	Jonathan	Danz
186	Julian	David
187	Violet	Davies
188	Derrick	Davis
189	Jim	Davis
190	Shawn	Davis
191	Alvaro	de Almeida
192	Willy	De Almeida Le Coq
193	Bruno Oliva	de Paula
196	Drew	Debevoise
197	Brennan	DeCandio
198	Marco	Dei Lazzaretti
199	Federico	Del Basso
200	Marco	Del Pivo
201	Eton	Delmoro
202	Jean-Emmanuel	Depraz
203	Luke	Deratzou
204	Nick	Deriu
205	Jonathan	Dery
206	Tony	Desangles
207	Matt	Dewitte
208	Serhiy	Deymundt
209	Shawn	Dhaliwal
210	Kiran	Dhokia
211	Stefano	di Fiore
212	Jacopo	Di Napoli
214	Ricardo	Dias
215	James	Dimitrov
216	Joe	Dixon
217	Javier	Dominguez
218	Martin	Dominguez
220	Max	Dore
221	Arch	Dota
222	Jack	Doucet
223	Andrew	Drake
224	Gerardo	Duarte
225	Nicole	Dubin
226	Lucas	Duchow
227	David	Dufour
228	Reid	Duke
229	David	Dunham
230	David	Dunitza
231	Mason	Dutcher
232	Daniel	Duterte
233	Stephen	Dykman
234	Luna	Eason
235	Amin	Ebady
236	Samuel	Eberhard
237	Keisuke	Ebitani
238	Willy	Edel
239	Adam	Edelson
240	Etienne	Eggenschwiler
242	Kouta	Ehara
243	Tobi	Ehrismann
244	Charles	Eiler
245	Per	Ekström
246	Berk	Elçi
247	Andrew	Elenbogen
248	Charles	Eliatamby
249	Joonas	Eloranta
250	Darrin	Emerson
251	Mack	Endress
252	Thomas	Enevoldsen
253	Hampus	Eriksson
254	Dimitar	Erinin
255	Ivan	Errico
256	Josue	Escalante
257	Samuele	Estratti
258	Liam	Etelson
259	Marco 	Fabrizi
260	Julius	Fan
261	Zevin	Faust
262	Javier	Faustino
263	Gabriel	Fehr
264	Yang	Feng
265	Chris	Ferber
266	Andy	Ferguson
267	Patrick	Fernandes
268	Marcos	Ferreira
269	Mateo	Ferreira
270	Matthew	Fileccia
271	Jon	Finkel
272	Leo	Finnveden
273	Francesco	Fiorenzoni
274	Derek	Flores
275	Jo	Florman
276	Matt	Foreman
277	Daniel	Fournier
278	Colten	Fowler
279	Pier	Franchini
280	Marcy	Franta
281	Cyril	Frey
282	Alex	Friedrichsen
283	David	Frischer
284	Yuta	Funabashi
285	Attila	Fur
286	Sean	Gallagher
287	Rodrigo	Gallegos-Molano
288	Steve	Gan
289	Sergio	Garcia Jimenez
290	Fabian	Garcia Steinhardt
291	Andy	Garcia-Romo
292	Lance	Garden
293	Philippe	Gareau
294	Camden	Garofalo
295	Albert Queralt	Garriga
296	Cesar	Garza
297	James	Gates
213	Mattia	di Pierno
219	Mark	Donaldson
194	Keayn	De Vries-Turnell
241	Mike	Egolf
298	Kyle	Gellert
300	Emanuele	Giordano
301	Nick	Girardi
302	Francesco	Giresi
303	Brett	Girvan
304	Sameul	Giselsson
305	Matthew	Giudes
306	London	Glenn
307	Tamas	Glied
308	Piotr	Glogowski
309	Michael	Go
310	Sean	Goddard
311	Juan Ignacio	Godoy
312	Daniel	Goetschel
313	Omri	Goldenberg
314	Zev	Goldhaber-Gordon
316	Carlos	Gomez
317	Kyle	Gonzales
318	David	González
319	Pedro	Gonzalez
321	Dan	Goresht
322	Jitse	Goutbeek
323	Jean-Philippe	Goyet
324	Thales Zaniti	Grande
325	Bobby	Graves
326	Eric	Gray
327	Christian	Greciano
329	Paul	Green
330	Michael	Greenberg
331	Peter	Greig
332	Simon	Greir
333	Joel	Griebel
334	Lorenzo	Gruppi
335	T.J.	Gullo
336	Thomas	Gunn
337	Carlos Oliveros	Guntin
338	Xiaoyu	Guo
339	Luis	Gutierrez
340	Marlon Jacob Avila	Gutierrez
341	Jonny	Guttman
342	Antonio	Guzman
343	Andrew	Hakenewerth
344	Daniel	Hall
345	John Ryan	Hamilton
346	Jesse	Hampton
347	Koki	Hara
349	Kenta	Harane
350	Shawn	Harris
351	Dom	Harvey
352	Kazuhiko	Hasegawa
353	Shouichi	Hasegawa
354	Hayato	Hashizume
355	Tyler	Hatchel
356	Jacob	Hauch
357	Ryan	Hayes
358	Alexander	Hayne
360	Chung Wye	Hee
361	Chris	Henderson
362	Chye Hwee	Heng
363	Lars	Henrichvark
364	Julien	Henry
365	Shaun	Henry
366	Fran	Hergueta
367	Evan	Heritage
368	Adam	Hernandez
369	Jesus	Hernandez
370	Jacob	Heybl
371	Jose	Hilario
372	Justin	Hinz
373	Tomonori	Hirami
374	Rei	Hirayama
375	Steven	Hitchcock
376	Chih-Mao	Ho
377	Liam	Hoban
378	Jonathan	Hobbs
379	Bryan	Hohns
380	Andreas	Holmqvist
381	Lukas	Honnay
382	Kelvin	Hoon
383	Masaya	Hoshino
384	Yohei	Hoshino
385	Yuya	Hosokawa
386	Adrien	Houssard
387	Martin	Hrycej
388	Shu-Yu	Hsueh
389	Yung-Ming	Huang
390	Conor	Hughes
391	Tim	Hughes
392	Noah	Huizinga
393	Phill	Hurst
394	Arne	Huschenbeth
395	Tal	Hutson
396	Matthew	Hyndman
397	Chris	Iaali
398	Yuuki	Ichikawa
400	Rodrigo Iglesias	Iglesias
401	Yoshihiko	Ikawa
402	Hidenari	Ikeda
403	David	Inglis
404	Adrián	Iñigo Tastet
405	Naoto	Inoue
406	Toru	Inoue
407	Takashi	Inui
408	Kouichi	Ishiwata
409	Hristiyan	Ivanov
410	Ryota	Iwaki
411	Kento	Izumi
412	Michael	Jacob
413	Théo	Jacques-Griffin
414	Lukas	Jaklovsky
415	Julian	Jakobovits
416	Tulio	Jaudy
417	Brad	Javner
418	Adam	Jazwinski
419	Colin	Jenkins
420	Benjamin	Jeschke
421	Zihao	Ji
423	Yiren	Jiang
424	Hongchen	Jiao
425	Tomas	Jirkal
426	Gabriel	Joglar
427	Ashlen	Johnson
428	Brendon	Johnson
359	Chun	He
429	Greg	Johnson
320	Jaime	Gonzalo Benito
299	Sergio	Gimenez
399	Yuji	Ida
430	Matt	Sikkink Johnson
431	Matthew	Johnson
432	Nicolas	Johnson
433	Ben	Jones
434	Eric	Jones
435	Ethan	Jones
436	Mason	Jones
437	Riley	Jones
438	Andre	Judd
439	Theodore	Jung
440	Martin	Juza
442	Eren	Kacmaz
458	Seamus	Kelahan
459	Chad	Kelley
460	Ryan	Kelly
461	Ben	Kemp
462	Chris	Kemple
463	Tom	Kessler
464	Indigo	Khanna
465	Brian	Kibler
466	Andrew	Kidston
467	Zachary	Kiihne
468	Charis	Kikidis
469	Dillon	Kikkawa
471	Bobby	King
472	Zak	Kirby
473	Kazuya	Kiyofuji
474	Fabian	Klein
475	Ben	Kleinsman-Leusink-Hill
476	Andrei	Klepatch
477	Marcin	Klimuszko
478	Michael	Knie
479	Akira	Kobayashi
480	Ryohei	Kobayashi
481	Tatsuumi	Kobayashi
482	Soichiro	Kohara
483	Yuma	Koizumi
484	Maxx	Kominowski
485	Koki	Kondo
486	Shogo	Kondo
487	Dominik	Konieczny
488	Toru	Kono
489	Jelmer	Koopmans
490	Linden	Koot
491	Kazune	Kosaka
492	Jacob	Koshak
493	Nonthakorn	Kositaporn
494	Chase	Kovac
495	Wojtek	Kowalczuk
496	Grzegorz	Kowalski
497	Maximilian	Krebs
498	Dan	Kristoff
500	Tomáš	Krupička
501	Vikram	Kudva
502	Matti	Kuisma
503	Riku	Kumagai
504	Victor	Kurz
505	Kyosuke	Kyogoku
506	Will	La Hay
507	Cory	Lack
508	Connor	Laehn
509	Antoine	Lagarde
510	Leo	Lahonen
511	Aiden	Lamson
512	Ricardo	Landeta
513	Christoffer	Larsen
514	James	Larsen-Scott
515	Francesco	Latorre
516	Anthony	Lee
517	Ezra	Lee
518	Isaac	Lee
519	Jim Tim	Lee
520	Kafit	Lee
521	Rick	Lee
522	Russell	Lee
523	Shi Tian	Lee
524	Tristan	Leenders
526	Michael	Letsch
527	Matias	Leveratto
528	Eugene	Levin
529	Raphaël	Lévy
530	Fuqi	Li
531	Jun	Li
532	Kaiyuan	Li
533	Zhao	Li
535	Jianwei	Liang
536	Jordan	Lidsky
537	Alex	Lim
538	Lucas	Lim
539	Jeff	Lin
540	Kevin	Lin
542	Alessandro	Lippi
543	Randall	Litman
544	Guanlin	Liu
545	Yuchen	Liu
546	Hernán	Lobos
547	Jason	Loh
548	Mun Kit	Loh
549	Guillermo	Loli
550	Daniel	Lopez
551	Erick	Lopez
552	Jose Luis	Lopez
553	Koko	Lopez
554	Marcelo	López Lagos
555	Daniele	Lorenzini
556	Joe	Lossett
557	Eli	Loveman
558	Daniel	Lozinski
559	Mateusz	Lukaszek
563	Dan	MacDonald
565	Connor	Mackenzie
566	Jeremy	Mackney
567	Benton	Madsen
568	Blake	Madson
569	Edgar	Magalhaes
570	Philip	Mahr
571	Joaquin	Maletti
573	Alberto	Manchado
574	Zach	Mandelblatt
575	Seth	Manfield
576	James	Manges
578	Noah	Mannholland
499	Will	Krueger
560	Arthur	Luke
534	Hanzhi	Li
562	Ma	Noah
525	Christopher	Leonard Huu Nguyen
564	Rick	Mackay
579	Michele	Marconi
580	Emanuele	Marcotti
582	Igor	Marques
583	Drew	Martin
584	Luis	Martin
585	Gabriel	Martinez
586	Leandro	Martins
587	Toni	Martos
588	Kenta	Masukado
589	Takumi	Matsuura
590	Akio	Matsuzaki
591	Hannes	Mauch
592	Gabe	Maxson
593	Caleb	Maynard
595	Connor	Mcgillivray
596	Scott	McNamara
597	Max	McVety
598	Thomas	Mechin
599	Max	Medeiros
600	Jonathan	Melamed
601	Adriano	Melo
602	Alejandro	Mendez
603	Norbie	Mendoza
604	Andrea	Mengucci
605	Guilherme	Merjam
606	Ross	Merriam
607	Alexander	Mertins
608	Theau	Mery
609	Norddin	Mesa
610	Bram	Meulders
611	Noah	Michaud
612	Greg	Michel
613	Makihito	Mihara
614	Alonso	Mijares
615	Yoshiro	Mikami
616	Jacob	Milchman
617	Dan	Milechman
618	Max	Milechman
619	Chris	Miller
620	Rowan	Millers
622	Steven	Minelli
623	Matthew	Minniear
624	Claudio	Miranda
625	Kevin	Mittertreiner
626	Yutaka	Miyagishi
627	Yudai	Miyano
628	Shota	Miyashita
629	Takeshi	Miyawaki
630	Jiantao	Mo
631	Pedro	Mocelin
632	Adham	Momen
633	James	Moore
634	Alejandro	Morales
635	Kyle	Moran
636	Roby	Moreau
637	Joao	Moreira
638	Francisco	Moreno
639	Bryce	Morgan
640	Taichi	Morikawa
641	Yutaro	Morimoto
642	Dalia	Morin
643	Masahide	Moriyama
644	Adriano	Moscato
645	Rob	Moss
646	Evart	Moughon
647	Victor	Moy
648	Luke	Mulcahy
649	Connor	Mullaly
650	Ryan	Mullens
651	Denis	Mullins
652	Ryuji	Murae
653	Kazuya	Murakami
654	David	Muraoka
655	Shane	Murray
656	Hiroki	Nagase
657	Jacob	Nagro
658	Keisuke	Naitou
659	Hiroki	Nakahara
660	Shunichi	Nakajima
661	Shuhei	Nakamura
662	Motohiko	Nakao
663	Atsushi	Nakashima
664	Satoshi	Nakayama
665	Charles	Namchaisiri
666	Tobia	Nappi
667	Bassel	Nasri
668	Matt	Nass
669	Gabriel	Nassif
670	Brandon	Nelson
671	Nick	Nemeth
672	Grayson	Nemets
673	Logan	Nettles
675	Alan	Ngo
676	Minh	Nguyen
677	Thanh	Nguyen
678	Gabriel	Nicholas
679	Simon	Nielsen
680	Ben	Nikolich
682	Dustyn	Nogueira
683	Kazuhiro	Noine
684	Dylan	Nollen
685	Yohei	Nomiya
686	Wouter	Noordzij
687	Miles	Nossett
688	Yuichiro	Obara
689	Kenny	Oberg Falguera
691	Tomoaki	Ogasawara
692	Yusuke	Ohkawa
693	Marei	Okamura
694	Shogo	Okuda
695	Carlos	Oliveros Guntín
696	David	Olsen
697	Przemyslaw	Olszewski
698	Richie	Ong
699	Hiroshi	Onizuka
700	Matthew	Oomkes
701	Greg	Orange
703	Brandon	Ortiz
704	Kazutaka	Oya
705	Takafumi	Oyama
706	Takeshi	Ozawa
707	Matteo	Palma
708	Dominick	Paolercio
709	Franck	Pappas
710	Ulysse Gagnon	Paradis
594	Josh	McClain
702	Marco	Orellana
674	Jose	Neves
581	Scott	Markeson
621	Asha	Mills Emmett
711	Sam	Pardee
712	Freddy	Paredes
713	Alessandro	Parisi
714	Joby	Parrish
715	Lukas	Parson
716	Toni Ramis	Pascual
717	Alexey	Paulot
718	Gray	Payne
719	Adrien	Penard
720	Zer Shiuan	Peng
721	Kamil	Penier
722	Max	Penzkofer
723	Marc	Peral
724	Archibal	Peralta
725	Alejandro	Pereira
727	Nathanael	Perigo
728	Pedro	Perrini
729	Andy	Peters
730	Andreas	Petersen
731	Isaac	Petersen
732	Ha	Pham
733	Jesse	Piland
734	Benedict	Pineda
735	Rodrigo	Pinheiro
737	Derek	Pite
738	Zachary	Plott
739	Scott	Polsky
741	Israel	Pontes
742	Martin	Porter
743	Toni	Portolan
744	Jack	Potter
745	Alex	Poulosky
746	Piper	Powell
747	Sebastian	Pozzo
748	Julian	Prado
750	Ryan	Primdahl
751	Dominik	Prosek
752	Andrejs	Prost
753	Jan	Pruchniewicz
754	Lorenzo	Pucci
755	Joseph	Puglisi Clark
756	Will	Pulliam
757	Jeff	Pyka
758	Mohamad	Qadi
759	Lei	Qiang
760	Martin	Quiroga
761	Noah	Rabin
762	Olle	Rade
763	Wojciecj	Radosz
764	Elliot	Raff
765	Thierry	Ramboa
766	Jesus	Ramos
767	Edgar	Rangel
768	Aarni	Rantamaki
769	Max	Rappaport
770	Brandon	Rashad
771	Sakano	Rei
772	George	Ren
773	Jaden	Rey
774	Claire	Rianhard
775	Patrick	Richardson
776	Paul	Rietzl
777	Raphael	Rieu-Helft
778	Daniel	Riley
779	Mattia	Rizzi
780	Ian	Robb
781	Brad	Robinson
783	Toph	Robinson
784	Cristian	Rodriguez
785	Alex	Rohan
786	Seb	Rohan
787	Michael	Rohrbock
788	Sam	Rolph
789	Steven	Rorabaugh
790	Douglas	Rosa
791	Kyle	Rose
792	Caleb	Rosenbaum
793	Chris	Rothen
794	Rémi	Roudier
795	Collin	Rountree
796	Socrates	Rozakeas
797	Oliver	Ruel-Mailfert
798	Michael	Russell
799	Mitch	Sachs
800	Max	Sagraves
801	John Daroen	Sahagun
802	Shinya	Saito
803	Ethan	Saks
804	Jonathan	Salem
805	Alex	Saltzman
806	Guillem	Salvador
807	Henry	Sams
808	Eugeni	Sanchez
809	Francisco	Sánchez
810	Alberto	Sanchez Diaz
811	Josep	Sanfeliu
812	Bora	Sanoglu
813	André	Santos
814	Bernardo	Santos
815	Diogo	Santos
816	Karl	Sarap
817	Mauro	Sasso
818	Keisuke	Sato
820	Loic	Savoye
821	Panagiotis	Savvidis
822	Thanakarn	Sawetsritawan
823	Matt	Saypoff
824	Boston	Schatteman
826	Davide	Schilliro
827	Nick	Schirillo
828	Bradley	Schlesinger
829	Christophe	Schlom
830	Abe	Schnake
831	Stefan	Schütz
832	Adam	Schwartz
833	Marius	Schwarze
834	Joseph	Sclauzero
835	Luis	Scott-Vargas
836	Simon	Scrutton
837	Isaac	Sears
838	Kenji	Sego
839	Pedro San	Segundo
840	Marco	Senneca
841	Alejandro	Sepulvedra
736	Rob	Pisano
726	Alex	Perez
740	Matheus	Ponciano
749	Nick Malcolm	Preston
842	Thoralf	Severin
843	Donald	Sheldon
844	Sam	Sherman
845	Wei Chung	Shi
846	Jau-En	Shih
847	Kazushige	Shimamura
848	Akinari	Shimokawabe
849	Michael	Siembor
850	Mike	Sigrist
851	Phil	Silberman
852	Dagoberto	Silva
853	Edgar	Simmons
854	Miguel	Simoes
855	Noor	Singh
856	Bartosz	Skorupa
857	Jordan	Small
858	Alex	Smith
859	Isaac	Smith
860	Mack	Smith
861	Robert	Smith
862	Scott	Smith
863	Travis	Smith
864	Willow	Smith
865	Zachary	Smith
866	Nick	Smithmyer
867	Alan	Snead
868	Bram	Snepvangers
870	Tomasz	Sodomirski
871	Weng Heng	Soh
872	Jesus	Solano
873	Daniel	Sondike
874	Gabriel	Soto
876	Matt	Sperling
877	Mark	Stanton
879	Abraham	Stein
880	Robert	Steiner
881	Henry	Steinfeldt
882	Nathan	Steuer
883	Alex	Strange
884	Ondrej	Strasky
885	Devon	Straub
886	Martin	Stube
887	Takashi	Sugimoto
888	Dong	Sui
889	Raja	Sulaiman
890	Guillermo	Sulimovich
891	Chuan	Sun
892	SiHong	Sun
893	Eli	Swafford
894	Jake	Swales
895	Sky Bauerschmidt	Sweeney
896	Cameron	Sweetnam
897	Piotr	Szyinksi
898	Taidhg	Tajalli
899	Ken	Takahama
900	Yuta	Takahashi
902	Ryota	Takeuchi
903	Mitchell	Tamblyn
904	Richmond	Tan
905	Tyng Wei	Tan
906	Wei Siong	Tan
907	Branden	Tanner
908	Chas	Tanner
909	Craig	Tanner
910	Cristian Oyaneder	Tapia
911	Pierre	Tardy
912	Yuya	Tase
913	Matthieu	Tassa
914	Adrian Inigo	Tastet
915	John	Tatian
917	Jordan	Tebby
918	Davide	Tedeschi
919	Kazuya	Terasawa
920	Lorenzo	Terlizzi
921	Kevin	Thanakit
922	Markus	Thibeau
924	Gavin	Thompson-Exner
925	Kieran	Tierney
926	Patrick	Tilsen
927	Nicole	Tipple
928	Egor	Titov
929	Chun Him	To
930	Aaron	Tobey
931	Marc	Tobiasch
932	Rodrigo	Togores
933	Daniel	Toledo
934	Matthew	Tonary
935	Quinn	Tonole
937	Bernardo	Torres
938	Lino	Torretta
939	Sebastian	Torrico
940	Stefano	Torrini
941	Jakub	Toth
942	Christian	Trudel
943	Violet	Truesdell
944	Ioannis	Tsetis
945	Nakata	Tsuyoshi
946	Mark Lawrence	Tubola
947	Ben	Tudman
948	Andrew	Turriago
949	Matti	Tyynysniemi
950	Viking	Unden
951	Haruki	Usui
952	Seyhak	Uy
953	Christian	Valenti
954	Erik	van de Kamp
955	Laurens	Van der Beek
956	Bart	Van Etten
957	Michael	Van Vaals
958	Tom	Vanko
959	Marco	Vassallo
960	Christophe	Vaugeois
961	Jose Luis	Velazquez
963	Massimo	Verrecchia
964	Eduardo dos Santos	Vieira
965	Thiago	Vieira
966	Pascal	Vieren
967	Daniel	Vigo
968	Stefano	Vinci
969	Vincenzo	Vinci
970	Nicolai	Vinther
971	Georgios	Volakis
972	Nils Gutierrez	von Porat
875	Joao Claudio	Souza
923	Will	Thompson
869	Dan	Snider
916	Alex	Teague
936	Chris	Tonry
962	Steve	Verheyn
973	Alex	Von Stange
974	Andy	Vorel
975	Brent	Vos
976	Duy	Vu
977	Federico	Vuono
978	Guillaume	Wafo-Tapa
979	Anna	Wagener
980	Rob	Wagner
981	Jamie	Walsh
982	Ramon	Wandeler
983	Haotian	Wang
984	Aaron	Ward
985	Justin	Warden
986	Takanori	Watanabe
987	Denny	Weinhardt
988	Daniel	Weiser
989	Noah Anderson	Weiskircher
990	Adam	Weiss
991	Julian	Wellman
992	Chris	Westerlund
993	Tom	White
994	Charles	Wickham
995	Ben	Wienburg
996	Christian	Wijaya
997	Jim	Wilks
998	Joshua	Willis
999	Andy	Wilson
1000	Jacob	Wilson
1001	Jay	Wojciechowski
1002	Charles	Wong
1003	Man Lok	Wong
1005	Elijah	Woodbury
1006	Warren	Woodward
1007	Marcus	Wosner
1008	Matthew	Wright
1009	Allen	Wu
1010	Jia	Wu
1011	Patrick	Wu
1012	Tianyou	Wu
1013	Tristan	Wylde-LaRue
1014	Yucheng	Xu
1015	Kazuki	Yada
1016	Matthew	Yakobina
1017	Borja	Yanez
1019	Shota	Yasooka
1020	Jason	Ye
1021	Paul	Yeem
1022	David	Yeh
1023	Yun Chen	Yeh
1024	Hisamichi	Yoshigoe
1025	Hideki	Yoshioka
1026	Fu	Yu
1027	HungYi	Yu
1028	Hungyi	Yu
1029	Jarvis	Yu
1030	Muhan	Yu
1031	Ken	Yukuhiro
1032	Jean	Zarrouati
1033	Xuantao	Zeng
1034	Benny	Zeoli
1035	Ben	Zhang
1037	Yuxuan	Zhang
1038	Jingwei	Zheng
1039	Yimin	Zhi
1040	Jack	Zhong
1041	Adrian	Zhu
1042	Brian	Zilles
1043	Raoul	Zimmermann
1044	Cristian	Zuniga
1046	David	Rood
1047	Percy	Fang
1048	Christian	Baker
1049	Nicholas	Odenheimer
1050	Luís	Gobern
1051	Shintaro	Ishimura
1052	Thirawat	Chaovarindr
1053	Aarni	Rantamäki
1054	Alexander	Rosdahl
1055	Nathan	Basser
1056	Phil	Li
1057	Raul	Porojan
1058	František	Vitula
1059	Keyan	Jafari
1060	Zen	Miyaji-Thorne
1061	Paulo Vitor	Damo da Rosa
1062	Victor	Hawkins
1063	Yang	Shi
1064	Robert	Pounds
1066	Lorenzo	Pollone
1067	Bora	Sarıoğlu
1068	Ivan	Espinosa
1069	Yann Alexandre	Chouinard
1070	Bob	Maher
1071	Christopher	Tong
1072	Josh	Morton
1074	Victor	Santos Esquici
1107	Jesse	Robkin
1108	Matthew	Loukides
1109	Jake	Stine
1112	Alex	Wells
1113	Brandon	McArthur
1114	Mike	Hron
1115	Dalibor	Trnka
1116	Sebastian	Vearncombe
1117	Gerald	Leitzinger
1118	Lee	Shi Tian
1120	Joel	Doolittle
1121	Thomas	Munk
1122	Yuma	Higuchi
1123	Eddie	Dominguez
1124	Max	Deresh
1125	Bartek	Wojciechowski
1126	Timothy	Moore
1127	Will	Layne
1128	Krista	Oscapinski
1129	Nate	Hoffman
1130	Zohar	Bhagat
1132	Carmelo	Gianchino
1133	Bryan	Rockenbach
1134	Antonín	Braniš
1135	Theodor	Eliassen
1136	Alp Bugra	Cal
1137	Luke	Brandes
1111	Rob	Wagner Krankel
1018	Yi	Yang
1004	JinSung	Woo
1036	Rui	Zhang
1119	Ben	Stark
1138	Elias	May
1139	Wladimir	Jerger
1140	David	Akers
1141	Przemysław	Olszewski
1142	Mark	Jacobson
1143	Soohan	Yoon
1144	Chuck	Pierce
1146	Alex	Wilson
1147	Martin-Eric	Gauthier
1148	Ryuji	Mimido
1149	Andrea	Botti
1150	Alex	Yatsenko
1151	Amir	Momin
1152	Lee	Webb
1153	Will	Kowalczyk
1154	Dan	Qu
1156	Jinhao	Yang
1157	Austin	Clark
1158	Lou	Salerno
1159	Pieter	Tubergen
1160	Quentin	Wilebski
1161	Ryo	Ito
1162	Jacob	Hart
32	Talia	Bael
33	Kazi	Baker
34	John	Balla
36	Randall	Barber
37	Leonard	Barker
38	Tyler	Barnett
39	Chris	Barone
40	Matthew	Baros-Steyl
41	Jacopo	Bartollini
42	Nathan 	Basser
43	Frederico	Bastos
44	Ben	Bates
45	Jake	Beardsley
46	Devin	Beaston
47	Aaren	Beaty
48	Marco	Belacca
49	Omar	Beldon
50	Michael	Belfatto
51	Travis	Benedict
52	Giuliano	Benincasa
53	Francisco	Benitez
54	Alfie	Bennett
55	Asdren-Alexander	Berberi
56	Brandon	Bercovich
57	Jakob	Bergelin
58	Jordan	Berkowitz
59	Kim	Berle
8	Kevin	Anctil
9	Emily	Anders
10	Matt	Anderson
15	Gareth	Antle
16	Yasunobu	Anzai
17	Renato	Araujo
422	Bin	Jia
1075	Jose Gabriel	Hilario
1091	Adrian	Alvarez Vega
1092	Ai-Chen	Chang
1093	Gabriel	Lopes
1094	Eduardo	Rodriguez Vilaboy
1095	James	Moskal
1096	Aidan	Mirabelli
1097	Maxim	Barkman
1098	Chikuan	Lin
1099	Hiroki	Kageyama
1100	Tetsu	Kawaguchi
1101	Feili	Chen
1102	Peter	Duris
1103	Gabriel	Balannik
1104	Owen	Hays
1106	Masataka	Hori
1163	John	Ramos
1164	Steven	Li
1165	Mikey	Bishara
1166	Danny	Seet
1167	Maximilian	Tassone
1168	Christian	Canale
1169	Nuno	Vale
1170	Juli	Caballero Queralt
1171	Jon	Barber
1172	Scott	Miller
1173	Joel	Sadowsky
1174	Chase	Masters
1175	Nathan	Andress
1176	Luis	Monge
1177	Luca	Birettoni
1178	Daniel	Isaías
1179	Takumi	Utsunomiya
1180	Lorenzo	Bellettini
1181	Gabriel	Bostic
1182	Federico	Giardini
1183	Shirag	Maharaj
1184	Nick	Cosgrove
1185	Markus	Leicht
1186	Pablo	Duque
1187	Peter	Husisian
1188	Damian	Del Nero
1189	Ryan	Normandin
60	Laurent	Bernard
13	Lucas	Andre
1206	Quinton	Lip
7	Valerio	Amer
14	Alan	Andrzejewski
1076	Michael	Zhao
1077	Fernando	Palmero Garcia
1078	Piotr	Głogowski
1079	Shunsuke	Kimura
1080	Jakub	Sznajder
1081	Óscar	Franco
1082	Carlos	Sousa
1083	Allan	Fong
1084	Justin	Schabel
1085	Chris	Kral
1086	Isael	Feitosa
1087	Jackson	Knorr
1088	Toni	Ramis Pascual
1089	Patrick	Chapin
1090	Kristoffer	Lindqvist
1190	Davide	Ferroni
1191	Taisei	Nakayama
1192	Callum	Laird
1193	Léo	Chapelle
1194	Shih Feng	Lin
1195	Josh	Martinez
1196	Jacob	Richer
1197	Shuhei	Kitamura
1198	Sukhum	Kiwanont
1199	David	Johnson
1200	Colin	Harris
1201	Roberto	Soto
1202	Alan	Hubbard
1203	Gonçalo	Bragança
1204	Tom	Strong
1205	Julian	John
1207	Pär	Jones
1208	Takumi	Tanabe
1209	Arthur	Brocsko
1210	Enzo	Birk
1	Mário	Abreu
2	Josh	Agresta
3	Yo	Akaike
4	Reed	Alexander
5	Nolan	Allen
6	Danilo	Almeida
12	Robert	Anderson
35	Jan	Ban
443	Emil	Kalaydzhiev
444	Kazuhiro	Kamata
445	Sho	Kamezaki
446	Riki	Kamo
447	Liam	Kane
448	Alexander	Kans
449	Vinícius	Karam
450	Joseph	Karani
451	Eli	Kassis
452	Kensuke	Kato
453	Hirotaka	Kawasaki
454	Yong Claudio	Ke
455	Drew	Keeney
456	Christian	Keffer
457	Jody	Keith
30	Max	Bachvaroff
22	Shun	Asano
18	William	Araujo
19	Daniel	Arellano
20	Fernando	Arriagada
21	James	Arthur
23	Tatsuro	Asano
24	Hiroki	Asaumi
25	Tommy	Ashton
26	Rudi	Asinas
27	Dominik	Aspernig
28	Pedro	Avena
29	Matthieu	Avignon
31	Andrew	Baeckstrom
1211	Zack	Cohen
1212	Mitchell	Berven-Stotz
1213	Simon	Piché
\.


--
-- Data for Name: results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.results (id, player_id, event_id, day2, top8, limited_wins, limited_losses, limited_draws, num_drafts, positive_drafts, negative_drafts, trophy_drafts, no_win_drafts, constructed_wins, constructed_losses, constructed_draws, overall_wins, overall_losses, overall_draws, overall_record, day1_wins, day1_losses, day1_draws, day2_wins, day2_losses, day2_draws, day3_wins, day3_losses, day3_draws, in_contention, win_streak, loss_streak, streak5, finish, summary, team, deck, notes) FROM stdin;
9892	809	11	t	t	4	2	0	2	1	1	1	0	10	1	1	14	3	1	14-3-1	5	2	1	7	1	0	2	1	0	t	5	2	1	2	Finals	Team Pluto	Azorius Control	\N
9893	1214	11	t	t	5	1	0	2	2	0	1	0	8	3	0	13	4	0	13-4-0	5	3	0	7	0	0	1	1	0	t	8	2	1	3	Semifinals	Team Vents	Tameshi Belcher	\N
9894	1215	11	t	t	5	1	0	2	2	0	1	0	8	4	0	13	5	0	13-5-0	5	3	0	7	1	0	1	1	0	t	5	1	1	4	Semifinals	\N	Esper Blink	\N
9895	1084	11	t	t	6	0	0	2	2	0	2	0	6	3	0	12	3	0	12-3-0	6	2	0	6	0	0	0	1	0	t	7	1	1	5	Top 8	Team Serious Player Only	Izzet Prowess	\N
9896	99	11	t	t	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	7	1	0	5	2	0	0	1	0	t	7	1	1	6	Top 8	Flexslot Diamond	Amulet Titan	\N
9897	341	11	t	t	6	0	0	2	2	0	2	0	6	5	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	6	2	1	7	Top 8	Handshake Moxfield	Esper Goryo's	\N
9898	1216	11	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	6	2	0	6	2	0	0	1	0	t	3	1	0	8	Top 8	Worldly Counsel Heavy Play	Simic Neoform	\N
9899	282	11	t	f	4	2	0	2	1	1	1	0	8	2	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	7	1	1	9	Top 16	Handshake Moxfield	Izzet Affinity	\N
9900	684	11	t	f	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	4	4	0	8	0	0	0	0	0	t	9	3	1	10	Top 16	Team Main Phase	Eldrazi Tron	\N
9901	1217	11	t	f	5	1	0	2	2	0	1	0	6	3	1	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	t	5	1	1	11	Top 16	Team Pluto	Azorius Control	\N
9902	669	11	t	f	4	1	1	2	1	0	1	0	7	3	0	11	4	1	11-4-1	6	2	0	5	2	1	0	0	0	t	4	1	0	12	Top 16	Team TCGPlayer	Azorius Blink	\N
9903	261	11	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	2	0	13	Top 16	Handshake Moxfield	Boros Energy	\N
10813	562	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	195	X	TCGplayer	Bant Rhythm	\N
9905	661	11	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	8	0	0	3	5	0	0	0	0	t	8	3	1	15	Top 16	Moriyama Japan	Izzet Affinity	\N
9906	1219	11	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	6	2	1	16	Top 16	Cosmos Heavy Play	Eldrazi Tron	\N
9907	761	11	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	2	0	17	Top 32	\N	Amulet Titan	\N
9908	947	11	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	1	0	18	Top 32	Scryhard	Eldrazi Ramp	\N
9909	312	11	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	5	3	1	19	Top 32	Rampant Growth Heavy Play	Simic Neoform	\N
9910	1220	11	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	2	1	20	Top 32	Team TCGPlayer	Jeskai Blink	\N
9911	935	11	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	5	1	1	21	Top 32	Cosmos Heavy Play	Tameshi Belcher	\N
9912	269	11	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	6	2	1	22	Top 32	Worldly Counsel Heavy Play	Esper Goryo's	\N
9913	811	11	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	3	1	0	23	Top 32	Team Pluto	Eldrazi Tron	\N
9914	162	11	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	24	Top 32	Sanctum of All	Amulet Titan	\N
9915	247	11	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	25	Top 32	Sanctum of All	Amulet Titan	\N
9916	1221	11	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	26	Top 32	Team Serious Player Only	Boros Energy	\N
9917	1222	11	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	5	2	1	27	Top 32	Team Seedcore	Amulet Titan	\N
9918	1223	11	t	f	3	3	0	2	1	1	1	1	8	2	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	t	10	3	1	28	Top 32	\N	Tameshi Belcher	\N
9919	785	11	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	f	5	4	1	29	Top 32	Worldly Counsel Heavy Play	Simic Neoform	\N
9920	346	11	t	f	3	2	1	2	1	1	0	0	7	3	0	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	f	3	2	0	30	Top 32	Handshake Moxfield	Esper Goryo's	\N
9921	567	11	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	f	5	3	1	31	Top 32	Worldly Counsel Heavy Play	Golgari Broodscale	\N
9922	831	11	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	7	1	0	3	4	1	0	0	0	f	7	2	1	32	Top 32	Handshake Moxfield	Esper Goryo's	\N
9923	743	11	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	3	2	0	33	Day 2	Sanctum of All	Izzet Affinity	\N
9924	1224	11	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	34	Day 2	\N	Boros Energy	\N
9925	1165	11	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	35	Day 2	Flexslot Diamond	Simic Neoform	\N
9926	1062	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	36	Day 2	Cosmos Heavy Play	Esper Goryo's	\N
9927	1052	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	5	2	1	37	Day 2	SEA	Esper Goryo's	\N
9928	575	11	t	f	5	1	0	2	2	0	1	0	4	3	3	9	4	3	9-4-3	4	1	3	5	3	0	0	0	0	t	3	2	0	38	Day 2	Team TCGPlayer	Izzet Prowess	\N
9929	1225	11	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	39	Day 2	\N	Tameshi Belcher	\N
9930	1226	11	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	40	Day 2	\N	Eldrazi Tron	\N
9931	1227	11	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	41	Day 2	Team Serious Player Only	Eldrazi Tron	\N
9932	234	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	42	Day 2	Team TCGPlayer	Azorius Blink	\N
9933	1228	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	43	Day 2	Moriyama Japan	Izzet Affinity	\N
9934	1229	11	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	44	Day 2	\N	Domain Zoo	\N
9935	202	11	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	45	Day 2	Cosmos Heavy Play	Esper Goryo's	\N
9936	1203	11	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	1	1	46	Day 2	\N	Boros Energy	\N
9937	447	11	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	47	Day 2	Cosmos Heavy Play	Tameshi Belcher	\N
9938	403	11	t	f	3	3	0	2	1	1	1	1	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	3	1	48	Day 2	Handshake Moxfield	Izzet Affinity	\N
9939	769	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	49	Day 2	Rampant Growth Heavy Play	Esper Blink	\N
9940	132	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	3	0	50	Day 2	\N	Esper Goryo's	\N
9941	1230	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	51	Day 2	Team Vents	Tameshi Belcher	\N
9942	765	11	t	f	4	1	1	2	1	0	1	0	5	3	2	9	4	3	9-4-3	4	3	1	5	1	2	0	0	0	f	3	2	0	52	Day 2	Cosmos Heavy Play	Esper Goryo's	\N
9943	605	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	53	Day 2	Team Double Infinity	Boros Energy	\N
9944	1231	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	54	Day 2	\N	Tameshi Belcher	\N
9945	1232	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	55	Day 2	Scryhard	Izzet Prowess	\N
9946	1233	11	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	7	3	1	56	Day 2	\N	Mono-Green Broodscale	\N
9947	1039	11	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	57	Day 2	\N	Esper Goryo's	\N
9948	228	11	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	t	9	4	1	58	Day 2	Team TCGPlayer	Azorius Blink	\N
9949	1234	11	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	59	Day 2	Team Seedcore	Esper Goryo's	\N
9950	401	11	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	2	1	60	Day 2	Moriyama Japan	Izzet Affinity	\N
9951	1235	11	t	f	1	5	0	2	0	2	0	1	9	1	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	61	Day 2	Italians	Esper Blink	\N
9952	1020	11	t	f	4	2	0	2	1	1	1	0	5	4	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	3	3	0	62	Day 2	Sanctum of All	Jeskai Chant	\N
9953	1236	11	t	f	5	0	1	2	2	0	1	0	4	6	0	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	4	3	0	63	Day 2	Team Double Infinity	Tameshi Belcher	\N
9955	599	11	t	f	4	1	1	2	2	0	0	0	5	5	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	2	2	0	65	Day 2	Rampant Growth Heavy Play	Boros Energy	\N
9956	1050	11	t	f	4	2	0	2	1	1	1	0	5	4	1	9	6	1	9-6-1	4	4	0	5	2	1	0	0	0	f	6	3	1	66	Day 2	Team Double Infinity	Eldrazi Ramp	\N
9957	1036	11	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	4	2	0	67	Day 2	Sanctum of All	Izzet Affinity	\N
9958	998	11	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	4	4	0	5	2	1	0	0	0	f	3	3	0	68	Day 2	Team Main Phase	Eldrazi Tron	\N
9959	937	11	t	f	1	4	0	2	0	1	0	1	7	2	1	8	6	1	8-6-1	4	4	0	5	2	1	0	0	0	f	2	3	0	69	Day 2	Team Double Infinity	Eldrazi Tron	\N
9960	723	11	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	70	Day 2	Worldly Counsel Heavy Play	Tameshi Belcher	\N
9961	584	11	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	4	1	71	Day 2	Team Pluto	Tameshi Belcher	\N
9962	667	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	72	Day 2	Rampant Growth Heavy Play	Simic Neoform	\N
9963	1238	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	73	Day 2	Buffalo Unnamed	Tameshi Belcher	\N
9964	365	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	74	Day 2	Scryhard	Azorius Control	\N
9965	634	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	75	Day 2	Team Pluto	Tameshi Belcher	\N
9966	1057	11	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	76	Day 2	\N	Esper Midrange	\N
9967	1239	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	77	Day 2	\N	Esper Blink	\N
9968	1240	11	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	4	0	78	Day 2	Team Seedcore	Tameshi Belcher	\N
9969	467	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	79	Day 2	Handshake Moxfield	Esper Goryo's	\N
9970	1241	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	7	2	1	80	Day 2	\N	Esper Goryo's	\N
9971	616	11	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	81	Day 2	Cosmos Heavy Play	Eldrazi Tron	\N
9972	394	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	82	Day 2	Handshake Moxfield	Esper Goryo's	\N
9973	1060	11	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	83	Day 2	Worldly Counsel Heavy Play	Simic Neoform	\N
9974	1242	11	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	84	Day 2	\N	Samwise Gamgee Combo	\N
9975	18	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	85	Day 2	Team Double Infinity	Domain Zoo	\N
9976	329	11	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	86	Day 2	Sanctum of All	Amulet Titan	\N
9977	1082	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	87	Day 2	Team Pluto	Tameshi Belcher	\N
9978	331	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	88	Day 2	\N	Domain Zoo	\N
9979	1243	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	3	0	89	Day 2	\N	Domain Zoo	\N
9980	666	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	90	Day 2	Italians	Esper Goryo's	\N
9981	451	11	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	4	1	91	Day 2	Handshake Moxfield	Jeskai Control	\N
9982	448	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	2	1	92	Day 2	Team Seedcore	Dimir Mill	\N
9983	468	11	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	93	Day 2	Worldly Counsel Heavy Play	Esper Goryo's	\N
9984	200	11	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	94	Day 2	Worldly Counsel Heavy Play	Esper Goryo's	\N
9985	77	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	95	Day 2	Sanctum of All	Jeskai Chant	\N
9986	1019	11	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	3	0	96	Day 2	\N	Esper Goryo's	\N
9987	711	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	97	Day 2	Team TCGPlayer	Esper Goryo's	\N
9988	668	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	98	Day 2	Team TCGPlayer	Esper Goryo's	\N
9989	588	11	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	99	Day 2	Moriyama Japan	Esper Blink	\N
9990	1244	11	t	f	2	4	0	2	1	0	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	100	Day 2	\N	Esper Goryo's	\N
9991	188	11	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	101	Day 2	Worldly Counsel Heavy Play	Simic Neoform	\N
9992	1245	11	t	f	2	3	0	2	0	1	0	0	7	3	0	9	6	0	9-6-0	4	4	0	5	3	0	0	0	0	f	3	2	0	102	Day 2	Scryhard	Izzet Prowess	\N
9993	349	11	t	f	3	2	1	2	1	0	0	0	5	4	1	8	6	2	8-6-2	4	4	0	4	2	2	0	0	0	f	3	2	0	103	Day 2	Moriyama Japan	Grixis Reanimator	\N
9994	1246	11	t	f	2	4	0	2	1	1	0	1	6	2	2	8	6	2	8-6-2	5	2	1	3	4	1	0	0	0	f	3	3	0	104	Day 2	\N	Esper Goryo's	\N
9995	1247	11	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	2	3	0	105	Day 2	Italians	Esper Goryo's	\N
9996	221	11	t	f	5	1	0	2	2	0	1	0	3	6	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	2	0	106	Day 2	Worldly Counsel Heavy Play	Simic Neoform	\N
9997	1002	11	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	2	2	0	107	Day 2	Handshake Moxfield	Esper Goryo's	\N
9998	476	11	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	2	0	108	Day 2	Rampant Growth Heavy Play	Boros Energy	\N
9999	490	11	t	f	3	2	1	2	1	1	1	0	5	5	0	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	5	4	1	109	Day 2	Team Vents	Grixis Midrange	\N
10000	1248	11	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	2	2	0	110	Day 2	\N	Esper Goryo's	\N
10001	1249	11	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	7	7	1	111	Day 2	\N	Tameshi Belcher	\N
10002	1048	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	112	Day 2	Flexslot Diamond	Tameshi Belcher	\N
10003	1250	11	t	f	4	1	1	2	2	0	0	0	3	5	2	7	6	3	7-6-3	4	1	3	3	5	0	0	0	0	f	3	3	0	113	Day 2	\N	Domain Zoo	\N
10004	1096	11	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	114	Day 2	Cosmos Heavy Play	Tameshi Belcher	\N
10005	1251	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	115	Day 2	Worldly Counsel Heavy Play	Esper Goryo's	\N
5247	14	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	281	x	Team Bus Stop	Gruul Mice	
10006	1252	11	t	f	4	1	1	2	2	0	0	0	3	5	2	7	6	3	7-6-3	4	1	3	3	5	0	0	0	0	f	3	3	0	116	Day 2	Buffalo Unnamed	Esper Goryo's	\N
10007	1253	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	117	Day 2	\N	Amulet Titan	\N
10008	1254	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	4	0	118	Day 2	Flexslot Diamond	Boros Energy	\N
10009	903	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	119	Day 2	Team Main Phase	Tameshi Belcher	\N
10010	1058	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	120	Day 2	\N	Eldrazi Tron	\N
10011	72	11	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	121	Day 2	Sanctum of All	Boros Energy	\N
10012	1104	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	122	Day 2	\N	Tameshi Belcher	\N
10013	1255	11	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	5	4	1	123	Day 2	\N	Boros Energy	\N
10014	466	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	5	3	1	124	Day 2	\N	Tameshi Belcher	\N
10015	1256	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	125	Day 2	Cosmos Heavy Play	Tameshi Belcher	\N
10016	1257	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	126	Day 2	Team Pluto	Eldrazi Ramp	\N
10017	1258	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	127	Day 2	Scryhard	Azorius Control	\N
10018	398	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	128	Day 2	Cosmos Heavy Play	Esper Goryo's	\N
10019	877	11	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	129	Day 2	Rampant Growth Heavy Play	Boros Energy	\N
10020	975	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	130	Day 2	Team TCGPlayer	Izzet Prowess	\N
10021	107	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	131	Day 2	Worldly Counsel Heavy Play	Eldrazi Tron	\N
10022	1259	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	132	Day 2	\N	Azorius Blink	\N
10023	1049	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	133	Day 2	Flexslot Diamond	Boros Energy	\N
10024	1056	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	134	Day 2	Sanctum of All	Boros Energy	\N
10025	830	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	135	Day 2	Rampant Growth Heavy Play	Amulet Titan	\N
10026	1260	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	136	Day 2	Team Pluto	Izzet Prowess	\N
10027	217	11	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	137	Day 2	Cosmos Heavy Play	Eldrazi Tron	\N
10028	565	11	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	138	Day 2	Rampant Growth Heavy Play	Boros Energy	\N
7087	1502	6	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	3	2	0	23	Top 32		Esper Midrange	3-3 to 6-3, out of the reckoning after R12.
10030	8	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	140	Day 2	\N	Grixis Reanimator	\N
10031	1261	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	141	Day 2	\N	Eldrazi Tron	\N
10032	1031	11	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	142	Day 2	Moriyama Japan	Tameshi Belcher	\N
10033	1262	11	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	143	Day 2	\N	Eldrazi Ramp	\N
10034	257	11	t	f	3	3	0	2	1	1	0	0	4	4	2	7	7	2	7-7-2	5	2	1	2	5	1	0	0	0	f	4	2	0	144	Day 2	Italians	Eldrazi Ramp	\N
10035	421	11	t	f	3	3	0	2	1	1	0	0	4	5	1	7	8	1	7-8-1	5	2	1	2	6	0	0	0	0	f	4	3	0	145	Day 2	\N	Esper Goryo's	\N
10036	927	11	t	f	3	2	1	2	1	0	0	0	4	6	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	2	2	0	146	Day 2	Sanctum of All	Izzet Affinity	\N
10037	920	11	t	f	3	2	1	2	1	1	1	0	4	6	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	3	0	147	Day 2	Worldly Counsel Heavy Play	Tameshi Belcher	\N
10038	502	11	t	f	3	3	0	2	1	1	1	1	3	4	3	6	7	3	6-7-3	6	1	1	0	6	2	0	0	0	f	3	4	0	148	Day 2	Handshake Moxfield	Esper Goryo's	\N
10039	238	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	5	0	149	Day 2	Team Double Infinity	Boros Energy	\N
10040	1263	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	6	0	150	Day 2	\N	Azorius Control	\N
7088	1502	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	80	Day 2		Four-Color Nadu	4-4 overnight, soon out of contention, but won his last four.
10041	1264	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	4	0	151	Day 2	\N	Izzet Prowess	\N
5352	79	6	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	188	X			Eliminated by Martin Juza in R7.
10042	406	11	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	152	Day 2	Moriyama Japan	Tameshi Belcher	\N
10043	545	11	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	153	Day 2	MTG Sheep	Boros Energy	\N
10044	1265	11	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	5	0	154	Day 2	Team Vents	Simic Neoform	\N
10045	816	11	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	5	0	155	Day 2	Handshake Moxfield	Esper Goryo's	\N
10046	1192	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	156	Day 2	Worldly Counsel Heavy Play	Esper Goryo's	\N
10047	1266	11	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	157	Day 2	\N	Tameshi Belcher	\N
10048	676	11	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	4	0	158	Day 2	Sanctum of All	Boros Energy	\N
10050	1267	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	160	Day 2	\N	Esper Goryo's	\N
10051	1268	11	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	161	Day 2	Team Seedcore	Eldrazi Tron	\N
10052	1269	11	t	f	1	3	2	2	1	1	0	1	5	4	1	6	7	3	6-7-3	3	2	3	3	5	0	0	0	0	f	2	4	0	162	Day 2	Team Main Phase	Esper Goryo's	\N
10053	527	11	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	163	Day 2	Team Pluto	Azorius Control	\N
10054	889	11	t	f	2	4	0	2	0	2	0	0	4	3	3	6	7	3	6-7-3	4	3	1	2	4	2	0	0	0	f	3	2	0	164	Day 2	Flexslot Diamond	Jeskai Control	\N
10055	1270	11	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	2	0	165	Day 2	Team Serious Player Only	Boros Energy	\N
10056	1271	11	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	3	0	166	Day 2	Worldly Counsel Heavy Play	Domain Zoo	\N
10057	679	11	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	167	Day 2	Handshake Moxfield	Esper Goryo's	\N
10058	643	11	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	168	Day 2	Moriyama Japan	Izzet Affinity	\N
10059	1051	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	169	Day 2	Moriyama Japan	Izzet Affinity	\N
10060	1272	11	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	5	0	170	Day 2	\N	Esper Goryo's	\N
10061	118	11	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	5	4	1	171	Day 2	\N	Eldrazi Ramp	\N
10062	1273	11	t	f	2	3	1	2	0	1	0	0	4	5	1	6	8	2	6-8-2	4	2	2	2	6	0	0	0	0	f	1	5	0	172	Day 2	\N	Eldrazi Tron	\N
10063	1274	11	t	f	3	2	1	2	1	1	0	0	3	6	0	6	8	1	6-8-1	4	4	0	2	4	1	0	0	0	f	4	3	0	173	Day 2	\N	Boros Energy	\N
10064	1275	11	t	f	2	3	1	2	1	1	0	0	4	6	0	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	3	3	0	174	Day 2	\N	Eldrazi Tron	\N
10065	226	11	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	6	0	175	Day 2	Rampant Growth Heavy Play	Simic Neoform	\N
10066	1276	11	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	176	Day 2	MTG Sheep	Boros Energy	\N
10067	125	11	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	177	Day 2	Team Double Infinity	Boros Energy	\N
10068	1047	11	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	4	7	0	178	Day 2	Team Serious Player Only	Boros Energy	\N
10069	385	11	t	f	1	4	0	2	0	2	0	0	5	5	0	6	9	0	6-9-0	4	4	0	2	6	0	0	0	0	f	3	4	0	179	Day 2	Flexslot Diamond	Esper Control	\N
10070	1277	11	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	180	Day 2	\N	Esper Blink	\N
10071	1278	11	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	181	Day 2	Sanctum of All	Amulet Titan	\N
10072	328	11	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	182	Day 2	Sanctum of All	Amulet Titan	\N
10073	240	11	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	183	Day 2	Sanctum of All	Izzet Affinity	\N
10074	727	11	t	f	2	4	0	2	1	1	0	1	3	7	0	5	11	0	5-11-0	5	3	0	0	8	0	0	0	0	f	2	8	0	184	Day 2	Sanctum of All	Tameshi Belcher	\N
10075	1085	11	t	f	2	4	0	2	1	1	0	1	3	4	0	5	8	0	5-8-0	5	3	0	0	5	0	0	0	0	f	2	5	0	185	Day 2	Team Main Phase	Orzhov Blink	\N
10076	780	11	t	f	1	5	0	2	0	2	0	1	4	6	0	5	11	0	5-11-0	4	4	0	0	7	0	0	0	0	f	2	6	0	186	Day 2	Cosmos Heavy Play	Eldrazi Tron	\N
10077	1279	11	t	f	1	5	0	2	0	2	0	1	3	2	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	3	5	0	187	Day 2	\N	Azorius Control	\N
10078	678	11	t	f	1	2	0	2	0	1	0	0	3	2	0	4	4	0	4-4-0	4	4	0	0	0	0	0	0	0	f	2	1	0	188	Day 2	Team Main Phase	Boros Energy	\N
10079	373	11	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	189	X	Moriyama Japan	Tameshi Belcher	\N
5393	104	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	108	Day 2			Got to 5-2 before falling away.
10093	1502	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	203	X	Team Main Phase	Tameshi Belcher	\N
10080	1280	11	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	190	X	Scryhard	Esper Goryo's	\N
10081	291	11	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	191	X	Team Seedcore	Esper Goryo's	\N
10082	1281	11	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	192	X	Moriyama Japan	Tameshi Belcher	\N
10083	1282	11	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	193	X	Scryhard	Esper Blink	\N
10084	310	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	194	X	Cosmos Heavy Play	Esper Goryo's	\N
10085	1283	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	195	X	Flexslot Diamond	Esper Goryo's	\N
10086	1054	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	196	X	Scryhard	Esper Blink	\N
10087	48	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	197	X	Italians	Boros Energy	\N
10088	657	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	198	X	Team TCGPlayer	Tameshi Belcher	\N
10089	1284	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	199	X	\N	Esper Blink	\N
10090	1285	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	200	X	Flexslot Diamond	Eldrazi Ramp	\N
10091	618	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	201	X	\N	Eldrazi Ramp	\N
10092	1286	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	202	X	\N	Azorius Blink	\N
10094	457	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	204	X	Team Main Phase	Dimir Mill	\N
10095	1066	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	205	X	Italians	Boros Energy	\N
10096	82	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	206	X	Flexslot Diamond	Esper Blink	\N
10097	704	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	207	X	\N	Boros Energy	\N
10098	1287	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	208	X	\N	Eldrazi Tron	\N
10099	1288	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	209	X	\N	Izzet Wizards	\N
10100	439	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	210	X	Team TCGPlayer	Esper Goryo's	\N
10101	1289	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	211	X	Team Seedcore	Dimir Mill	\N
10103	589	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	213	X	Moriyama Japan	Boros Energy	\N
10104	1291	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	214	X	\N	Izzet Prowess	\N
10105	595	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	215	X	Worldly Counsel Heavy Play	Tameshi Belcher	\N
10106	1292	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	216	X	Scryhard	Simic Neoform	\N
10107	733	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	217	X	Team Seedcore	Golgari Yawgmoth	\N
10108	900	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	218	X	Cosmos Heavy Play	Dimir Midrange	\N
10109	298	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	219	X	Team Vents	Esper Blink	\N
10110	1293	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	220	X	\N	Boros Energy	\N
10111	1294	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	221	X	\N	Tameshi Belcher	\N
10112	39	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	222	X	\N	Boros Energy	\N
10113	78	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	223	X	\N	Eldrazi Tron	\N
10114	1295	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	224	X	\N	Esper Midrange	\N
10115	569	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	225	X	Team TCGPlayer	Esper Goryo's	\N
10116	1296	11	f	f	2	1	0	1	1	0	0	0	2	3	0	4	4	0	4-4-0	3	5	0	0	0	0	0	0	0	f	2	4	0	226	X	\N	Boros Energy	\N
10117	1297	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	227	X	Scryhard	Eldrazi Ramp	\N
10118	792	11	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	228	X	\N	Esper Goryo's	\N
10119	171	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	229	X	Rampant Growth Heavy Play	Izzet Affinity	\N
10120	1298	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	230	X	Scryhard	Amulet Titan	\N
10121	1299	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	231	X	\N	Simic Neoform	\N
10122	1300	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	232	X	\N	Ruby Storm	\N
10123	1301	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	233	X	Sanctum of All	Jeskai Chant	\N
10124	818	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	234	X	\N	Boros Energy	\N
10125	644	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	235	X	Italians	Esper Goryo's	\N
10126	1302	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	236	X	Sanctum of All	Grixis Reanimator	\N
10127	1303	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	237	X	Team Double Infinity	Izzet Affinity	\N
10128	1304	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	238	X	Buffalo Unnamed	Esper Goryo's	\N
10129	1305	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	239	X	\N	Tameshi Belcher	\N
10130	239	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	240	X	Rampant Growth Heavy Play	Boros Energy	\N
10131	1306	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	241	X	Team Vents	Tameshi Belcher	\N
10132	1307	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	242	X	\N	Esper Blink	\N
10133	1308	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	243	X	Team Seedcore	Boros Energy	\N
10134	1309	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	244	X	Team Vents	Tameshi Belcher	\N
10135	1310	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	245	X	\N	Eldrazi Tron	\N
10136	1311	11	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	246	X	\N	Samwise Gamgee Combo	\N
10137	612	11	f	f	2	0	1	1	1	0	0	0	0	4	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	4	0	247	X	Sanctum of All	Esper Blink	\N
10138	121	11	f	f	1	2	0	1	0	1	0	0	1	2	1	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	2	0	248	X	Team Double Infinity	Boros Energy	\N
10139	371	11	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	249	X	Scryhard	Tameshi Belcher	\N
10140	525	11	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	250	X	\N	Eldrazi Tron	\N
10141	1312	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	251	X	Team Vents	Tameshi Belcher	\N
10142	1009	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	252	X	Handshake Moxfield	Esper Goryo's	\N
10143	1313	11	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	253	X	Team Vents	Domain Zoo	\N
10144	1314	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	254	X	Team Vents	Boros Energy	\N
10145	430	11	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	255	X	Sanctum of All	Esper Blink	\N
10146	538	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	256	X	SEA	Izzet Affinity	\N
10147	1315	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	257	X	Sanctum of All	Boros Energy	\N
10148	1013	11	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	258	X	Handshake Moxfield	Izzet Affinity	\N
10149	1316	11	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	259	X	Team Main Phase	Izzet Affinity	\N
10150	1053	11	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	260	X	Rampant Growth Heavy Play	Boros Energy	\N
10151	1317	11	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	2	5	0	0	0	0	0	0	0	f	1	4	0	261	X	Team Seedcore	Esper Blink	\N
10152	573	11	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	5	0	0	0	0	0	0	0	f	2	4	0	262	X	Team Pluto	Eldrazi Tron	\N
10153	1064	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	263	X	\N	Izzet Affinity	\N
10154	658	11	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	264	X	\N	Tameshi Belcher	\N
10155	1318	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	265	X	\N	Golgari Broodscale	\N
10156	227	11	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	266	X	Team Vents	Domain Zoo	\N
10157	1319	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	267	X	\N	Simic Neoform	\N
10158	1320	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	268	X	\N	Eldrazi Tron	\N
10159	1321	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	269	X	\N	Izzet Affinity	\N
10160	1322	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	270	X	\N	Azorius Control	\N
10161	1035	11	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	271	X	Flexslot Diamond	Tameshi Belcher	\N
10162	423	11	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	272	X	\N	Domain Zoo	\N
10163	758	11	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	273	X	\N	Tameshi Belcher	\N
10164	503	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	274	X	\N	Esper Goryo's	\N
10165	215	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	275	X	\N	Domain Zoo	\N
10166	1323	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	276	X	Sanctum of All	Boros Energy	\N
10167	1324	11	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	277	X	Team Seedcore	Esper Goryo's	\N
10168	712	11	f	f	0	2	1	1	0	1	0	0	1	3	0	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	3	0	278	X	\N	Esper Blink	\N
10169	1325	11	f	f	0	2	1	1	0	1	0	0	1	2	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	2	0	279	X	Flexslot Diamond	Amulet Titan	\N
10170	1326	11	f	f	1	2	0	1	0	1	0	0	0	4	1	1	6	1	1-6-1	1	6	1	0	0	0	0	0	0	f	1	3	0	280	X	\N	Esper Goryo's	\N
10171	1046	11	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	281	X	Cosmos Heavy Play	Boros Energy	\N
10172	1055	11	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	282	X	Scryhard	Ascendancy Combo	\N
10173	1327	11	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	283	X	\N	Esper Goryo's	\N
10174	1328	11	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	284	X	\N	Tameshi Belcher	\N
10175	117	11	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	285	X	\N	Eldrazi Ramp	\N
10176	1178	11	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	286	X	\N	Amulet Titan	\N
10177	1121	11	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	287	X	Scryhard	Samwise Gamgee Combo	\N
10178	1059	11	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	288	X	Team Serious Player Only	Esper Midrange	\N
10179	1329	11	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	289	X	\N	Eldrazi Ramp	\N
10180	1330	11	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	290	X	\N	Boros Energy	\N
10181	482	11	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	3	0	291	X	Moriyama Japan	Tameshi Belcher	\N
10182	1331	11	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	292	X	\N	Gruul Broodscale	\N
10183	1159	11	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	293	X	Rampant Growth Heavy Play	Izzet Affinity	\N
10184	1332	11	f	f	0	2	1	1	0	1	0	0	0	2	0	0	4	1	0-4-1	0	4	1	0	0	0	0	0	0	f	0	3	0	294	X	\N	Amulet Titan	\N
10185	1333	11	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	295	X	\N	Jeskai Affinity	\N
10186	332	11	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	296	X	Scryhard	Boros Energy	\N
10187	649	11	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	297	X	Team TCGPlayer	Tameshi Belcher	\N
10188	516	11	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	298	X	Cosmos Heavy Play	Tameshi Belcher	\N
10189	142	11	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	299	X	SEA	Esper Goryo's	\N
7089	1502	8	t	f	2	4	0	2	0	2	0	0	3	5	0	5	9	0	5-9-0	4	3	0	1	6	0	0	0	0	f	3	6	0	57	Day 2	Milkshake	Golgari Midrange	4-3 overnight, out of contention before the return to Standard.
5495	158	7	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	156	X			
5800	573	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	222	X	Worldly Counsel		Eliminated in R7.
5510	1220	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	8	7	1	137	Day 2	CFB Ultimate Guard	Dimir Bounce	
7279	1220	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	55	Day 2	CFB Ultimate Guard	Izzet Prowess	
9904	165	11	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	4	2	0	14	Top 16	Worldly Counsel Heavy Play	Eldrazi Ramp	\N
10049	562	11	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	1	2	0	159	Day 2	Team TCGPlayer	Azorius Blink	\N
7287	562	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	63	Day 2	CFB Ultimate Guard	Izzet Prowess	
6694	781	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	113	Day 2			Even record both formats, both days.
10198	1445	12	t	f	3	3	0	2	1	1	0	0	7	1	0	10	4	0	10-4-0	5	2	0	5	2	0	0	0	0	t	5	3	1	9	Top 16	\N	Izzet Prowess	\N
6933	1060	9	t	f	2	3	1	2	0	1	0	0	6	4	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	4	0	126	Day 2		Azorius Oculus	
10029	1119	11	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	139	Day 2	Rampant Growth Heavy Play	Izzet Affinity	\N
6881	1119	9	t	f	3	3	0	2	1	1	1	1	8	1	1	11	4	1	11-4-1	8	0	0	3	4	1	0	0	0	f	8	3	1	15	Top 16		Orzhov Pixie	
10190	575	12	t	t	4	2	0	2	1	1	1	0	9	0	0	13	2	0	13-2-0	5	2	0	5	0	0	3	0	0	t	13	2	1	1	Champion	TCGplayer	Izzet Lessons	\N
10191	1226	12	t	t	5	1	0	2	2	0	1	0	7	4	0	12	5	0	12-5-0	5	2	0	5	2	0	2	1	0	t	5	2	1	2	Finals	\N	Izzet Lessons	\N
10192	365	12	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	5	2	0	5	1	0	1	1	0	t	4	2	0	3	Semifinals	Scryhard	Temur Otters	\N
10193	188	12	t	t	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	0	0	3	4	0	1	1	0	t	8	3	1	4	Semifinals	Worldly Counsel Heavy Play	Izzet Lessons	\N
10194	711	12	t	t	5	1	0	2	2	0	1	0	5	1	0	10	2	0	10-2-0	6	1	0	4	0	0	0	1	0	t	8	1	1	5	Top 8	TCGplayer	Izzet Lessons	\N
10195	202	12	t	t	5	1	0	2	2	0	1	0	5	2	0	10	3	0	10-3-0	5	2	0	5	0	0	0	1	0	t	6	1	1	6	Top 8	Cosmos Heavy Play	Izzet Looting	\N
10196	394	12	t	t	4	2	0	2	2	0	0	0	6	2	0	10	4	0	10-4-0	5	2	0	5	1	0	0	1	0	t	4	1	0	7	Top 8	Handshake Moxfield	Temur Otters	\N
10197	1031	12	t	t	4	2	0	2	1	1	1	0	6	2	0	10	4	0	10-4-0	4	3	0	6	0	0	0	1	0	t	7	1	1	8	Top 8	Moriyama Japan	Sultai Reanimator	\N
10200	588	12	t	f	3	2	1	2	1	0	0	0	6	2	0	9	4	1	9-4-1	5	2	0	4	2	1	0	0	0	f	4	1	0	11	Top 16	Moriyama Japan	Dimir Midrange	\N
10201	903	12	t	f	4	1	1	2	2	0	0	0	5	3	0	9	4	1	9-4-1	4	2	1	5	2	0	0	0	0	t	3	1	0	12	Top 16	\N	Jeskai Control	\N
10202	220	12	t	f	5	1	0	2	2	0	1	0	4	4	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	t	4	2	0	13	Top 16	Team 86	Izzet Lessons	\N
10203	743	12	t	f	5	1	0	2	2	0	1	0	4	4	0	9	5	0	9-5-0	6	1	0	3	4	0	0	0	0	t	5	2	1	14	Top 16	Sanctum of All	Temur Otters	\N
10204	217	12	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	5	2	0	4	4	0	0	0	0	t	3	1	0	15	Top 16	Cosmos Heavy Play	Bant Airbending	\N
10205	1106	12	t	f	5	1	0	2	2	0	1	0	4	4	0	9	5	0	9-5-0	6	1	0	3	4	0	0	0	0	t	5	3	1	16	Top 16	\N		\N
10206	661	12	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	4	2	0	17	Top 32	Moriyama Japan	Sultai Reanimator	\N
10207	77	12	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	3	1	0	18	Top 32	Sanctum of All	Jeskai Control	\N
10208	1201	12	t	f	4	2	0	2	1	1	1	0	5	3	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	f	4	3	0	19	Top 32	\N	Simic Ouroboroid	\N
10210	691	12	t	f	3	2	0	2	1	0	0	0	5	3	0	8	5	0	8-5-0	4	3	0	4	2	0	0	0	0	f	3	2	0	21	Top 32	Moriyama Japan	Sultai Reanimator	\N
10211	785	12	t	f	4	2	0	2	1	1	1	0	4	2	0	8	4	0	8-4-0	5	2	0	3	3	0	0	0	0	t	3	2	0	22	Top 32	Worldly Counsel Heavy Play	Temur Otters	\N
10212	1036	12	t	f	3	3	0	2	1	1	0	0	5	2	0	8	5	0	8-5-0	6	1	0	2	4	0	0	0	0	f	6	4	1	23	Top 32	Sanctum of All	Temur Otters	\N
10213	401	12	t	f	2	4	0	2	0	2	0	0	6	1	1	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	f	3	2	0	24	Top 32	Moriyama Japan	Jeskai Control	\N
10199	668	12	t	f	4	2	0	2	2	0	0	0	6	2	0	10	4	0	10-4-0	4	3	0	6	1	0	0	0	0	t	5	2	1	10	Top 16	TCGplayer	Izzet Lessons	\N
6877	1119	1	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	4	0	71	Day 2	Rampant Growth Heavy Play	Azorius Yorion	2-0 to 2-4 to making D2, then a solid 5-3, but never in the mix.
10214	931	12	t	f	4	2	0	2	1	1	1	0	4	3	1	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	f	3	3	0	25	Top 32	\N	Simic Otters	\N
10215	215	12	t	f	3	3	0	2	1	1	0	0	5	2	1	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	f	3	2	0	26	Top 32	\N	Izzet Prowess	\N
10216	349	12	t	f	4	2	0	2	1	1	1	0	4	4	0	8	6	0	8-6-0	6	1	0	2	5	0	0	0	0	f	5	4	1	27	Top 32	Moriyama Japan	Sultai Reanimator	\N
10217	816	12	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	t	4	2	0	28	Top 32	Handshake Moxfield	Golgari Ouroboroid	\N
10218	643	12	t	f	6	0	0	2	2	0	2	0	2	6	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	t	4	3	0	29	Top 32	Moriyama Japan	Simic Ouroboroid	\N
10219	1002	12	t	f	3	3	0	2	1	1	1	1	5	3	0	8	6	0	8-6-0	6	1	0	2	5	0	0	0	0	f	6	5	1	30	Top 32	Handshake Moxfield	Golgari Ouroboroid	\N
10220	769	12	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	3	0	31	Top 32	Rampant Growth Heavy Play	Dimir Midrange	\N
10221	476	12	t	f	5	1	0	2	2	0	1	0	3	5	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	4	2	0	32	Top 32	Team 86	Temur Otters	\N
7473	1341	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	249	x		Izzet Prowess	
10223	1302	12	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	2	3	0	34	Day 2	Sanctum of All	Jeskai Control	\N
10224	449	12	t	f	5	1	0	2	2	0	1	0	3	5	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	3	0	35	Day 2	Worldly Counsel Heavy Play	Bant Airbending	\N
10225	507	12	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	4	2	0	36	Day 2	Team 86	Izzet Lessons	\N
10226	1084	12	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	2	0	37	Day 2	Rampant Growth Heavy Play	Izzet Lessons	\N
10227	669	12	t	f	2	4	0	2	1	1	0	1	6	2	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	t	5	3	1	38	Day 2	TCGplayer	Izzet Lessons	\N
10228	565	12	t	f	1	5	0	2	0	2	0	1	7	1	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	4	3	0	39	Day 2	Cosmos Heavy Play	Izzet Looting	\N
10229	291	12	t	f	3	3	0	2	1	1	0	0	4	3	1	7	6	1	7-6-1	5	1	1	2	5	0	0	0	0	f	2	2	0	40	Day 2	Team 86	Jeskai Control	\N
10230	221	12	t	f	3	2	1	2	1	0	0	0	4	4	0	7	6	1	7-6-1	4	2	1	3	4	0	0	0	0	f	4	2	0	41	Day 2	Worldly Counsel Heavy Play	Izzet Lessons	\N
10231	228	12	t	f	4	2	0	2	2	0	0	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	3	0	42	Day 2	TCGplayer	Izzet Lessons	\N
10232	132	12	t	f	2	4	0	2	0	2	0	0	5	3	0	7	7	0	7-7-0	5	2	0	2	5	0	0	0	0	f	4	2	0	43	Day 2	\N	Bant Airbending	\N
10233	165	12	t	f	4	2	0	2	2	0	0	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	2	0	44	Day 2	Worldly Counsel Heavy Play	Temur Otters	\N
10234	200	12	t	f	4	2	0	2	2	0	0	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	4	0	45	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	\N
10235	121	12	t	f	1	5	0	2	0	2	0	1	6	2	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	4	0	46	Day 2	Double Infinity	Izzet Prowess	\N
10236	1194	12	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	2	0	47	Day 2	\N	Sultai Reanimator	\N
10237	1300	12	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	4	0	48	Day 2	\N	Izzet Looting	\N
10238	182	12	t	f	2	4	0	2	0	2	0	0	5	3	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	2	0	49	Day 2	TCGplayer	Izzet Lessons	\N
10239	890	12	t	f	1	5	0	2	0	2	0	1	6	2	0	7	7	0	7-7-0	5	2	0	2	5	0	0	0	0	f	4	3	0	50	Day 2	Worldly Counsel Heavy Play	Bant Airbending	\N
10240	451	12	t	f	4	2	0	2	1	1	1	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	4	5	0	51	Day 2	Handshake Moxfield	Temur Otters	\N
10241	82	12	t	f	2	4	0	2	1	1	0	1	5	3	0	7	7	0	7-7-0	5	2	0	2	5	0	0	0	0	f	2	5	0	52	Day 2	Team 86	Jeskai Control	\N
10243	1214	12	t	f	4	2	0	2	2	0	0	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	4	0	54	Day 2	Handshake Moxfield	Temur Otters	\N
10244	23	12	t	f	2	4	0	2	1	1	0	1	4	4	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	2	3	0	55	Day 2	\N	Izzet Lessons	\N
10245	569	12	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	3	0	56	Day 2	TCGplayer	Izzet Lessons	\N
10246	1279	12	t	f	3	3	0	2	1	1	0	0	2	5	0	5	8	0	5-8-0	4	3	0	1	5	0	0	0	0	f	2	3	0	57	Day 2	\N	Jeskai Artifacts	\N
10247	1216	12	t	f	4	2	0	2	1	1	1	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	3	0	58	Day 2	Worldly Counsel Heavy Play	Bant Airbending	\N
10248	282	12	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	2	3	0	59	Day 2	Handshake Moxfield	Temur Otters	\N
10249	935	12	t	f	0	5	0	2	0	2	0	1	5	3	0	5	8	0	5-8-0	4	3	0	1	5	1	0	0	0	f	4	3	0	60	Day 2	Cosmos Heavy Play	Mono-Red Aggro	\N
10250	633	12	t	f	3	3	0	2	1	1	1	1	2	6	0	5	9	0	5-9-0	5	2	0	0	7	0	0	0	0	f	4	7	0	61	Day 2	Scryhard	Temur Otters	\N
10251	1213	12	f	f	2	1	0	1	1	0	0	0	1	2	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	2	0	62	X	\N	Jeskai Control	\N
10252	809	12	f	f	1	1	1	1	0	0	0	0	2	2	0	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	3	0	63	X	Double Infinity	Simic Ouroboroid	\N
10222	525	12	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	t	4	2	0	33	Day 2	\N	Dimir Bounce	\N
10253	1277	12	f	f	1	1	1	1	0	0	0	0	2	1	1	3	2	2	3-2-2	3	3	1	0	0	0	0	0	0	f	3	2	0	64	X	\N	Izzet Prowess	\N
10254	1046	12	f	f	1	1	1	1	0	0	0	0	2	2	0	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	1	1	0	65	X	Cosmos Heavy Play	Bant Airbending	\N
10255	502	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	66	X	Handshake Moxfield	Golgari Ouroboroid	\N
10256	1019	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	4	0	67	X	\N	Izzet Prowess	\N
10257	818	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	68	X	\N	Simic Ouroboroid	\N
10259	811	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	70	X	\N	Jeskai Artifacts	\N
10260	162	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	71	X	Sanctum of All	Temur Otters	\N
10261	448	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	72	X	Team 86	Izzet Lessons	\N
10262	95	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	73	X	SEA	Izzet Looting	\N
10263	1087	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	74	X	Rampant Growth Heavy Play	Jeskai Artifacts	\N
10264	1008	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	75	X	TCGplayer	Izzet Lessons	\N
10265	679	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	76	X	Handshake Moxfield	Temur Otters	\N
10266	667	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	77	X	Rampant Growth Heavy Play	Izzet Prowess	\N
10267	1047	12	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	78	X	Team 86	Mono-Red Aggro	\N
10268	1037	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	1	0	79	X	\N	Orzhov Demons	\N
10269	832	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	80	X	Double Infinity	Dimir Bounce	\N
10270	329	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	3	0	81	X	Sanctum of All	Bant Airbending	\N
10271	1251	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	82	X	Worldly Counsel Heavy Play	Izzet Prowess	\N
10272	1280	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	83	X	Scryhard	Izzet Looting	\N
10273	406	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	84	X	Moriyama Japan	Jeskai Control	\N
10274	723	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	85	X	Worldly Counsel Heavy Play	Bant Airbending	\N
10275	543	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	3	0	86	X	\N	Izzet Looting	\N
10276	18	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	87	X	\N	Mono-Red Aggro	\N
10278	1215	12	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	89	X	Moriyama Japan	Izzet Looting	\N
10279	929	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	90	X	\N	Izzet Lessons	\N
10280	99	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	91	X	Rampant Growth Heavy Play	Temur Otters	\N
10281	123	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	4	0	92	X	\N	Bant Airbending	\N
10282	1187	12	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	93	X	Team 86	Temur Otters	\N
10283	341	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	94	X	Handshake Moxfield	Golgari Ouroboroid	\N
10284	468	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	1	0	95	X	Worldly Counsel Heavy Play	Izzet Lessons	\N
10285	261	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	96	X	Handshake Moxfield	Golgari Ouroboroid	\N
10286	1273	12	f	f	0	2	1	1	0	1	0	0	2	2	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	3	0	97	X	\N	Dimir Bounce	\N
10287	831	12	f	f	0	2	1	1	0	1	0	0	2	2	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	4	0	98	X	Handshake Moxfield	Temur Otters	\N
10288	1245	12	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	99	X	Scryhard	Izzet Lessons	\N
10289	398	12	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	100	X	Cosmos Heavy Play	Izzet Looting	\N
10290	1313	12	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	101	X	Sanctum of All	Jeskai Control	\N
10291	937	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	102	X	Double Infinity	Jeskai Artifacts	\N
10258	562	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	69	X	TCGplayer	Izzet Lessons	\N
10277	299	12	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	88	X	\N	Simic Ouroboroid	\N
10292	765	12	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	103	X	Cosmos Heavy Play	Bant Airbending	\N
10293	1060	12	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	104	X	Worldly Counsel Heavy Play	Bant Airbending	\N
10294	1090	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	105	X	Scryhard	Boros Mobilize	\N
10295	830	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	106	X	Rampant Growth Heavy Play	Izzet Lessons	\N
10296	732	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	107	X	\N	Sultai Reanimator	\N
10297	1337	12	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	108	X	Sanctum of All	Bant Airbending	\N
10298	490	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	109	X	Handshake Moxfield	Temur Otters	\N
10299	684	12	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	110	X	Rampant Growth Heavy Play	Izzet Looting	\N
10300	1220	12	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	111	X	TCGplayer	Izzet Lessons	\N
10301	186	12	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	112	X	Team 86	Izzet Lessons	\N
10302	1256	12	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	113	X	Cosmos Heavy Play	Izzet Looting	\N
5236	10	5	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	108	Day 2	Bus Stop		Solid 6-4 in Pioneer, but 2-4 in Draft.
10304	1048	12	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	115	X	Team 86	Temur Otters	\N
10305	447	12	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	116	X	Cosmos Heavy Play	Bant Airbending	\N
10306	1341	12	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	117	X	\N	Izzet Prowess	\N
10307	1107	12	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	118	X	Sanctum of All	Bant Airbending	\N
10308	101	12	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	119	X	Team 86	Jeskai Control	\N
10309	728	12	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	120	X	\N	Izzet Looting	\N
10310	780	12	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	121	X	Cosmos Heavy Play	Bant Airbending	\N
10311	138	12	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	122	X	\N	Simic Ouroboroid	\N
10312	545	12	f	f	0	3	0	1	0	1	0	1	1	1	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	123	X	\N	Izzet Looting	\N
10313	1182	12	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	124	X	Double Infinity	Simic Ouroboroid	\N
10314	1305	12	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	125	X	\N	Izzet Looting	\N
10315	226	12	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	126	X	Rampant Growth Heavy Play	Izzet Looting	\N
10303	1206	12	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	2	0	114	X	SEA	Bant Airbending	\N
9891	1445	11	t	t	4	2	0	2	1	1	1	0	11	1	0	15	3	0	15-3-0	7	1	0	5	2	0	3	0	0	t	5	2	1	1	Champion	Team Serious Player Only	Tameshi Belcher	\N
6784	728	2	t	f	5	0	1	2	2	0	1	0	6	4	0	11	4	1	11-4-1	7	1	0	4	3	1	0	0	0	f	7	3	1	10	Top 16	Rampant Growth Heavy Play		Almost perfect in Draft at 5-0-1, and opened up 7-0, but 4-4-1 from there left him just short of the Top 8.
10209	1119	12	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	f	3	2	0	20	Top 32	Rampant Growth Heavy Play	Golgari Dragons	\N
10922	882	14	t	t	5	1	0	2	2	0	1	0	10	3	0	15	4	0	15-4-0	8	0	0	4	4	0	1	3	0	f	9	2	1	1	Champion	Cosmos Heavy Play	Selesnya Landfall	\N
10923	513	14	t	t	4	2	0	2	1	0	1	0	11	2	0	15	4	0	15-4-0	7	1	0	5	2	0	1	2	1	f	7	2	1	2	Finals	Cosmos Heavy Play	Selesnya Landfall	\N
10924	1036	14	t	t	6	0	0	2	2	0	2	0	7	2	0	13	2	0	13-2-0	7	1	0	5	0	0	1	1	1	f	7	1	1	3	Semifinals	Sanctum of All	Izzet Lessons	\N
10925	668	14	t	t	5	1	0	2	2	0	1	0	8	2	0	13	3	0	13-3-0	7	1	0	5	1	0	1	1	1	f	8	1	1	4	Semifinals	TCGplayer	Selesnya Ouroboroid	\N
10926	831	14	t	t	6	0	0	2	2	0	2	0	6	4	0	12	4	0	12-4-0	6	2	0	6	1	0	1	0	1	f	5	1	1	5	Top 8	Handshake Moxfield	Mono-Green Landfall	\N
10927	484	14	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	1	0	1	0	1	f	9	2	1	6	Top 8	Handshake Moxfield	Izzet Spellementals	\N
10928	1618	14	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	6	2	0	6	2	0	1	0	1	f	6	1	1	7	Top 8	\N	Mono-Green Landfall	\N
10929	261	14	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	6	2	0	6	2	0	1	0	1	f	6	2	1	8	Top 8	Handshake Moxfield	Azorius Tempo	\N
10930	291	14	t	f	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	2	0	1	0	0	f	3	2	0	9	Top 16	Merlion	Mono-Green Landfall	\N
10931	447	14	t	f	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	6	2	0	6	2	0	1	0	0	f	4	1	0	10	Top 16	Cosmos Heavy Play	Izzet Prowess	\N
10932	269	14	t	f	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	2	0	1	0	0	f	5	2	1	11	Top 16	Cosmos Heavy Play	Selesnya Landfall	\N
10933	785	14	t	f	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	5	3	0	7	1	0	1	0	0	f	4	1	0	12	Top 16	Worldly Counsel Heavy Play	Jeskai Control	\N
10934	217	14	t	f	4	1	1	2	1	0	1	0	7	3	0	11	4	1	11-4-1	5	3	0	6	1	1	0	0	0	f	5	3	1	13	Top 16	Cosmos Heavy Play	Selesnya Landfall	\N
10935	765	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	1	0	0	f	6	2	1	14	Top 16	Undying Baguette	Izzet Prowess	\N
10936	182	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	1	0	0	f	4	2	0	15	Top 16	TCGplayer	Izzet Prowess	\N
10937	468	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	3	2	0	16	Top 16	Worldly Counsel Heavy Play	Mono-Green Landfall	\N
10938	1634	14	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	f	7	3	1	17	Top 32	Drawing Board	Izzet Prowess	\N
10939	1133	14	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	5	1	1	18	Top 32	\N	Mono-Green Landfall	\N
10940	1644	14	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	4	2	0	19	Top 32	No Team	Boros Dragons	\N
10941	1019	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	5	1	1	20	Top 32	\N	Izzet Prowess	\N
10942	569	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	1	0	0	f	9	2	1	21	Top 32	TCGplayer	Izzet Prowess	\N
10943	516	14	t	f	4	2	0	2	1	0	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	1	0	0	f	4	2	0	22	Top 32	Cosmos Heavy Play	Izzet Prowess	\N
10944	1110	14	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	5	3	1	23	Top 32	The Coalition	Mono-Green Landfall	\N
10945	1648	14	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	3	1	0	24	Top 32	Worldly Counsel Heavy Play	Izzet Prowess	\N
10946	937	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	1	0	0	f	4	2	0	25	Top 32	Double Infinity	Izzet Spellementals	\N
10947	1527	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	6	2	1	26	Top 32	Undying Baguette	Izzet Prowess	\N
10948	394	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	2	1	27	Top 32	Handshake Moxfield	Mono-Green Landfall	\N
10949	779	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	28	Top 32	Drawing Board	Izzet Prowess	\N
10950	1119	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	6	3	1	29	Top 32	Rampant Growth	Mono-Green Landfall	\N
10951	1085	14	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	1	0	0	f	5	1	1	30	Top 32	Main Phase	Mardu Discard	\N
10952	1575	14	t	f	2	4	0	2	1	1	0	1	9	1	0	11	5	0	11-5-0	5	3	0	6	2	0	1	0	0	f	6	3	1	31	Top 32	\N	Dimir Excruciator	\N
10953	811	14	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	6	3	1	32	Top 32	Cosmos Heavy Play	Selesnya Landfall	\N
10954	329	14	t	f	3	3	0	2	1	1	1	1	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	1	0	0	f	8	3	1	33	Day 2	Merlion	Mono-Green Landfall	\N
10955	744	14	t	f	2	3	1	2	1	1	0	1	8	2	0	10	5	1	10-5-1	7	0	1	3	5	0	0	0	0	f	7	3	1	34	Day 2	Rampant Growth	Mono-Green Landfall	\N
10956	1216	14	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	7	1	0	3	5	0	1	0	0	f	6	3	1	35	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	\N
10957	406	14	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	1	0	0	f	5	2	1	36	Day 2	Moriyama Japan	Izzet Spellementals	\N
10958	587	14	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	37	Day 2	Pluto	Izzet Prowess	\N
10242	1346	12	t	f	3	2	1	2	1	0	0	0	3	5	0	6	7	1	6-7-1	5	2	0	1	5	1	0	0	0	f	5	5	1	53	Day 2	Scryhard	Temur Otters	\N
10959	1227	14	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	5	3	0	5	3	0	1	0	0	f	5	3	1	38	Day 2	Rampant Growth	Izzet Prowess	\N
10960	523	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	3	1	39	Day 2	Worldly Counsel Heavy Play	Simic Omniscience	\N
10961	1445	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	40	Day 2	Cosmos Heavy Play	Izzet Spellementals	\N
10962	1585	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	41	Day 2	Rampant Growth	Mono-Green Landfall	\N
10963	1632	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	42	Day 2	Rampant Growth	Azorius Tempo	\N
10964	202	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	1	0	43	Day 2	Undying Baguette	Izzet Prowess	\N
10965	545	14	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	44	Day 2	\N	Izzet Prowess	\N
10966	312	14	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	45	Day 2	\N	Izzet Lessons	\N
10967	1560	14	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	46	Day 2	\N	Jeskai Control	\N
10968	499	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	f	8	4	1	47	Day 2	TCGplayer	Izzet Prowess	\N
10969	1606	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	48	Day 2	Main Phase	Mardu Discard	\N
10970	780	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	7	2	1	49	Day 2	Merlion	Izzet Lessons	\N
10971	1018	14	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	50	Day 2	\N	Izzet Prowess	\N
10972	704	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	3	1	51	Day 2	(Small Japanese Team)	Izzet Prowess	\N
10973	830	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	1	1	52	Day 2	Rampant Growth	Izzet Prowess	\N
10974	1607	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	53	Day 2	Pillow Fort	Dimir Excruciator	\N
10975	1226	14	t	f	4	2	0	2	1	0	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	4	0	0	0	0	f	5	2	1	54	Day 2	Moriyama Japan	Sultai Control	\N
10976	1511	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	55	Day 2	Drawing Board	Mono-Green Landfall	\N
10977	288	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	56	Day 2	Sanctum of All	Izzet Spellementals	\N
10978	650	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	57	Day 2	\N	Izzet Prowess	\N
10979	1410	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	1	1	58	Day 2	Rampant Growth	Izzet Prowess	\N
10980	1639	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	2	1	59	Day 2	\N	Izzet Prowess	\N
10981	1615	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	60	Day 2	Rampant Growth	Izzet Prowess	\N
10982	885	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	3	1	61	Day 2	Rampant Growth	Izzet Prowess	\N
10983	1630	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	62	Day 2	Undying Baguette	Mono-Green Landfall	\N
10984	1049	14	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	63	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	\N
10985	1532	14	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	2	2	0	64	Day 2	Little Italy	Izzet Lessons	\N
10986	1013	14	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	6	3	1	65	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
10987	1611	14	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	66	Day 2	Lingering Souls	Mono-Red Aggro	\N
10988	1165	14	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	2	1	67	Day 2	Drawing Board	Izzet Prowess	\N
10989	347	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	68	Day 2	Tase	Bant Rhythm	\N
10990	1057	14	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	69	Day 2	Drawing Board	Selesnya Rhythm	\N
10991	1007	14	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	70	Day 2	Drawing Board	Mono-Green Landfall	\N
10992	1368	14	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	4	2	0	71	Day 2	\N	Izzet Prowess	\N
10993	1514	14	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	3	2	0	72	Day 2	\N	Mono-Green Landfall	\N
10994	1222	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	2	1	73	Day 2	Merlion	Mono-Green Landfall	\N
5847	347	3	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	261	X			Kept going, and got a match win R6.
5848	347	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	176	X	Japan 2		Lost the last two from 3-3 to miss D2.
5849	347	6	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	40	Day 2	Kenji		Out of contention at the end of R9, but then won six of the last seven.
10995	398	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	74	Day 2	Moriyama Japan	Izzet Spellementals	\N
10996	1582	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	75	Day 2	\N	Mono-Green Landfall	\N
10997	700	14	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	4	0	76	Day 2	The Coalition	Four-Color Elementals	\N
10998	1649	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	1	0	77	Day 2	Pluto	Izzet Prowess	\N
10999	998	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	78	Day 2	Rampant Growth	Izzet Prowess	\N
11000	466	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	79	Day 2	\N	Selesnya Rhythm	\N
11001	1597	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	80	Day 2	No Team	Azorius Momo	\N
11002	1523	14	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	4	0	81	Day 2	\N	Izzet Prowess	\N
11003	850	14	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	82	Day 2	TCGplayer	Izzet Prowess	\N
11004	1219	14	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	5	0	83	Day 2	Cosmos Heavy Play	Selesnya Landfall	\N
11005	1234	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	7	4	1	84	Day 2	Merlion	Mono-Green Landfall	\N
11006	1388	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	1	0	85	Day 2	Sanctum of All	Izzet Lessons	\N
11007	605	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	86	Day 2	Double Infinity	Izzet Prowess	\N
11008	1519	14	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	6	0	87	Day 2	\N	Izzet Prowess	\N
11009	1432	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	1	0	88	Day 2	Cosmos Heavy Play	Selesnya Landfall	\N
11010	1008	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	3	1	89	Day 2	TCGplayer	Azorius Momo	\N
11011	1517	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	6	0	90	Day 2	Undying Baguette	Mono-Green Landfall	\N
11012	1650	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	91	Day 2	TCGplayer	Izzet Prowess	\N
11013	717	14	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	92	Day 2	Undying Baguette	Jeskai Control	\N
11014	451	14	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	5	1	93	Day 2	Cosmos Heavy Play	Izzet Spellementals	\N
11015	1564	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	94	Day 2	\N	Mono-Green Landfall	\N
11016	204	14	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	95	Day 2	Cruelest Ultimatum	Four-Color Control	\N
11017	1631	14	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	96	Day 2	No Team	Azorius Momo	\N
11018	1365	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	97	Day 2	The Coalition	Mono-Green Landfall	\N
11019	1626	14	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	98	Day 2	Cosmos Heavy Play	Selesnya Landfall	\N
11020	1529	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	99	Day 2	Drawing Board	Izzet Prowess	\N
11021	1591	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	100	Day 2	\N	Mono-Green Landfall	\N
11022	588	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	101	Day 2	Moriyama Japan	Izzet Spellementals	\N
11023	1441	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	102	Day 2	Drawing Board	Mono-Green Landfall	\N
11024	935	14	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	103	Day 2	Cosmos Heavy Play	Mono-Red Aggro	\N
11025	239	14	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	104	Day 2	Rampant Growth	Izzet Prowess	\N
11026	920	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	105	Day 2	Worldly Counsel Heavy Play	Simic Omniscience	\N
11027	385	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	106	Day 2	\N	Izzet Lessons	\N
11028	1228	14	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	107	Day 2	Moriyama Japan	Izzet Spellementals	\N
11029	162	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	108	Day 2	Sanctum of All	Izzet Spellementals	\N
5227	7	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	304	x		Domain Overlords	
11030	99	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	109	Day 2	Cosmos Heavy Play	Bant Rhythm	\N
11031	1550	14	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	110	Day 2	Undying Baguette	Mono-Green Landfall	\N
11032	1009	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	111	Day 2	TCGplayer	Izzet Prowess	\N
11033	1453	14	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	112	Day 2	Swampwalk	Izzet Prowess	\N
11034	1407	14	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	1	0	113	Day 2	\N	Mono-Green Landfall	\N
11035	600	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	114	Day 2	Worldly Counsel Heavy Play	Mono-Green Landfall	\N
11036	661	14	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	115	Day 2	Moriyama Japan	Sultai Control	\N
11037	1554	14	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	116	Day 2	Main Phase	Izzet Spellementals	\N
11038	1500	14	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	117	Day 2	Cruelest Ultimatum	Mono-Green Landfall	\N
11039	1548	14	t	f	3	2	1	2	1	0	0	0	5	5	0	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	3	2	0	118	Day 2	\N	Mono-Green Landfall	\N
11040	1074	14	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	4	6	0	119	Day 2	Double Infinity	Dimir Excruciator	\N
11041	1515	14	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	6	5	0	120	Day 2	\N	Azorius Momo	\N
11042	1633	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	121	Day 2	Pillow Fort	Azorius Tempo	\N
11043	403	14	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	6	0	122	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
11044	1583	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	123	Day 2	\N	Izzet Prowess	\N
11045	1309	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	124	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
11046	1030	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	125	Day 2	\N	Izzet Prowess	\N
11047	684	14	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	126	Day 2	Cosmos Heavy Play	Izzet Spellementals	\N
11048	1642	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	127	Day 2	\N	Izzet Prowess	\N
11049	1596	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	128	Day 2	The Coalition	Golgari Midrange	\N
11050	1541	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	129	Day 2	Rampant Growth	Izzet Prowess	\N
11051	1605	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	130	Day 2	The Coalition	Golgari Midrange	\N
11052	433	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	131	Day 2	Worldly Counsel Heavy Play	Jeskai Control	\N
11053	1402	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	132	Day 2	\N	Izzet Spellementals	\N
11054	1048	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	4	0	133	Day 2	Drawing Board	Izzet Prowess	\N
11055	1096	14	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	134	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
11056	1052	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	135	Day 2	Drawing Board	Izzet Prowess	\N
11057	809	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	136	Day 2	Pluto	Izzet Prowess	\N
11058	1225	14	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	5	0	137	Day 2	No Team	Mono-Green Landfall	\N
11059	1586	14	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	138	Day 2	The Coalition	Golgari Midrange	\N
11060	643	14	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	5	0	139	Day 2	Moriyama Japan	Izzet Spellementals	\N
11061	188	14	t	f	1	5	0	2	0	2	0	1	6	3	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	5	0	140	Day 2	Worldly Counsel Heavy Play	Jeskai Control	\N
11062	1422	14	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	141	Day 2	Pluto	Rakdos Discard	\N
11063	769	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	142	Day 2	Rampant Growth	Izzet Prowess	\N
11064	1002	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	143	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
11065	247	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	144	Day 2	Merlion	Azorius Momo	\N
11066	1534	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	145	Day 2	Sanctum of All	Izzet Maestro	\N
11067	248	14	t	f	1	4	0	2	0	2	0	0	7	3	0	8	7	0	8-7-0	4	3	0	3	5	0	0	0	0	f	4	3	0	146	Day 2	Worldly Counsel Heavy Play	Mono-Green Landfall	\N
11068	1530	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	147	Day 2	TCGplayer	Mono-Green Landfall	\N
11069	1289	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	148	Day 2	The Coalition	Golgari Midrange	\N
11070	1456	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	149	Day 2	Worldly Counsel Heavy Play	Simic Omniscience	\N
11071	1651	14	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	150	Day 2	Lingering Souls	Izzet Lessons	\N
11072	282	14	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	5	3	1	151	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
11073	1399	14	t	f	3	2	0	2	1	1	0	0	4	6	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	2	0	152	Day 2	Sanctum of All	Izzet Maestro	\N
11074	1189	14	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	153	Day 2	\N	Mono-Green Landfall	\N
11075	1039	14	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	154	Day 2	\N	Izzet Prowess	\N
11076	1537	14	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	155	Day 2	Undying Baguette	Mono-Green Landfall	\N
11077	1062	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	156	Day 2	Cosmos Heavy Play	Selesnya Landfall	\N
11078	562	14	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	157	Day 2	TCGplayer	Selesnya Ouroboroid	\N
11079	893	14	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	158	Day 2	Handshake Moxfield	Mono-Green Landfall	\N
11080	154	14	t	f	4	2	0	2	2	0	0	0	3	6	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	2	3	0	159	Day 2	\N	Izzet Prowess	\N
11081	1641	14	t	f	3	3	0	2	1	1	0	0	4	5	0	7	8	0	7-8-0	5	3	0	2	5	0	0	0	0	f	2	3	0	160	Day 2	\N	Izzet Lessons	\N
11082	1594	14	t	f	1	4	1	2	0	2	0	0	6	4	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	2	0	161	Day 2	Undying Baguette	Izzet Prowess	\N
11083	1316	14	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	5	4	1	162	Day 2	Main Phase	Mardu Discard	\N
11084	1613	14	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	163	Day 2	The Coalition	Temur Omniscience	\N
11085	1543	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	3	0	164	Day 2	Little Italy	Izzet Spellementals	\N
11086	101	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	165	Day 2	Merlion	Azorius Momo	\N
11087	228	14	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	5	0	166	Day 2	TCGplayer	Izzet Prowess	\N
11088	1645	14	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	167	Day 2	\N	Izzet Prowess	\N
11089	1518	14	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	7	4	0	168	Day 2	Undying Baguette	Izzet Spellementals	\N
11090	1217	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	5	0	169	Day 2	Cosmos Heavy Play	Selesnya Landfall	\N
11091	1600	14	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	5	0	170	Day 2	Sanctum of All	Izzet Lessons	\N
11092	1050	14	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	2	6	0	0	0	0	f	2	3	0	171	Day 2	Double Infinity	Dimir Excruciator	\N
11093	109	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	172	Day 2	Little Italy	Four-Color Elementals	\N
11094	1621	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	173	Day 2	\N	Izzet Lessons	\N
11095	1578	14	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	174	Day 2	No Team	Izzet Lessons	\N
11096	1390	14	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	175	Day 2	Sanctum of All	Mono-Green Landfall	\N
11097	260	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	176	Day 2	Sanctum of All	Izzet Spellementals	\N
11098	1540	14	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	177	Day 2	Main Phase	Izzet Prowess	\N
11099	1559	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	5	0	178	Day 2	The Coalition	Golgari Midrange	\N
11100	1099	14	t	f	1	4	0	2	0	2	0	0	5	5	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	2	0	179	Day 2	\N		\N
11101	1377	14	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	6	0	180	Day 2	Double Infinity	Mono-Green Landfall	\N
11102	200	14	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	2	0	181	Day 2	Worldly Counsel Heavy Play	Mono-Green Landfall	\N
11103	1544	14	t	f	2	4	0	2	0	2	0	0	4	5	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	3	5	0	182	Day 2	\N	Izzet Prowess	\N
11104	723	14	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	183	Day 2	Worldly Counsel Heavy Play	Mono-Green Landfall	\N
11105	1516	14	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	184	Day 2	Lingering Souls	Izzet Spellementals	\N
11106	221	14	t	f	1	4	0	2	0	2	0	0	5	5	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	3	0	185	Day 2	Handshake Moxfield	Azorius Tempo	\N
11107	1232	14	t	f	3	2	1	2	1	0	0	0	3	7	0	6	9	1	6-9-1	5	3	0	1	6	1	0	0	0	f	2	5	0	186	Day 2	Drawing Board	Izzet Prowess	\N
11108	706	14	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	6	0	187	Day 2	Moriyama Japan	Sultai Control	\N
11109	1277	14	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	188	Day 2	Double Infinity	Jeskai Control	\N
11110	1652	14	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	2	6	0	189	Day 2	Pluto	Izzet Prowess	\N
11111	1635	14	t	f	3	3	0	2	1	1	1	1	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	190	Day 2	\N	Izzet Prowess	\N
11112	1223	14	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	191	Day 2	Undying Baguette	Bant Airbending	\N
11113	1525	14	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	192	Day 2	\N	Azorius Tempo	\N
11114	320	14	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	3	3	0	193	Day 2	Worldly Counsel Heavy Play	Jeskai Control	\N
11115	1513	14	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	194	Day 2	Drawing Board	Izzet Prowess	\N
11116	903	14	t	f	3	3	0	2	1	1	0	0	3	4	0	6	7	0	6-7-0	4	4	0	2	3	0	0	0	0	f	2	2	0	195	Day 2	\N	Golgari Midrange	\N
11117	82	14	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	196	Day 2	Merlion	Izzet Lessons	\N
11118	107	14	t	f	2	4	0	2	1	1	0	1	3	7	0	5	11	0	5-11-0	5	3	0	0	8	0	0	0	0	f	2	9	0	197	Day 2	Worldly Counsel Heavy Play	Jeskai Control	\N
11119	663	14	t	f	3	3	0	2	1	1	0	0	2	5	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	2	4	0	198	Day 2	\N	Izzet Prowess	\N
11120	1378	14	t	f	1	5	0	2	0	2	0	1	4	5	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	5	0	199	Day 2	\N	Izzet Prowess	\N
11121	1508	14	t	f	0	6	0	2	0	2	0	2	5	5	0	5	11	0	5-11-0	4	4	0	1	7	0	0	0	0	f	4	5	0	200	Day 2	\N	Izzet Spellementals	\N
11122	1573	14	t	f	2	4	0	2	1	1	0	1	2	5	0	4	9	0	4-9-0	4	4	0	0	5	0	0	0	0	f	3	5	0	201	Day 2	\N	Izzet Lessons	\N
11123	1563	14	t	f	1	4	1	2	0	2	0	0	3	2	0	4	6	1	4-6-1	4	4	0	0	2	1	0	0	0	f	2	2	0	202	Day 2	\N	Simic Omniscience	\N
11124	1592	14	t	f	1	5	0	2	0	2	0	1	3	2	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	2	3	0	203	Day 2	\N	Izzet Prowess	\N
11125	165	14	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	204	X	Worldly Counsel Heavy Play	Jeskai Control	\N
11126	457	14	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	205	X	Swampwalk	Bant Omniscience	\N
11127	1628	14	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	5	0	206	X	Drawing Board	Mono-Green Landfall	\N
11128	448	14	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	5	0	207	X	Merlion	Mono-Green Landfall	\N
11129	1623	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	208	X	\N	Simic Omniscience	\N
11130	341	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	209	X	Handshake Moxfield	Mono-Green Landfall	\N
11131	1512	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	210	X	\N	Jeskai Control	\N
11132	1556	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	211	X	The Coalition	Izzet Lessons	\N
11133	621	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	212	X	Handshake Moxfield	Izzet Prowess	\N
11134	1406	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	213	X	Moriyama Japan	Sultai Control	\N
11135	215	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	214	X	Swampwalk	Izzet Prowess	\N
11136	912	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	215	X	Tase	Azorius Momo	\N
11137	1533	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	216	X	Sanctum of All	Izzet Maestro	\N
11138	1521	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	217	X	Drawing Board	Izzet Prowess	\N
11139	939	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	218	X	\N		\N
11140	1570	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	219	X	\N	Four-Color Control	\N
11141	426	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	220	X	Main Phase	Mono-Green Landfall	\N
11142	1555	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	221	X	\N	Izzet Prowess	\N
11143	1614	14	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	5	0	222	X	\N	Jeskai Control	\N
11144	1547	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	223	X	Drawing Board	Mono-Green Landfall	\N
11145	1475	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	224	X	Drawing Board	Izzet Prowess	\N
11146	1416	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	225	X	Merlion	Azorius Momo	\N
11147	1562	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	226	X	Sanctum of All	Izzet Lessons	\N
11148	1106	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	227	X	\N	Izzet Prowess	\N
11149	1466	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	3	0	228	X	Merlion	Mono-Green Landfall	\N
11150	1509	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	5	0	229	X	Sanctum of All	Izzet Spellementals	\N
11151	423	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	230	X	\N	Izzet Spellementals	\N
11152	226	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	231	X	Rampant Growth	Izzet Prowess	\N
11153	667	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	232	X	Cosmos Heavy Play	Izzet Spellementals	\N
11154	1037	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	233	X	\N	Izzet Prowess	\N
11155	679	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	234	X	Handshake Moxfield	Mono-Green Landfall	\N
11156	48	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	4	0	235	X	Little Italy	Jeskai Control	\N
11157	1604	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	236	X	\N	Izzet Prowess	\N
11158	1202	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	4	0	237	X	Main Phase	Simic Rhythm	\N
11159	549	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	238	X	\N	Izzet Spellementals	\N
11160	1571	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	239	X	Rampant Growth	Izzet Lessons	\N
11161	1047	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	240	X	Cruelest Ultimatum	Mono-Red Aggro	\N
11162	1220	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	241	X	TCGplayer	Izzet Prowess	\N
11163	575	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	242	X	TCGplayer	Izzet Prowess	\N
11164	1584	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	3	0	243	X	\N	Izzet Lessons	\N
11165	1567	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	244	X	\N	Izzet Prowess	\N
11166	1520	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	1	3	0	245	X	Sanctum of All	Izzet Spellementals	\N
11167	1601	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	246	X	Sanctum of All	Izzet Maestro	\N
11168	1451	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	247	X	Main Phase	Mono-Green Landfall	\N
11169	539	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	248	X	Drawing Board	Mono-Green Landfall	\N
11170	851	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	5	0	249	X	Merlion	Mono-Green Landfall	\N
11171	743	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	250	X	Sanctum of All	Izzet Maestro	\N
11172	238	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	2	0	251	X	Double Infinity	Four-Color Elementals	\N
11173	1031	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	3	4	0	252	X	Moriyama Japan	Sultai Control	\N
11174	1640	14	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	5	0	253	X	Sanctum of All	Izzet Maestro	\N
11175	1625	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	254	X	Sanctum of All	Izzet Prowess	\N
11176	1549	14	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	255	X	(Small Japanese Team)	Izzet Prowess	\N
11177	876	14	f	f	0	2	0	1	0	1	0	0	2	3	0	2	5	0	2-5-0	3	4	1	0	0	0	0	0	0	f	1	2	0	256	X	TCGplayer	Izzet Prowess	\N
11178	1580	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	257	X	\N	Izzet Prowess	\N
11179	1215	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	258	X	Moriyama Japan	Izzet Prowess	\N
11180	1086	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	259	X	Double Infinity	Izzet Lessons	\N
11181	1536	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	3	0	260	X	Handshake Moxfield	Mono-Green Landfall	\N
11182	1595	14	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	261	X	\N	Izzet Prowess	\N
11183	1557	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	5	0	262	X	(Small Japanese Team)	Izzet Prowess	\N
11184	1553	14	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	263	X	Pillow Fort	Dimir Excruciator	\N
11185	988	14	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	4	1	0	0	0	0	0	0	f	2	4	0	264	X	Merlion	Izzet Lessons	\N
11186	132	14	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	265	X	\N	Izzet Prowess	\N
11187	1531	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	1	0	0	0	0	0	0	f	1	3	0	266	X	Merlion	Azorius Momo	\N
11188	1653	14	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	267	X	\N	Dimir Midrange	\N
11189	1629	14	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	268	X	\N	Izzet Prowess	\N
11190	125	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	269	X	Double Infinity	Izzet Lessons	\N
11191	45	14	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	270	X	Cosmos Heavy Play	Izzet Prowess	\N
11192	601	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	271	X	Worldly Counsel Heavy Play	Izzet Lessons	\N
11193	1526	14	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	272	X	\N	Temur Lute	\N
11194	1576	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	273	X	\N	Mono-Green Landfall	\N
11195	1502	14	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	274	X	\N	Izzet Prowess	\N
11196	1620	14	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	275	X	The Coalition	Golgari Midrange	\N
11197	1587	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	276	X	\N	Izzet Prowess	\N
11198	72	14	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	277	X	Cosmos Heavy Play	Selesnya Landfall	\N
11199	767	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	278	X	Rampant Growth	Dimir Excruciator	\N
11200	1510	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	279	X	\N	Golgari Control	\N
11201	735	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	280	X	\N	Azorius Tempo	\N
11202	993	14	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	281	X	Sanctum of All	Izzet Maestro	\N
11203	1524	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	282	X	Lingering Souls	Izzet Prowess	\N
11204	1056	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	283	X	Merlion	Izzet Prowess	\N
11205	1593	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	284	X	\N	Izzet Lessons	\N
11206	1627	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	285	X	\N	Izzet Lessons	\N
11207	1425	14	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	286	X	\N	Mono-Green Landfall	\N
11208	816	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	287	X	Handshake Moxfield	Mono-Green Landfall	\N
11209	1569	14	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	288	X	Merlion	Azorius Momo	\N
11210	1459	14	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	289	X	\N	Selesnya Rhythm	\N
11211	1574	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	290	X	The Coalition	Golgari Midrange	\N
11212	1551	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	291	X	\N	Izzet Prowess	\N
11213	1646	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	292	X	\N	Izzet Spellementals	\N
11214	1619	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	293	X	\N	Four-Color Elementals	\N
11215	678	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	294	X	Main Phase	Izzet Prowess	\N
11216	1612	14	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	295	X	Sanctum of All	Izzet Maestro	\N
11217	1608	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	296	X	\N	Mono-Green Landfall	\N
11218	1622	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	297	X	\N	Izzet Prowess	\N
11219	1181	14	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	298	X	Sanctum of All	Four-Color Control	\N
11220	1602	14	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	299	X	Double Infinity	Boros Dragons	\N
11221	1616	14	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	1	0	0	0	0	0	0	f	1	4	0	300	X	No Team	Azorius Momo	\N
11222	365	14	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	301	X	Rampant Growth	Mono-Green Landfall	\N
11223	1539	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	302	X	Swampwalk	Izzet Prowess	\N
11224	1589	14	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	3	0	303	X	\N	Mono-Green Landfall	\N
11225	1046	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	304	X	TCGplayer	Izzet Prowess	\N
11226	1566	14	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	305	X	\N	Simic Rhythm	\N
11227	1413	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	306	X	Cruelest Ultimatum	Boros Discard	\N
11228	1528	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	307	X	TCGplayer	Azorius Momo	\N
11229	1610	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	308	X	\N	Izzet Prowess	\N
11230	1084	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	309	X	Merlion	Izzet Lessons	\N
11231	947	14	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	310	X	Rampant Growth	Azorius Tempo	\N
11232	1522	14	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	311	X	\N	Izzet Prowess	\N
11233	1535	14	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	6	0	312	X	No Team	Azorius Momo	\N
11234	1568	14	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	6	0	313	X	\N	Azorius Momo	\N
11235	1588	14	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	314	X	Sanctum of All	Izzet Maestro	\N
11236	1552	14	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	4	0	315	X	\N	Four-Color Control	\N
11237	1561	14	f	f	0	0	0	1	0	0	0	0	0	4	0	0	4	0	0-4-0	1	5	0	0	0	0	0	0	0	f	0	4	0	316	X	\N	Azorius Tempo	\N
11238	1558	14	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	317	X	\N	Izzet Prowess	\N
11239	1624	14	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	318	X	\N	Temur Lessons	\N
11240	1598	14	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	319	X	Undying Baguette	Rakdos Discard	\N
11241	1581	14	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	320	X	\N	Mono-Green Landfall	\N
11242	1481	14	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	321	X	\N	Izzet Prowess	\N
11243	1542	14	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	322	X	\N	Golgari Kona	\N
5977	407	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	97	Day 2		Gruul Delirium	
10619	513	13	t	t	6	0	0	2	2	0	2	0	9	4	0	15	4	0	15-4-0	6	2	0	6	2	0	3	0	0	t	6	2	1	1	Champion	Cosmos Heavy Play	Dimir Excruciator	\N
10620	743	13	t	t	5	1	0	2	2	0	1	0	9	3	0	14	4	0	14-4-0	6	2	0	6	1	0	2	0	1	t	6	1	2	2	Finals	Sanctum of All	Temur Harmonizer	\N
10621	1456	13	t	t	4	2	0	2	2	0	0	0	9	2	0	13	4	0	13-4-0	6	2	0	6	1	0	1	1	0	t	6	1	1	3	Semifinals	Worldly Counsel Heavy Play	Izzet Elementals	\N
10622	48	13	t	t	5	1	0	2	2	0	1	0	8	4	0	13	5	0	13-5-0	8	0	0	4	4	0	1	1	0	t	10	3	1	4	Semifinals	The Italians	Jeskai Control	\N
10623	809	13	t	t	5	1	0	2	2	0	1	0	7	2	0	12	3	0	12-3-0	6	2	0	6	0	0	0	1	0	t	10	1	1	5	Top 8	Double Infinity	Izzet Lessons	\N
10624	1219	13	t	t	5	1	0	2	2	0	1	0	7	1	0	12	2	0	12-2-0	7	1	0	5	1	0	0	1	0	t	5	1	1	6	Top 8	Cosmos Heavy Play	Dimir Excruciator	\N
10625	1223	13	t	t	4	2	0	2	2	0	0	0	8	1	0	12	3	0	12-3-0	6	2	0	6	1	0	0	1	0	t	5	1	1	7	Top 8	Baguette Sirop d'Érable	Bant Airbending	\N
10626	1309	13	t	t	5	1	0	2	2	0	1	0	7	4	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	4	1	0	8	Top 8	Handshake Moxfield	Five-Color Rhythm	\N
10627	109	13	t	f	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	7	1	0	5	3	0	0	0	0	t	6	2	1	9	Top 16	The Italians	Grixis Elementals	\N
10628	1465	13	t	f	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	6	2	0	6	2	0	0	0	0	t	5	2	2	10	Top 16	EZ Keep	Dimir Midrange	\N
10629	239	13	t	f	5	1	0	2	2	0	0	0	7	3	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	4	2	0	11	Top 16	Rampant Growth Heavy Play	Simic Rhythm	\N
10630	1422	13	t	f	4	1	1	2	2	0	0	0	7	3	0	11	4	1	11-4-1	4	4	0	7	0	1	0	0	0	f	5	2	1	12	Top 16	\N	Rakdos Monument	\N
10631	364	13	t	f	5	1	0	2	2	0	1	0	6	3	1	11	4	1	11-4-1	5	3	0	6	1	1	0	0	0	t	3	1	0	13	Top 16	Baguette Sirop d'Érable	Sultai Elementals	\N
10632	291	13	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	7	2	1	14	Top 16	The Boulder	Izzet Spellementals	\N
10633	1007	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	3	2	0	15	Top 16	EZ Keep	Sultai Reanimator	\N
10634	1031	13	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	6	2	1	16	Top 16	Moriyama Japan	Bant Airbending	\N
10635	394	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	1	0	17	Top 32	Handshake Moxfield	Izzet Blink	\N
10636	1019	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	2	0	18	Top 32	\N	Sultai Reanimator	\N
10637	457	13	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	19	Top 32	\N	Bant Omniscience	\N
10638	679	13	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	3	2	0	20	Top 32	Handshake Moxfield	Five-Color Rhythm	\N
10639	261	13	t	f	2	4	0	2	0	2	0	0	9	1	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	6	2	1	21	Top 32	Scrapheap	Azorius Tempo	\N
10640	468	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	3	1	0	22	Top 32	Worldly Counsel Heavy Play	Dimir Midrange	\N
10641	545	13	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	3	1	0	23	Top 32	\N	Simic Rhythm	\N
10642	744	13	t	f	4	2	0	2	1	0	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	3	2	24	Top 32	Cosmos Heavy Play	Bant Rhythm	\N
10643	1039	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	6	2	1	25	Top 32	Scrapheap	Azorius Tempo	\N
10644	1234	13	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	2	1	26	Top 32	The Boulder	Izzet Spellementals	\N
10645	678	13	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	8	2	1	27	Top 32	\N	Izzet Blink	\N
10646	1008	13	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	5	3	1	28	Top 32	TCGplayer	Esper Pixie	\N
10647	132	13	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	6	4	1	29	Top 32	\N	Grixis Reanimator	\N
10648	451	13	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	f	4	1	0	30	Top 32	Handshake Moxfield	Izzet Blink	\N
10649	1451	13	t	f	4	1	1	2	2	0	0	0	6	3	1	10	4	2	10-4-2	7	1	0	3	4	1	0	0	0	f	6	4	1	31	Top 32	\N	Grixis Elementals	\N
6830	430	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	88	Day 2	SystemMagic	Gruul Mice	
10650	204	13	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	t	5	2	1	32	Top 32	Cruelest Ultimatum	Four-Color Control	\N
10651	221	13	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	7	1	0	3	4	1	0	0	0	f	6	2	1	33	Day 2	Worldly Counsel Heavy Play	Azorius Control	\N
10652	1009	13	t	f	2	3	1	2	0	1	0	0	8	2	0	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	3	0	34	Day 2	The Boulder	Izzet Spellementals	\N
10653	312	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	35	Day 2	Rampant Growth Heavy Play	Izzet Lessons	\N
10654	717	13	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	4	1	36	Day 2	Baguette Sirop d'Érable	Izzet Lessons	\N
10655	1110	13	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	37	Day 2	The Bananas	Jeskai Elementals	\N
10656	993	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	3	2	0	38	Day 2	Sanctum of All	Temur Harmonizer	\N
10657	398	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	39	Day 2	Moriyama Japan	Izzet Lessons	\N
10658	269	13	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	3	0	40	Day 2	Worldly Counsel Heavy Play	Izzet Lessons	\N
10659	448	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	4	0	41	Day 2	The Boulder	Izzet Spellementals	\N
10660	998	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	1	0	42	Day 2	Rampant Growth Heavy Play	Izzet Lessons	\N
10661	212	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	43	Day 2	The Italians	Simic Rhythm	\N
10662	1406	13	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	3	1	44	Day 2	Moriyama Japan	Dimir Midrange	\N
10663	723	13	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	5	3	1	45	Day 2	Worldly Counsel Heavy Play	Bant Airbending	\N
10664	831	13	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	7	3	1	46	Day 2	Handshake Moxfield	Five-Color Rhythm	\N
10665	1416	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	47	Day 2	The Boulder	Izzet Spellementals	\N
10666	1441	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	48	Day 2	Flexslot Diamond	Simic Rhythm	\N
10667	1225	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	49	Day 2	\N	Mono-Green Landfall	\N
10668	1466	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	50	Day 2	The Boulder	Izzet Spellementals	\N
10669	643	13	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	51	Day 2	Moriyama Japan	Izzet Burn	\N
10670	1432	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	52	Day 2	Cosmos Heavy Play	Dimir Excruciator	\N
10671	228	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	53	Day 2	TCGplayer	Dimir Control	\N
10672	876	13	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	6	2	1	54	Day 2	TCGplayer	Dimir Control	\N
10673	657	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	55	Day 2	The Boulder	Izzet Spellementals	\N
10674	215	13	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	56	Day 2	\N	Bant Rhythm	\N
10675	1453	13	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	57	Day 2	\N	Boros Dragons	\N
10676	329	13	t	f	1	5	0	2	0	2	0	1	9	1	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	6	3	1	58	Day 2	The Boulder	Izzet Spellementals	\N
10677	920	13	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	3	0	59	Day 2	Worldly Counsel Heavy Play	Azorius Control	\N
10678	200	13	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	60	Day 2	Worldly Counsel Heavy Play	Sultai Reanimator	\N
10679	247	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	5	1	61	Day 2	The Boulder	Izzet Spellementals	\N
10680	947	13	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	62	Day 2	The Bananas	Bant Airbending	\N
10681	988	13	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	63	Day 2	The Boulder	Izzet Spellementals	\N
10682	1410	13	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	64	Day 2	Rampant Growth Heavy Play	Simic Rhythm	\N
10683	1459	13	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	65	Day 2	\N	Simic Rhythm	\N
10684	1227	13	t	f	3	2	1	2	1	1	1	0	6	4	0	9	6	1	9-6-1	7	1	0	2	5	1	0	0	0	f	4	2	0	66	Day 2	Cruelest Ultimatum	Simic Rhythm	\N
10685	1232	13	t	f	4	1	1	2	1	0	1	0	5	5	0	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	5	2	1	67	Day 2	EZ Keep	Simic Rhythm	\N
10686	226	13	t	f	4	1	1	2	1	0	1	0	5	5	0	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	6	2	1	68	Day 2	Rampant Growth Heavy Play	Izzet Lessons	\N
10687	1470	13	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	69	Day 2	\N	Bant Airbending	\N
10688	589	13	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	7	1	0	2	6	0	0	0	0	f	7	3	1	70	Day 2	\N	Boros Dragons	\N
10689	1488	13	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	2	1	71	Day 2	\N	Izzet Lessons	\N
10690	669	13	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	72	Day 2	TCGplayer	Dimir Control	\N
10691	830	13	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	73	Day 2	Rampant Growth Heavy Play	Izzet Control	\N
10692	816	13	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	2	1	74	Day 2	Handshake Moxfield	Five-Color Rhythm	\N
10693	351	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	7	1	0	2	6	0	0	0	0	f	8	4	1	75	Day 2	The Boulder	Izzet Spellementals	\N
10694	644	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	2	1	76	Day 2	The Italians	Sultai Rhythm	\N
10695	667	13	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	5	1	77	Day 2	Rampant Growth Heavy Play	Simic Rhythm	\N
10696	99	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	78	Day 2	Sanctum of All	Bant Rhythm	\N
10697	516	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	79	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
10698	423	13	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	4	0	80	Day 2	\N	Sultai Reanimator	\N
10699	588	13	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	81	Day 2	Moriyama Japan	Dimir Midrange	\N
10700	1454	13	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	4	0	82	Day 2	\N	Sultai Reanimator	\N
10701	1469	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	83	Day 2	\N	Bant Rhythm	\N
10702	151	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	84	Day 2	Scrapheap	Bant Rhythm	\N
10703	1467	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	85	Day 2	\N	Grixis Elementals	\N
10704	328	13	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	0	86	Day 2	Sanctum of All	Bant Rhythm	\N
10705	1056	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	87	Day 2	The Boulder	Izzet Spellementals	\N
10706	1399	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	88	Day 2	Sanctum of All	Temur Harmonizer	\N
10707	1096	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	89	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
10708	1046	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	90	Day 2	Cosmos Heavy Play	Bant Rhythm	\N
10709	1049	13	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	91	Day 2	Flexslot Diamond	Simic Rhythm	\N
10710	217	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	92	Day 2	Cosmos Heavy Play	Dimir Excruciator	\N
10711	1389	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	93	Day 2	#lookingforteam	Sultai Reanimator	\N
10712	1165	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	94	Day 2	Flexslot Diamond	Simic Rhythm	\N
10713	794	13	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	95	Day 2	Baguette Sirop d'Érable	Sultai Elementals	\N
10714	162	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	2	1	96	Day 2	Sanctum of All	Jeskai Midrange	\N
10715	82	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	97	Day 2	The Boulder	Izzet Spellementals	\N
10716	575	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	98	Day 2	TCGplayer	Esper Pixie	\N
10717	430	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	99	Day 2	The Boulder	Izzet Spellementals	\N
10718	785	13	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	100	Day 2	Worldly Counsel Heavy Play	Azorius Control	\N
10719	780	13	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	5	1	101	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
10720	1446	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	102	Day 2	\N	Jeskai Control	\N
10721	765	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	103	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
10722	465	13	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	4	1	104	Day 2	\N	Izzet Elementals	\N
10723	706	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	105	Day 2	Moriyama Japan	Simic Rhythm	\N
10724	1078	13	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	106	Day 2	Handshake Moxfield	Five-Color Rhythm	\N
10725	567	13	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	107	Day 2	Worldly Counsel Heavy Play	Rakdos Monument	\N
10726	103	13	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	108	Day 2	Sanctum of All	Izzet Lessons	\N
10727	1047	13	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	109	Day 2	Cruelest Ultimatum	Mono-Red Aggro	\N
10728	811	13	t	f	2	3	1	2	1	1	0	1	6	4	0	8	7	1	8-7-1	6	1	1	2	6	0	0	0	0	f	4	5	0	110	Day 2	Double Infinity	Izzet Lessons	\N
10729	1373	13	t	f	3	2	1	2	1	0	0	0	5	5	0	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	2	2	0	111	Day 2	Flexslot Diamond	Sultai Reanimator	\N
10730	1052	13	t	f	4	1	1	2	2	0	0	0	4	6	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	4	3	0	112	Day 2	EZ Keep	Simic Rhythm	\N
10731	1415	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	113	Day 2	EZ Keep	Simic Rhythm	\N
10732	1480	13	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	3	4	0	114	Day 2	Cruelest Ultimatum	Four-Color Reanimator	\N
10733	1444	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	3	1	115	Day 2	The Italians	Simic Rhythm	\N
10734	1500	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	116	Day 2	Cruelest Ultimatum	Simic Rhythm	\N
10735	1306	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	117	Day 2	#lookingforteam	Bant Rhythm	\N
10736	754	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	5	4	1	118	Day 2	The Italians	Dimir Midrange	\N
10737	349	13	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	119	Day 2	Moriyama Japan	Simic Rhythm	\N
10738	39	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	120	Day 2	\N	Simic Rhythm	\N
10739	1361	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	121	Day 2	Flexslot Diamond	Sultai Reanimator	\N
10740	1084	13	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	6	5	1	122	Day 2	Rampant Growth Heavy Play	Bant Airbending	\N
10741	238	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	4	0	123	Day 2	Double Infinity	Boros Aggro	\N
10742	258	13	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	3	0	124	Day 2	The Boulder	Izzet Spellementals	\N
10743	1371	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	125	Day 2	Scrapheap	Bant Rhythm	\N
10744	1382	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	2	0	126	Day 2	\N	Bant Rhythm	\N
10745	1487	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	127	Day 2	Moriyama Japan	Selesnya Landfall	\N
10746	1387	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	128	Day 2	#lookingforteam	Sultai Reanimator	\N
10747	1397	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	129	Day 2	\N	Dimir Midrange	\N
10748	1411	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	130	Day 2	\N	Grixis Elementals	\N
10749	1220	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	131	Day 2	TCGplayer	Bant Rhythm	\N
10750	1365	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	132	Day 2	\N	Mono-Green Landfall	\N
10751	813	13	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	7	0	133	Day 2	\N	Bant Rhythm	\N
10752	1068	13	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	134	Day 2	Scrapheap	Bant Rhythm	\N
10753	202	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	135	Day 2	Baguette Sirop d'Érable	Sultai Elementals	\N
10754	1501	13	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	136	Day 2	\N	Grixis Elementals	\N
10755	1301	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	137	Day 2	Sanctum of All	Temur Harmonizer	\N
10756	1036	13	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	7	3	1	138	Day 2	Sanctum of All	Temur Harmonizer	\N
10757	882	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	5	0	139	Day 2	Handshake Moxfield	Izzet Blink	\N
10758	347	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	140	Day 2	\N	Simic Rhythm	\N
10759	733	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	141	Day 2	Scrapheap	Bant Rhythm	\N
10760	182	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	142	Day 2	TCGplayer	Esper Pixie	\N
10761	661	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	143	Day 2	Moriyama Japan	Simic Rhythm	\N
10762	933	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	144	Day 2	Cosmos Heavy Play	Dimir Excruciator	\N
10763	189	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	145	Day 2	TCGplayer	Esper Pixie	\N
10764	684	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	146	Day 2	Scrapheap	Bant Rhythm	\N
10765	1089	13	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	147	Day 2	Baguette Sirop d'Érable	Sultai Reanimator	\N
10766	406	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	148	Day 2	Moriyama Japan	Simic Rhythm	\N
10767	1401	13	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	149	Day 2	\N	Grixis Elementals	\N
10768	935	13	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	150	Day 2	Scrapheap	Mono-Red Aggro	\N
10769	668	13	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	151	Day 2	\N	Bant Rhythm	\N
10770	1491	13	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	6	0	152	Day 2	\N		\N
10771	1020	13	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	153	Day 2	Sanctum of All	Jeskai Midrange	\N
10772	1403	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	5	0	154	Day 2	Cruelest Ultimatum	Izzet Prowess	\N
10773	1443	13	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	155	Day 2	Sanctum of All	Bant Rhythm	\N
10774	1439	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	4	0	0	0	0	f	2	3	0	156	Day 2	\N	Golgari Rhythm	\N
10775	711	13	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	157	Day 2	TCGplayer	Bant Rhythm	\N
10776	1417	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	158	Day 2	EZ Keep	Sultai Reanimator	\N
10777	769	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	159	Day 2	Rampant Growth Heavy Play	Dimir Midrange	\N
10778	1071	13	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	160	Day 2	The Bananas	Simic Rhythm	\N
10779	447	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	5	0	161	Day 2	Cosmos Heavy Play	Izzet Prowess	\N
10780	1462	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	162	Day 2	Scrapheap	Bant Rhythm	\N
10781	1376	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	2	0	163	Day 2	\N	Four-Color Control	\N
10782	383	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	164	Day 2	Worldly Counsel Heavy Play	Sultai Reanimator	\N
10783	691	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	5	3	1	165	Day 2	\N	Simic Rhythm	\N
10784	732	13	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	166	Day 2	Baguette Sirop d'Érable	Sultai Elementals	\N
10785	1383	13	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	167	Day 2	The Italians	Jeskai Control	\N
10786	1372	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	1	2	0	168	Day 2	Sanctum of All	Jeskai Midrange	\N
10787	1392	13	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	6	0	169	Day 2	\N	Simic Rhythm	\N
10788	1408	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	170	Day 2	\N	Bant Airbending	\N
10789	1380	13	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	5	0	171	Day 2	EZ Keep	Simic Rhythm	\N
10790	885	13	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	172	Day 2	Rampant Growth Heavy Play	Simic Rhythm	\N
10791	188	13	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	173	Day 2	Worldly Counsel Heavy Play	Bant Airbending	\N
10792	755	13	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	5	0	174	Day 2	Scrapheap	Bant Rhythm	\N
10793	1188	13	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	175	Day 2	Flexslot Diamond	Golgari Rhythm	\N
10794	1402	13	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	3	5	0	176	Day 2	\N	Simic Rhythm	\N
10795	1419	13	t	f	2	4	0	2	1	1	0	1	4	3	0	6	7	0	6-7-0	5	3	0	1	4	0	0	0	0	f	3	5	0	177	Day 2	The Bananas	Simic Omniscience	\N
10796	1217	13	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	178	Day 2	Cosmos Heavy Play	Dimir Excruciator	\N
10797	1502	13	t	f	2	4	0	2	1	1	0	1	2	6	0	4	10	0	4-10-0	4	4	0	0	6	0	0	0	0	f	2	6	0	179	Day 2	#lookingforteam	Bant Rhythm	\N
10798	1431	13	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	180	Day 2	\N	Golgari Rhythm	\N
10799	1062	13	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	6	0	181	Day 2	Cosmos Heavy Play	Bant Rhythm	\N
10800	1398	13	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	6	0	182	Day 2	\N	Bant Rhythm	\N
10801	1477	13	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	1	3	0	183	Day 2	Sanctum of All	Jeskai Midrange	\N
10802	171	13	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	5	0	184	Day 2	Rampant Growth Heavy Play	Dimir Midrange	\N
10803	1377	13	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	185	Day 2	Double Infinity	Mono-Green Landfall	\N
10804	1358	13	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	186	Day 2	\N	Four-Color Control	\N
10805	220	13	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	4	4	0	187	Day 2	Baguette Sirop d'Érable	Sultai Elementals	\N
10806	1057	13	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	188	Day 2	Handshake Moxfield	Five-Color Rhythm	\N
10807	207	13	t	f	4	2	0	2	1	1	1	0	1	6	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	4	4	0	189	Day 2	The Bananas	Golgari Gravefall	\N
10808	1442	13	t	f	4	2	0	2	1	1	1	0	1	6	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	3	4	0	190	Day 2	\N	Simic Rhythm	\N
10809	1457	13	t	f	3	3	0	2	1	1	1	1	2	7	0	5	10	0	5-10-0	5	3	0	0	7	0	0	0	0	f	4	8	0	191	Day 2	\N	Sultai Reanimator	\N
10810	1375	13	t	f	1	5	0	2	0	2	0	1	4	6	0	5	11	0	5-11-0	4	4	0	0	7	0	0	0	0	f	2	7	0	192	Day 2	#lookingforteam	Izzet Lessons	\N
10811	598	13	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	193	X	Baguette Sirop d'Érable	Bant Rhythm	\N
10812	1156	13	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	194	X	The Bananas	Dimir Midrange	\N
10814	1428	13	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	196	X	\N	Bant Rhythm	\N
10815	605	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	197	X	Double Infinity	Simic Rhythm	\N
10816	1229	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	198	X	TCGplayer	Bant Rhythm	\N
10817	1430	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	199	X	#lookingforteam	Grixis Elementals	\N
10818	1405	13	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	200	X	#lookingforteam	Bant Rhythm	\N
10819	1034	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	201	X	Scrapheap	Bant Rhythm	\N
10820	884	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	202	X	#lookingforteam	Bant Airbending	\N
10821	666	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	203	X	The Italians	Jeskai Control	\N
10822	310	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	204	X	Cosmos Heavy Play	Bant Rhythm	\N
10823	365	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	205	X	\N	Sultai Reanimator	\N
10824	1254	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	206	X	Flexslot Diamond	Sultai Reanimator	\N
10825	1486	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	207	X	\N	Grixis Reanimator	\N
10826	1390	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	208	X	Sanctum of All	Bant Rhythm	\N
10827	1360	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	209	X	#lookingforteam	Bant Rhythm	\N
10828	1259	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	210	X	\N	Simic Rhythm	\N
10829	1215	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	211	X	Moriyama Japan		\N
10830	476	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	212	X	Scrapheap	Bant Rhythm	\N
10831	234	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	213	X	TCGplayer	Esper Pixie	\N
10832	569	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	214	X	TCGplayer	Esper Pixie	\N
10833	401	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	215	X	Moriyama Japan	Simic Rhythm	\N
10834	1370	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	216	X	\N	Four-Color Allies	\N
10835	1414	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	217	X	#lookingforteam	Izzet Elementals	\N
10836	1460	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	218	X	\N	Simic Rhythm	\N
10837	1354	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	219	X	#lookingforteam	Izzet Elementals	\N
10838	1452	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	220	X	Cruelest Ultimatum	Five-Color Elementals	\N
10839	1504	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	221	X	TCGplayer	Esper Pixie	\N
10840	1263	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	222	X	Cruelest Ultimatum	Bant Rhythm	\N
10841	403	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	223	X	Handshake Moxfield	Izzet Blink	\N
10842	1404	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	224	X	#lookingforteam	Simic Rhythm	\N
10843	1203	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	225	X	Double Infinity	Simic Rhythm	\N
10844	1425	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	226	X	\N	Sultai Reanimator	\N
10845	1388	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	227	X	Flexslot Diamond	Bant Rhythm	\N
10846	1357	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	228	X	Sanctum of All	Bant Rhythm	\N
10847	1391	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	229	X	\N	Sultai Reanimator	\N
10848	1224	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	230	X	\N	Izzet Lessons	\N
10849	1433	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	231	X	Flexslot Diamond	Bant Rhythm	\N
10850	903	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	232	X	Scrapheap	Azorius Control	\N
10851	1395	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	233	X	EZ Keep	Simic Rhythm	\N
10852	1429	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	234	X	\N	Simic Rhythm	\N
10853	1409	13	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	235	X	#lookingforteam	Izzet Elementals	\N
10854	1505	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	236	X	Scrapheap	Bant Airbending	\N
10855	1002	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	237	X	Handshake Moxfield	Izzet Blink	\N
10856	1352	13	f	f	0	3	0	1	0	1	0	1	2	2	0	3	5	0	3-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	238	X	\N	Sultai Reanimator	\N
10857	1426	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	239	X	Cruelest Ultimatum	Four-Color Reanimator	\N
10858	1450	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	240	X	\N	Jeskai Control	\N
10859	477	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	241	X	\N	Bant Airbending	\N
10860	1369	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	242	X	\N	Grixis Control	\N
10861	502	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	243	X	Handshake Moxfield	Five-Color Rhythm	\N
10862	1355	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	244	X	EZ Keep	Bant Airbending	\N
10863	77	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	245	X	Sanctum of All	Jeskai Control	\N
10864	1427	13	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	246	X	\N	Sultai Reanimator	\N
10865	1474	13	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	247	X	Worldly Counsel Heavy Play	Sultai Reanimator	\N
10866	318	13	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	248	X	Cosmos Heavy Play	Dimir Excruciator	\N
10867	282	13	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	249	X	Handshake Moxfield	Five-Color Rhythm	\N
10868	1437	13	f	f	0	3	0	1	0	1	0	1	2	2	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	4	0	250	X	#lookingforteam	Bant Rhythm	\N
10869	147	13	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	251	X	EZ Keep	Sultai Reanimator	\N
10870	1484	13	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	252	X	Flexslot Diamond	Sultai Reanimator	\N
10871	1396	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	253	X	\N	Jeskai Control	\N
10872	1385	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	254	X	Double Infinity	Simic Rhythm	\N
10873	1394	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	255	X	\N	Sultai Reanimator	\N
10874	346	13	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	256	X	Scrapheap	Bant Rhythm	\N
10875	565	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	257	X	Sanctum of All	Bant Rhythm	\N
10876	1366	13	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	258	X	Handshake Moxfield	Five-Color Rhythm	\N
10877	1222	13	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	259	X	Scrapheap	Bant Rhythm	\N
10878	1367	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	260	X	EZ Keep	Sultai Reanimator	\N
10879	1230	13	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	261	X	#lookingforteam	Mono-Green Landfall	\N
10880	1325	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	262	X	Flexslot Diamond	Simic Rhythm	\N
10881	877	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	263	X	Worldly Counsel Heavy Play	Bant Airbending	\N
10882	1216	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	264	X	Worldly Counsel Heavy Play	Bant Airbending	\N
10883	1476	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	265	X	\N	Bant Rhythm	\N
10884	1472	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	6	0	266	X	\N	Bant Airbending	\N
10885	937	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	267	X	Double Infinity	Simic Rhythm	\N
10886	1050	13	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	268	X	Double Infinity	Bant Airbending	\N
10887	1436	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	269	X	Cruelest Ultimatum	Simic Rhythm	\N
10888	1297	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	270	X	The Bananas	Simic Rhythm	\N
10889	1449	13	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	271	X	Worldly Counsel Heavy Play	Sultai Reanimator	\N
10891	1201	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	273	X	\N	Simic Rhythm	\N
10892	761	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	5	0	0	0	0	0	0	0	f	1	4	0	274	X	\N	Simic Rhythm	\N
10893	570	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	275	X	Scrapheap	Bant Rhythm	\N
10894	196	13	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	276	X	#lookingforteam	Sultai Reanimator	\N
10895	332	13	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	277	X	Scrapheap	Bant Rhythm	\N
10896	1381	13	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	278	X	\N	Sultai Rhythm	\N
10897	1478	13	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	279	X	#lookingforteam	Simic Rhythm	\N
10898	1463	13	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	280	X	EZ Keep	Bant Airbending	\N
10899	1060	13	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	281	X	Worldly Counsel Heavy Play	Sultai Reanimator	\N
10900	1418	13	f	f	1	2	0	1	0	1	0	0	0	4	1	1	6	1	1-6-1	1	6	1	0	0	0	0	0	0	f	1	4	0	282	X	\N	Abzan Roots	\N
10901	776	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	283	X	TCGplayer	Mono-Green Landfall	\N
10902	1364	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	284	X	\N	Sultai Reanimator	\N
10903	1464	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	285	X	\N	Bant Omniscience	\N
10904	1458	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	286	X	\N	Bant Airbending	\N
10905	875	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	287	X	\N	Bant Rhythm	\N
10906	1455	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	288	X	\N	Sultai Reanimator	\N
10907	1350	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	289	X	\N	Izzet Lessons	Started out 1-1, before four straight losses eliminated him from Day 2. Won four games, but a tough day.
10908	1421	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	290	X	Baguette Sirop d'Érable	Mono-Red Leyline	\N
10909	1386	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	291	X	Scrapheap	Bant Rhythm	\N
10910	1445	13	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	292	X	Rampant Growth Heavy Play	Simic Rhythm	\N
10911	1379	13	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	293	X	\N	Sultai Reanimator	\N
10912	1479	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	294	X	#lookingforteam	Simic Rhythm	\N
10913	1235	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	295	X	The Italians	Sultai Rhythm	\N
10914	1384	13	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	296	X	Double Infinity	Simic Rhythm	\N
10915	1048	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	297	X	Flexslot Diamond	Simic Rhythm	\N
10916	1233	13	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	298	X	\N	Mono-Green Landfall	\N
10917	1482	13	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	299	X	\N	Dimir Midrange	\N
10918	1448	13	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	300	X	Double Infinity	Bant Airbending	\N
10919	1374	13	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	301	X	#lookingforteam	Izzet Elementals	\N
10890	890	13	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	272	X	Worldly Counsel Heavy Play	Bant Airbending	\N
10921	1362	13	f	f	0	3	0	1	0	1	0	1	0	5	0	0	8	0	0-8-0	0	8	0	0	0	0	0	0	0	f	0	8	0	303	X	\N	Sultai Reanimator	\N
10920	1119	13	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	302	X	Rampant Growth Heavy Play	Boros Aggro	\N
5249	16	3	t	f	0	5	0	2	0	2	0	1	7	3	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	3	0	129	Day 2			Opened Modern 3-0, finished 7-3. But didn't win a single match of Draft.
9954	429	11	t	f	2	3	1	2	1	1	0	0	7	3	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	64	Day 2	\N	Mono-Green Broodscale	\N
10102	702	11	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	212	X	Team Pluto	Domain Zoo	\N
5529	1061	1	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	181	X	Handshake		One win in each format, out at 2-5.
6243	1418	4	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	2	0	42	Day 2			4-3 overnight, reversed on D2.
5250	17	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	228	X			Got to 2-2 before four more defeats.
6281	567	1	t	t	4	2	0	2	1	1	1	0	10	2	0	14	4	0	14-4-0	8	0	0	4	3	0	2	1	0	t	8	2	1	2	Finals		Selesnya Auras	A perfect 8-0 D1; a 1-3 wobble to start D2; then three straight wins to secure T8. From there, beat the mighty Gabriel Nassif 3-1, and Takumi Matsuura 3-0 in the Semis, before Reid Duke was too much to handle in the Finals.
6324	589	1	t	t	5	1	0	2	2	0	1	0	8	3	0	13	4	0	13-4-0	7	1	0	5	2	0	1	1	0	t	4	1	0	3	Semifinals	Moriyama Japan	Mono-White Humans	Started 3-0 and never let up. 7-1 overnight, 2-1 in D2 Draft, and secured his T8 slot with a win over Marcio Carvalho in R15. Beat Chris Ferber in the QFs, before being swept by Benton Madsen in the Semis.
5540	188	1	t	t	5	1	0	2	2	0	1	0	8	4	0	13	5	0	13-5-0	5	3	0	7	1	0	1	1	0	t	6	1	1	4	Semifinals		Enigmatic Fires	5-3 on D1, but D2 Draft pod win was the springboard for T8, winning 7 from 8 on D2. Swept Shota Yasooka in the QFs before a 3-1 defeat to eventual champion Reid Duke in the Semis.
7167	1019	1	t	t	6	0	0	2	2	0	2	0	6	2	0	12	2	0	12-2-0	7	1	0	5	0	0	0	1	0	t	8	1	1	5	Top 8		Rakdos Midrange	4-1 was only the beginning, as he then won eight straight to reach the T8 with a staggering three rounds to spare. QFs were a big letdown, being swept by Derrick Davis.
5963	403	1	t	f	5	1	0	2	2	0	1	0	6	3	1	11	4	1	11-4-1	7	1	0	4	3	1	0	0	0	t	7	2	1	9	Top 16	Handshake	Abzan Greasefang	Outstanding 7-0 start, but it wasn't enough. Chris Ferber won their win-and-in in R16, leaving Inglis just outside the knockout rounds.
5425	121	1	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	2	0	11	Top 16	Portugese	Rakdos Sacrifice	Strong 6-2 on D1, but ultimately undone by two defeats on D2 to Nathan Steuer, including a R16 win and in.
7153	1013	1	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	f	6	3	1	12	Top 16			Tremendous start with 3-0 in draft and then the first three in Pioneer, but 8-1 was the high watermark before losing four of the next five. Credit for staying focused and winning the last two to secure Top 16.
5579	202	1	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	7	2	1	13	Top 16	French	Izzet Phoenix	From R6-R12 he was unstoppable, turning 2-3 into 9-3. It took Nathan Steuer and Lotus Field Combo to end his chances in R15.
6129	491	1	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	2	1	14	Top 16	Japan 2	Rakdos Midrange	3-0 Draft, then 5-0 on D1. 6-2 overnight, and in contention heading back to Pioneer, but losses to Gabriel Nassif and Joe Lossett in R12 and R13 ended his interest.
6263	556	1	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	3	1	0	15	Top 16			Three times Joe won three rounds on the bounce, and never lost twice in a row. But 8-2 in Pioneer was wasted by 3-3 in Draft.
6146	498	1	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	6	2	1	16	Top 16		Azorius Spirits	3-0 Draft to start, barely alive at 5-4, then an epic six win streak, before Gabriel Nassif took their win and in R16.
6119	486	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	20	Top 32	Japan 2	Mono-Green Devotion	1-3 was a deep hole, and  two sets of four wins in a row weren't quite enough.
5727	278	1	t	f	4	1	1	2	1	0	1	0	6	4	0	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	2	0	21	Top 32			Under the gun after a 1-1-1 opening Draft. Won seven of the next eight to contend, but 2-3 down the stretch in Pioneer left him well shy of Top 8.
6714	796	1	t	f	4	1	1	2	1	0	1	0	6	4	0	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	f	4	2	0	22	Top 32	Rampant Growth Heavy Play	Rakdos Midrange	Perfect 3-0 Draft to start, 6-2 overnight, in contention until r14 defeat to Chye Hwee Heng.
6468	666	1	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	1	0	23	Top 32			Seven of eight wins between R6 and R13 formed the bulk of Tobia's success, but Reid Duke eliminated him from contention in R14.
6157	502	1	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	2	0	24	Top 32	Handshake	Abzan Auras	5-2-1 D1 but couldn't quite kick on, despite another solid 5-3 on D2.
6042	446	1	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	3	1	25	Top 32	Moriyama Japan	Gruul Vehicles	3-0 Draft, then from 3-2 a six round win streak. Back to Pioneer, and just one more win took him down the leaderboard.
7014	941	1	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	4	2	0	26	Top 32		Izzet Creativity	4-1 early, then 8-3 and 10-4, always in touch, before Chris Ferber eliminated him from T8 contention in R15.
5808	322	1	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	27	Top 32	Sewer Rats		A pair of 5-3s for a rock solid finish, hitting the requalify 10-6.
6814	838	1	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	28	Top 32	Temple of Malady		Trophy in the opening Draft, but a tougher 1-2 on Saturday morning. Decent 10-6 to requalify.
5918	381	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	29	Top 32	Sewer Rats		Solid 7-3 in Pioneer, but only 3-3 in Draft, with a promising 6-2 D1 leading to an even 4-4 on D2.
5681	252	1	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	30	Top 32			Trophy in Draft, and three closing wins in Pioneer were the highlight, but was only 4-6 in between.
5789	312	1	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	3	2	0	31	Top 32		Izzet Phoenix	From 4-3, won six of his next seven to keep him live for T8 with two rounds to go, before Derrick Davis took him out in R15.
5436	124	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	2	2	0	33	Day 2	Spanish	Izzet Phoenix	Solid 10-6, but 3-3 in Ltd cost him any Top 8 chance. Notably defeated Sam Pardee twice, once in each format.
7073	975	1	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	t	6	2	1	34	Day 2		Izzet Creativity	Mixed D1 meant 4-4 overnight. Won his D2 Draft pod to contend, and then kept on trucking at 10-4, before Daniel Kristoff stopped his pursuit of T8.
5775	308	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	2	1	35	Day 2	Sewer Rats		Strong 7-3 in Pioneer, and five wins on the bounce on D2. 3-3 in Draft took him out of contention.
6411	637	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	36	Day 2			Five straight wins, and eight wins in nine saw him in the mix with three rounds to go. But Jean-Emmanuel Depraz, Yuta Takahashi, and Kyosuke Kyogoku proved too much. Still a creditable 10-6.
6125	488	1	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	37	Day 2	Moriyama Japan		Excellent 5-1 in Draft, but only 5-5 in Pioneer. Good effort to requalify.
7207	1036	1	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	38	Day 2	Canadians	Lotus Field Combo	Won last three of D1 to end 5-3, and kept alive as far as Pioneer on D2, where Logan Nettles ended his chances in R12.
5422	119	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	39	Day 2			Strong 7-3 in Pioneer, 3-3 in Draft. Claimed Hall of Fame wins over Seth Manfield, Javier Dominguez and Martin Juza.
6485	673	1	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	40	Day 2	Misfits	Rakdos Sacrifice	4-4 D1, then a nice run to 8-4, before two defeats knocked him out of contention.
6617	737	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	1	1	42	Day 2	Jirkal Pisano	Rakdos Midrange	From 2-3, five straight wins put him in contention. Sunk by Tristan Wylde-LaRue in R13.
6544	701	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	43	Day 2	Moriyama Japan	Azorius Control	In trouble at 1-3, recovered to make D2. Still alive back in Pioneer, and four wins from five, but out of the running in R13.
5549	189	1	t	f	4	2	0	2	2	0	0	0	5	4	0	9	6	0	9-6-0	6	2	0	3	4	0	0	0	0	f	3	2	0	46	Day 2	Channel Fireball	Izzet Creativity	Five wins in six midway through left him at 8-3, but only one D2 Pioneer win ended his chances.
6746	813	1	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	4	2	0	47	Day 2	Temple of Malady	Rakdos Sacrifice	Terrific 6-1-1 D1, hung around until R14, eliminated from contention by Jim Davis.
5519	175	1	t	f	4	2	0	2	2	0	0	0	5	4	1	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	48	Day 2	Italians		Got to 7-3, before Jean-Emmanuel Depraz and Willy Edel knocked him out of contention.
5707	266	1	t	f	4	2	0	2	2	0	0	0	5	4	1	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	49	Day 2	Ferguson Rolph Rose Smith		2-1s in both Drafts, but was quickly out of the running in Pioneer on Saturday.
6396	625	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	53	Day 2	Temple of Malady		Five in a row formed the basis of a decent 6-2 overnight, before a 3-5 D2.
7053	964	1	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	1	0	55	Day 2			Twice positive in Draft for 4-2, but 5-5 in Pioneer, highlighted by wins over Yuuki Ichikawa and Seth Manfield down the stretch.
6654	765	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	56	Day 2	Misfits	Izzet Phoenix	Solid 2-1 Draft, then 4-1 in Pioneer, before D2 1-2 in Draft used up his losses. Gavin Thompson-Exner functionally eliminated him in R12.
5418	116	1	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	3	1	57	Day 2	Calgary RC Top 8		Six round streak took Chris from 1-2 to 7-2, but didn't win again until out of contention at 7-5.
6991	931	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	58	Day 2		Storm Herald Combo	Four straight wins on D1 was the highlight, but he couldn't stay in touch with the leaders.
6104	473	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	59	Day 2			Win streaks of four and three, but out of conention by the return to Pioneer in R12.
6297	573	1	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	7	1	60	Day 2			Trophy in Draft, and 2-0 to open Pioneer, but the reverse 0-3 on Saturday morning left him out of the running. Impressive run at the back end, winning his last four.
5367	91	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	64	Day 2	Sewer Rats		Best when winning three in a row in Pioneer D1, battled to an even 4-4 on D2 with R14 win over Simon Nielsen the highlight.
6979	924	1	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	65	Day 2	Sunnydaze		Impressive five win streak spread across two days, taking him to 7-3. Eliminated from contention in R13.
6845	860	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	66	Day 2			Indifferent 3-3 in Draft, solid 6-4 in Pioneer. Improved from 4-4 D1 to 5-3 D2.
6754	814	1	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	67	Day 2			From 4-4, opened D2 4-0, fell out of contention in R13.
5949	398	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	69	Day 2	Moriyama Japan	Mono-Green Devotion	Still made D2 from an 0-2 start, then a solid 5-3 on D2 without ever being in contention.
5349	78	1	t	f	4	2	0	2	1	1	1	0	4	3	3	8	5	3	8-5-3	4	3	1	4	2	2	0	0	0	f	5	2	1	70	Day 2			Turned 1-2 in Draft D1 to the trophy on D2. Multiple draws in Pioneer with Dimir Control took him out of contention.
5522	177	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	73	Day 2	Sewer Rats	Mono-Green Devotion	Highlight was three straight at the end of D2, but never in contention.
6265	557	1	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	74	Day 2	Misfits		7-3 in Pioneer, but only 2-4 in Draft.
7018	942	1	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	75	Day 2	CFB Ultimate Guard		Opened 0-3, and faced two elimination matches just to reach D2, where he improved with a 5-3 record.
6786	827	1	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	76	Day 2	Italians		7-3 in Pioneer not matched by a 2-4 record in Draft, 1-2 both days.Did win his last three to turn 6-7 into 9-7, finishing with victory over Seth Manfield.
6271	561	1	t	f	2	3	1	2	1	1	0	1	6	3	1	8	6	2	8-6-2	5	2	1	3	4	1	0	0	0	f	3	4	0	77	Day 2			Frustrating. 2-0-1 in opening Draft, 6-3-1 in Pioneer, but damage done with an 0-3 in Draft on Saturday morning. A lot closer than this looked.
5683	253	1	t	f	3	2	1	2	1	1	0	0	5	5	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	2	2	0	79	Day 2	Bergelin Eriksson Skorupa Tatian		Undefeated in the first four rounds at 3-0-1, but inconsistent thereafter.
7185	1024	1	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	81	Day 2			Trophy in Draft 1, but only 2-3 D1 in Pioneer, before a 3-5 D2.
5726	277	1	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	82	Day 2	Canada+		Trophy in Draft 1, and 4-0, but then 5-3 and 6-5 to close the door.
6035	440	1	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	6	0	84	Day 2	Channel Fireball		Decent 6-4 in Pioneer, and 2-1 in Draft 1, but a hugely surprising 0-3 in Draft 2.
6240	539	1	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	4	0	85	Day 2			Positive 2-1s in both Drafts, but 4-6 in Pioneer.
5649	236	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	4	0	86	Day 2	Swiss		Even 3-3 in Draft, even 5-5 in Pioneer, 6-2 D1, 2-6 D2.
5539	187	1	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	87	Day 2	Sanctum of All		5-3 D1, reversed to 3-5 D2. Draft the issue, going 1-2 twice.
6521	1216	1	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	88	Day 2	Japan 2		Things to build on, with a pair of 2-1s in Draft. 4-6 in Pioneer.
6703	788	1	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	90	Day 2			Twice won three on the bounce. Highlight when winning the Draft trophy on D2, but a really difficult Saturday afternoon, going 1-4 in R12-16.
5394	105	1	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	91	Day 2			4-4 both days, but 2-1s in both Drafts.
7011	938	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	2	1	92	Day 2	Worldly Counsel Heavy Play		Won five in a row, but starting out 1-3 didn't help. Tailed away fast back in Pioneer on Saturday, going 1-4.
5596	210	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	93	Day 2			Mixed bag, never better than 3-1, before three straight losses meant a must win in R8 to reach D2. Won the last round of the tournament to make a pair of 4-4s.
5928	386	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	4	0	94	Day 2	French		Even in both formats, even on both days. Had to win R7 and R8 to reach D2.
6978	923	1	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	95	Day 2	Boston		Decent 2-1 in Draft 1, but 0-3 in Draft 2. Kept winning two in a row, but never a third.
5569	200	1	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	6	0	96	Day 2	Italians	Rakdos Midrange	A 3-0 Draft start turned into a horror show of six straight losses from R6-R11. Fought hard to 4-1 Pioneer D2, ending even at 8-8.
6739	810	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	97	Day 2			Even all the way, losing his last two stopped a winning record.
6381	614	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	99	Day 2			Even both days, but played five big names (Mihara, Takahashi, Nielsen, Ichikawa, Manfield) and lost to them all.
6804	835	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	101	Day 2		Izzet Creativity	Crept into D2 at 4-4, and quickly out of contention.
6382	615	1	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	105	Day 2			2-1 in Draft 1, but 0-3 in Draft 2 meant 4-1 down the stretch in Pioneer didn't matter.
5778	309	1	t	f	3	3	0	2	1	1	1	1	4	5	1	7	8	1	7-8-1	6	1	1	1	7	0	0	0	0	f	6	4	1	107	Day 2			Fantastic start, pacing the tournament at 6-0. Then the wheels came off, with just one more win, deep in D2.
6699	786	1	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	108	Day 2	Worldly Counsel		Trophy in D1, and 5-3 overnight belies the quality of opposition, with losses to Shota Yasooka, Nathan Steuer, and Matti Kuisma. 2-6 on D2 very disappointing.
6166	503	1	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	4	4	0	109	Day 2	Moriyama Japan		Right in the mix at 6-2 overnight, before a horror show of 1-7 on D2
6039	443	1	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	110	Day 2			Made D2 with a round to spare, but couldn't build, going 3-5.
6972	921	1	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	3	1	111	Day 2	Worldly Counsel Heavy Play		After losing R1, went on a five round streak. 2-6 on D2 did not get the job done.
6167	504	1	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	112	Day 2	Belfatto Kurz Parson Wienburg		Never more than two wins in a row, and lost his last two to finish just under even.
6433	645	9	t	f	0	5	0	2	0	2	0	1	6	4	0	6	9	0	6-9-0	4	4	0	1	6	0	0	0	0	f	3	3	0	214	Day 2		Gruul Mice	
6634	748	1	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	113	Day 2	Argentina+Spain		A fine 5-3 on D1, but a poor 2-6 on D2.
6386	619	1	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	114	Day 2			4-1? Great. 3-8 from R6 on? Not great.
6769	818	1	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	115	Day 2	Argentina+Spain		Solid 5-3 D1, but 2-6 D2, with a 1-5 run that took him well out of contention.
6344	598	1	t	f	1	5	0	2	0	2	0	1	5	4	0	6	9	0	6-9-0	5	3	0	1	6	0	0	0	0	f	4	5	0	116	Day 2	Misfits	Izzet Phoenix	Turned an 0-2 start into 5-3 D1, but then only won once on D2.
6723	798	1	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	118	Day 2			Even in Pioneer at 5-5, but 1-2 in both Drafts.
5870	356	1	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	119	Day 2	Hauch Russel		Twice 2-1 in Draft, a disappointing 3-7 in Pioneer.
5990	416	1	t	f	3	2	1	2	1	0	0	0	2	7	0	5	9	1	5-9-1	4	3	1	1	6	0	0	0	0	f	2	4	0	122	Day 2			Undefeated at 3-0-1, but ultimately needed R8 victory to reach D2. Played Stefan Schutz twice in three rounds across two formats, sharing the spoils.
5669	241	1	t	f	4	2	0	2	2	0	0	0	2	6	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	3	4	0	124	Day 2			High water mark was 6-4, having won R8 to advance to D2. Lost the last four rounds before walking away after R14.
6447	656	1	t	f	1	5	0	2	0	2	0	1	5	3	0	6	8	0	6-8-0	5	3	0	1	5	0	0	0	0	f	4	4	0	125	Day 2	Irish		Won four in a row in Pioneer on D1, but went 1-5 on D2 before packing it in.
6040	444	1	t	f	1	5	0	2	0	2	0	1	5	4	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	4	6	0	126	Day 2			Fought back from 0-2 with four straight wins, before another losing streak of six left him well off the pace.
6012	429	1	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	6	0	127	Day 2			A pair of 2-1s in Draft, but a horrible 2-8 in Pioneer with Azorius Control.
6685	776	1	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	128	Day 2			Decent 2-1 in Draft 1, but 0-3 in Draft 2, and then lost the last three rounds to complete at 6-10.
7130	1003	1	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	2	0	129	Day 2	Killers Among Us		1-2 in both Drafts, 4-6 in Pioneer, and only once won two matches in a row.
6917	899	1	t	f	2	3	1	2	0	1	0	0	4	6	0	6	9	1	6-9-1	4	3	1	2	6	0	0	0	0	f	2	5	0	130	Day 2		Azorius Control	Just made it to D2, but quickly out of contention, and only a single win on D2.
6839	855	1	t	f	4	2	0	2	1	1	1	0	1	6	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	3	4	0	131	Day 2	Worldly Counsel Heavy Play		Trophy in Draft 1, then four losses meant a must win in R8 to advance. Only one win on D2 before abandoning after R13.
6199	516	1	t	f	2	4	0	2	0	2	0	0	3	5	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	2	4	0	132	Day 2	Guillotine	Rakdos Midrange	After three straight losses, scraped into D2. Might have wished he hadn't, going 1-5 before packing it up.
5991	417	1	t	f	3	3	0	2	1	1	0	0	2	6	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	3	3	0	133	Day 2			Won elimination match in R8, but then 1-5 on D2 before sweeping them up.
5746	289	1	t	f	3	3	0	2	1	1	0	0	2	5	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	2	2	0	134	Day 2			Won R8 to advance, then 1-5 on D2.
5650	237	1	t	f	2	4	0	2	1	1	0	1	3	5	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	3	7	0	135	Day 2			Started out an excellent 4-1, but only won once more all tournament, abandoning after R14.
6278	565	1	t	f	1	2	0	1	0	1	0	0	3	2	0	4	4	0	4-4-0	4	4	0	0	0	0	0	0	0	f	2	2	0	136	Day 2			1-2 Draft, 3-2 Pioneer, didn't reappear for D2.
6334	591	1	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	138	X	Iteration		Eliminated from D2 in R7.
5694	258	1	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	139	X	Sanctum of All	       	Lost must-win R8, R7 draw proving costly.
6578	715	1	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	140	X	Italians		Highlight defeating Shuhei Nakamura in R6. Eliminated by Luis Scott-Vargas in R7.
6829	850	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	141	X			Lost blockbuster elmination match to Yuuki Ichikawa in R8.
5473	141	1	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	144	X			Fantastic Draft tophy to start, but not a single win in Pioneer, so out D1.
6778	822	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	145	X	Savvidis Volakis		2-1 in Draft, needed a win in R8, didn't get it.
5955	399	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	146	X			2-1, and again ahead of the curve at 3-2, but finished 3-5, losing elimation match to benjamin stark.
5447	129	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	148	X			From 3-2 to 3-5, losing twice to Lotus Field Combo.
7040	957	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	152	X	Italy		Needed back to back wins to advance, beat Autumn Burchett in R7, but couldn't win R8.
6214	522	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	153	X			Won first two, and last match, but five straight defeats in between.
7050	961	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	154	X	Canadians		A game of three halves: 0-2, 3-0, 0-3. Not enough.
5389	102	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	156	X	Handshake		Opened 3-1, but had a really tough road, including losses to Eli Kassis and his elimination match against Seth Manfield.
6272	562	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	157	X			From 3-2 to 3-5, losing all three chances to advance by 2-1. Tough.
6371	608	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	158	X			Had to win back to back to advance, won R7 but not R8.
5272	28	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	159	X			3-2 to 3-5, losing R7 and R8 to Mono-Green Devotion with Selesnya Angels.
6086	467	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	160	X	Handshake		Lost both win-to-advance matches to Yuta Takahashi and Tommy Ashton, a tough pair.
6417	642	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	161	X			Couldn't come back from a 1-4 hole.
5347	77	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	162	X	Sanctum of All		Promising 2-1 Draft, but lost both R7 and R8.
6414	639	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	163	X			Lost elimination match to Anthony Lee in R8.
6220	526	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	164	X	Sewer Rats		Almost came back from an 0-3 Draft start, but lost the elimination match in R8.
5684	254	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	165	X			Fought back from 0-2, but lost in R8 to end the tournament.
5273	29	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	166	X	French		2-1 in Draft, but only 1-4 in Pioneer, so no D2.
6110	478	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	167	X	Calgary RC Top 8		Nearly the complete comeback. 0-3 in Draft, then 0-4, then 3-4. But then 3-5.
6076	460	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	169	X			Pulled back to 3-4, but you don't want Luis Scott-Vargas as your D1 elimination opponent. 3-5, and done.
5832	341	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	170	X	Handshake		0-3 in Draft, fell to 0-4, rattled off three wins, but fell in R8.
5962	402	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	171	X	Japan 2		Started brightly, 2-1 in Draft, but didn't win again until R8, when it was already too late.
6854	867	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	172	X			0-3 in Draft, but a positive 3-2 in Pioneer. Not enough for D2, however.
5676	248	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	173	X	Sewer Rats		Opened 0-4, and eliminated by Yuuki Ichikawa in R7.
6672	770	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	175	X			Won the opener, but at 2-4 had too much to do. Eliminated R7.
6828	849	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	176	X	Japan 2		3-2 in Pioneer, but 0-3 in Draft meant no D2.
6053	450	1	f	f	1	1	1	1	0	0	0	0	1	3	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	3	0	178	X			2-1-1 at halfway on day 1, but 2-5-1 by the end of it.
6177	510	1	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	179	X	Handshake		Started 2-0, then lost five on the bounce before calling it quits.
6369	606	1	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	180	X	Worldly Counsel Heavy Play		One win in each format, not enough.
5467	139	1	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	182	X		Selesnya Angels	2-1 in Draft, but not a single win from five in Pioneer.
5716	270	1	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	183	X			One win in each format, out at 2-5.
6277	564	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	184	X	Temple of Malady		0-3 in Draft meant no D2, despite two Pioneer wins.
6115	483	1	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	186	X	Moriyama Japan		Won R1, but not again until R6, all too late.
6998	934	1	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	187	X	Worldly Counsel		Poor day, with lone win in Draft.
6337	593	1	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	188	X	Sanctum of All		One once in each format.
6895	886	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	189	X	Misfits		From 0-3, won twice in Pioneer, but that was it.
6856	869	1	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	190	X			From 2-2 to 2-6. No D2.
6779	823	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	191	X			Two Pioneer wins, but 0-3 in Draft was too big a handicap.
6442	652	1	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	192	X	Bus Stop		2-2 in Pioneer, but 0-3 in Draft.
5364	88	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	193	X	New Zealand		In the biggest hole at 0-4, won first two eliminators, out after R7
5381	100	1	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	194	X	Sanctum of All	Mardu Sacrifice	Only one win in each of Ltd and Pioneer, R6 loss to Zach Kiihne confirming no D2.
6819	841	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	195	X			0-3 in Draft left too much to do.
5930	388	1	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	197	X	SEA RC Top 8		From 0-4 won two of the needed four eliminators. Out in R7.
6455	661	1	f	f	1	1	1	1	0	0	0	0	0	3	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	4	0	198	X		Mono-Green Devotion	A poor start to the season, only winning a single match before being dumped out after R6.
5642	229	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	199	X	Supreme		Only a single win, in Draft, but what a moment to treasure, defeating Javier Dominguez.
6758	816	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	200	X	Twins	Mono-Green Devotion	Won his first round, but that was also his last win of the day.
5957	401	1	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	201	X	Moriyama Japan	Azorius Control	0-3 and Draft, and only a single win in Pioneer before being eliminated.
6522	691	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	202	X			1-2 in Draft, no wins in Pioneer, out after R6.
6399	627	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	203	X			1-2 in Draft, out after R6 at 1-5.
6288	568	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	204	X	Worldly Counsel Heavy Play		Won R1, then five straight defeats.
7215	1039	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	206	X			Tough road from 1-1, including losses to Autumn Burchett and Eli Loveman. Out after R6.
5488	152	1	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	7	0	208	X	Canada+		Hats off for persistance. Won R1, then lost seven straight, including Javier Dominguez and Paulo Vitor Damo da Rosa.
6708	791	1	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	209	X			Lone win in Draft, before 0-4 in Pioneer ended things.
5978	408	1	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	210	X			Had to wait until R5 for lone win.
7051	962	1	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	4	0	211	X	Spanish		0-3 in Draft, got his lone win in Pioneer in R4.
5293	43	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	212	X			0-5 and out, with just two game wins to show for it.
6007	427	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	213	X	Canada+		0-5 and done. Did at least play two Hall Of Famers in Martin Juza and Seth Manfield, and took a game of Manfield.
6144	496	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	214	X			Almost as bad as possible to imagine, going 0-5 with a single game win.
6840	856	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	215	X			Two total game wins across five rounds before being done.
7114	995	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	217	X	French		Won three games, but no matches, out at 0-5.
6886	882	2	t	t	4	1	0	2	2	0	0	0	11	2	0	15	3	0	15-3-0	7	1	0	5	2	0	3	0	0	t	7	2	1	1	Champion	Handshake	Rakdos Midrange	2-1, before setting off on yet another streak, this time encompassing nine wins and a draw. Still had to win his last round to reach T8, where he defeated Yiwen Chen, David Olsen, and finally Claire Rianhard en route to the title.
6676	774	2	t	t	4	2	0	2	2	0	0	0	10	3	0	14	5	0	14-5-0	5	3	0	7	1	0	2	1	0	t	6	2	1	2	Finals		Rakdos Reanimator	No sign of brilliance when 5-1 became 5-3, but put it all together D2, winning her last six to reach T8. Won five game sets against Karl Sarap and Autumn Burchett, before losing the Finals 3-1 to Nathan Steuer.
5382	100	2	t	t	5	1	0	2	2	0	1	0	8	4	0	13	5	0	13-5-0	5	3	0	7	1	0	1	1	0	t	5	1	1	3	Semifinals	Sanctum of All	Orzhov Midrange	5-3 overnight, she flew into contention with five straight wins on D2, including 3-0 in her D2 draft pod. A R14 loss to Simon Nielsen meant she needed to win her last two, which she did, with victory over Andre Judd securing a Top 8 berth. She reversed the Nielsen matchup to win her QF, before Claire Rianhard won a deciding G5 to end the dream one short of the Final.
6530	696	2	t	t	4	2	0	2	2	0	0	0	9	3	0	13	5	0	13-5-0	5	3	0	7	1	0	1	1	0	t	5	2	1	4	Semifinals		Five-Color Ramp	Win streaks of three, four, and five, the last being a perfect Standard run on D2 to reach the T8. He beat Javier Dominguez in the QFs, before a 1-3 reverse to eventual winner Nathan Steuer.
5607	217	2	t	t	5	1	0	2	2	0	1	0	7	1	0	12	2	0	12-2-0	7	1	0	5	0	0	0	1	0	t	5	1	1	5	Top 8	Handshake	Rakdos Midrange	Five wins to begin, a dominant Swiss performance meant T8 with two rounds to spare. Lost 3-1 in QFs to David Olsen.
6759	816	2	t	t	4	1	0	2	2	0	0	0	8	2	0	12	3	0	12-3-0	7	1	0	5	1	0	0	1	0	t	8	1	1	6	Top 8	Handshake	Rakdos Midrange	Started 2-1 in Draft, then won seven in a row. Controversially Intentionally Drew with teammate Nathan Steuer in R11. Didn't cost him, reaching T8 with a round to spare. Lost deciding game of QFs to Claire Rianhard.
6498	679	2	t	t	4	2	0	2	1	1	1	0	8	1	0	12	3	0	12-3-0	7	1	0	5	1	0	0	1	0	t	4	2	0	7	Top 8	Handshake	Rakdos Midrange	Draft 3-0 into excellent 7-1 D1. Lost to Nathan Steuer and Javier Dominguez in successive rounds, but then won four straight in Standard to reach the T8. Narrowly lost to Autumn Burchett in the QFs.
5468	139	2	t	t	5	1	0	2	1	1	1	0	7	4	0	12	5	0	12-5-0	6	2	0	6	2	0	0	1	0	t	3	1	0	8	Top 8	Chen Sun	Azorius Soldiers	Won his opening Draft, then 6-2 D1. Needed to win his last three, and did, to T8. losing to Nathan Steuer in the QFs.
6088	468	2	t	f	4	1	1	2	1	0	1	0	7	3	0	11	4	1	11-4-1	7	1	0	4	3	1	0	0	0	t	4	2	0	9	Top 16	2Free	Grixis Midrange	3-0 Draft to start, ended D1 a brilliant 7-1. Couldn't convert, going 4-3-1 on D2 to miss out.
5790	312	2	t	f	4	1	1	2	1	0	1	0	7	3	0	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	t	4	1	0	11	Top 16	Sewer Rats	Rakdos Midrange	Three sets of three straight wins kept him in contention throughout, but a R12 defeat to Javier Dominguez meant he needed four straight to finish, and he fell one short, with Yiwen Chen advancing to the T8.
5652	238	2	t	f	3	2	1	2	1	1	0	0	8	2	0	11	4	1	11-4-1	4	4	0	7	0	1	0	0	0	f	7	2	1	12	Top 16	Brazilians (Edel)	Rakdos Midrange	After a R9 draw left him on the verge of elimination he rattled off seven straight wins, but, though barely, it was not enough - the draw cost him dear.
5964	403	2	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	3	1	0	13	Top 16	Handshake	Rakdos Midrange	Strong 6-2 D1, and solid 5-3 D2. Still left him just shy of T8.
6028	438	2	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	7	2	1	14	Top 16	2Free		So close. 5-1 in Draft, and a seven round win streak saw him at 10-2 with four to play, needing 2-2 to reach the Top 8. 1-3 wasn't enough, losing win and in to Autumn Burchett.
6008	428	2	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	1	0	15	Top 16		Rakdos Midrange	Consistently won matches in a row, with runs of 2, 2, 3, and 4. It took Nathan Steuer to eliminate him in the final round of D2.
6628	745	2	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	2	0	16	Top 16	Worldly Counsel		5-1 in Draft, and in contention at 10-3, before losses to Reid Duke and Yuuki ichikawa in R14 and R15 ended the run.
5950	398	2	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	6	2	1	17	Top 32	Moriyama Japan	Grixis Reanimator	5-3 overnight, and a six round win streak kept him in contention to the very end, before Claire Rianhard won a R16 mirror match to eliminate him.
5634	228	2	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	7	2	1	20	Top 32	Channel Fireball	Rakdos Breach	A slow 0-2 start still became a solid 5-3 D1, and he kept on winning, with six straight on D2, giving him two bites at the T8 apple. Daniel Goetschel and David Olsen had other ideas, and the defending PT champ fell one match short of T8.
5523	177	2	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	22	Top 32	Sewer Rats	Rakdos Midrange	2-3 to 5-3, then, on the edge, five straight wins on D2, before David Olsen ended his chances in R15.
6427	644	2	t	f	3	3	0	2	1	1	1	1	8	2	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	4	3	0	23	Top 32	Moriyama Japan	Grixis Midrange	Survived an 0-3 Draft to reach D2, won seven of eight there, and still ended up one round away from T8.
6358	603	2	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	f	4	1	0	24	Top 32		Grixis Midrange	No D1 slipup this time, going 6-1-1. Lost to Kazune Kosaka in R13 to end his chances.
6545	701	2	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	4	4	0	6	1	1	0	0	0	f	4	2	0	25	Top 32		Azorius Control	Another 4-4 D1, and a strong 6-1-1 D2, but out of contention by the return to Standard.
7074	975	2	t	f	6	0	0	2	2	0	2	0	4	5	1	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	5	2	1	26	Top 32	Channel Fireball	Grixis Reanimator	3-0 in Draft, and a five round win streak kept him in the mix until R13 when another Daniel, this time Goetschel, ended his chances.
7036	956	2	t	f	3	3	0	2	1	1	0	0	7	2	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	5	2	1	27	Top 32		Rakdos Midrange	In trouble at 1-3, won five straight, and a 2-1 Draft on D2 kept him in the mix. Lost to Nico Bohny in R13 to end his T8 chances.
5754	293	2	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	5	1	1	28	Top 32	Canadians		Five win streak on D2 was impressive, comfortably enough to requalify.
6456	661	2	t	f	4	2	0	2	1	1	1	0	6	3	0	10	5	0	10-5-0	4	4	0	6	1	0	0	0	0	t	8	2	1	29	Top 32	Moriyama Japan	Grixis Midrange	In big trouble at 2-4, he went into overdrive, winning eight straight. Brendon Johnson ended his T8 hopes in R15.
7096	986	2	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	3	0	30	Top 32			Strong 6-2 D1, couldn't sustain on D2, going 4-4, including the last three rounds when in contention at 10-3.
5873	358	2	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	3	2	0	31	Top 32	Wu Hayne	Grixis Midrange	Perfect 3-0 Draft D1, 6-2 overnight, got to 10-4 before elimination by Yiwen Chen in R15.
6300	575	2	t	f	4	2	0	2	1	0	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	3	0	32	Top 32	Channel Fireball	Rakdos Breach	In prime position at 5-1, still in contention at 7-4, but then out early in Standard.
6080	463	2	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	4	0	33	Day 2			Perfect 6-0 in Draft, but a losing record in Standard. Still enough to requalify.
6805	835	2	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	35	Day 2	Channel Fireball	Grixis Reanimator	A perfect 6-0 in Draft, but 4-6 in Standard left him well short of T8.
6999	935	2	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	36	Day 2		Mono-Red Aggro	Twice had four straight wins, but losses in R11-13 ended his chances.
7139	1009	2	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	37	Day 2			Two four round win streaks, before elimination by Claire Rianhard in R14. 5-1 in Draft the highlight.
5251	18	5	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	245	X		Boros Convoke	Only a single win from six rounds.
5703	265	2	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	39	Day 2	Misfits	Domain Control	3-0 Draft again, still live at 7-4, but Shuhei Nakamura ended his interest in R12.
6147	498	2	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	2	1	0	40	Day 2		Selesnya Enchantments	A pair of 5-3 records, with 7-3 in Standard the better format. Never in serious contention.
6140	495	2	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	41	Day 2	Sewer Rats	Mardu Reanimator	2-3, then five wins. Won his first two back in Standard, before David Olsen ended his run in R14.
6419	643	2	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	42	Day 2	Moriyama Japan	Grixis Midrange	Only the minimum 4-4 D1, but a much better 6-2 D2. Never in contention, however.
5931	389	2	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	43	Day 2	Worldly Counsel		Needed R8 win to advance, but then accelerated into 6-2 D2, enough to requalify.
5570	200	2	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	44	Day 2	Worldly Counsel	Grixis Midrange	Turned 2-3 into 5-3, and, despite being out of contention early, won four of his last five.
6793	831	2	t	f	3	1	2	2	1	0	0	0	6	3	0	9	4	2	9-4-2	5	2	1	4	2	1	0	0	0	f	4	2	0	45	Day 2	Handshake	Rakdos Midrange	Four wins and a draw to start, but only mixed results from there. Jim Davis ended his run in R13.
6158	502	2	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	47	Day 2	Handshake	Rakdos Midrange	On the ropes at 1-4 but made D2. Couldn't quite claim his D2 Draft pod, functionally eliminating him, but still won 4 of 5 back in Standard.
6936	903	2	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	48	Day 2		Domain Control	Again in trouble at 2-3, but advanced to D2, and again had an excellent day, going 6-2.
6715	796	2	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	49	Day 2		Rakdos Midrange	Had to win R7 and 8 to make D2, strong 6-2 D2 never threatened T8.
6922	900	2	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	3	1	50	Day 2	Moriyama Japan	Grixis Midrange	The minimum 4-4 once again, again out of contention early, another late win streak, this time of six on the bounce.
6747	813	2	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	2	2	0	51	Day 2	Portugese	Rakdos Midrange	4-1-1 start, but couldn't quite accelerate, just 4-4 D2.
6130	491	2	t	f	3	2	1	2	1	0	0	0	6	4	0	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	5	3	1	52	Day 2	Japan 2	Grixis Midrange	Momentum late on D1 and into D2 with five straight wins, still alive heading to R14, but lost his last three.
5265	25	2	t	f	4	1	1	2	2	0	0	0	5	5	0	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	53	Day 2	Wu Hayne	Grixis Midrange	Good start at 4-1, but fell away after defeats to Seth Manfield and David Inglis, and an unusual Ltd draw against Joe Lossett. Two early Standard defeats on D2 finished things.
7161	1015	2	t	f	3	2	1	2	1	0	0	0	6	4	0	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	4	1	0	54	Day 2	Moriyama Japan		Indifferent 1-1-1 first Draft, but six wins in seven kept him alive until D2 Standard, where Brent Vos ended things in R12.
5939	394	2	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	4	4	0	5	2	1	0	0	0	f	2	2	0	55	Day 2	Channel Fireball	Grixis Midrange	Needed a R8 win to make D2, improved with 5-2-1 on D2, but never in contention.
5314	58	2	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	4	3	0	56	Day 2	Misfits		Won elimination match in R8 to advance, then won last four in Standard to finish 9-6-1.
5550	189	2	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	8	0	0	1	7	0	0	0	0	f	8	4	1	58	Day 2	Channel Fireball	Rakdos Breach	The definitive 'game of two halves'. Overnight leader at 8-0, the top Draft table handed him three defeats on D2, and the losses kept on coming.
7187	1025	2	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	2	1	59	Day 2	Japan 2		Fantastic start, trophying Draft and advancing to 5-0 before coming back to the pack. Eliminated by Alexander Hayne in R14.
7168	1019	2	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	4	1	60	Day 2		Esper Legends	A rollercoaster. 6-0, then 6-4 to be on the edge, up to 8-4, then elimination from contention.
6057	451	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	61	Day 2	Channel Fireball	Rakdos Reanimator	Eli won all three Draft rounds on D1, but the pod went to Eli Loveman!
6697	785	2	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	62	Day 2			Trophy in Draft 1, and added a 2-1 in Draft on D2. Losing record in Standard, however.
6475	669	2	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	2	0	63	Day 2	Channel Fireball	Grixis Midrange	Another strong D1 at 6-2, then 8-3, but two defeats took him out of contention.
6345	598	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	64	Day 2	French	Grixis Midrange	6-3 early on D2, but then two more Draft losses took him out of contention.
6559	709	2	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	65	Day 2		Grixis Midrange	Kept more or less in touch throughout, until 2-3 on D2 in Standard left him well short of T8.
6639	753	2	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	66	Day 2	Orange Prost		Trophy in Draft 1, strong 6-2 overnight. Couldn't repeat on D2, going 3-5.
7030	951	2	t	f	2	4	0	2	1	0	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	67	Day 2			Strong 7-3 in Standard, but 2-4 in Draft not enough to reach requalification.
5405	109	2	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	68	Day 2	Italians	Grixis Midrange	4-1 became 4-5, and another four round win streak was too late to contend.
5709	267	2	t	f	3	2	1	2	1	1	0	0	6	2	1	9	4	2	9-4-2	5	2	1	4	2	1	0	0	0	f	2	2	0	70	Day 2	Portugese+Brazilians		Decent D1 at 5-2-1, but had another draw on D2, ending 9-4-2.
6567	711	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	1	0	71	Day 2	Channel Fireball	Grixis Reanimator	Still in the mix heading back to Standard at 7-4, but 2-3 from there wasn't close.
6975	922	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	73	Day 2	Milkshake		Terrific up to 5-1, but then came back to the pack in a hurry, losing four straight.
6078	462	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	74	Day 2			Twice won three in a row, both in Standard, including wins over Greg Orange and Guilherme Merjam.
6904	891	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	75	Day 2	Worldly Counsel Heavy Play		5-3 overnight, and still alive at 7-4 before elimination in R12 to Adrian Moscato.
6964	920	2	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	76	Day 2	Rohan Terlizzi	Rakdos Midrange	Barely reached D2, improved 5-3 there, but never in the mix.
5677	249	2	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	3	0	77	Day 2	Handshake		Disappointing run from 4-2 to 4-5. Decent from there once out of contention.
6771	819	2	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	78	Day 2	Japan 2	Azorius Soldiers	Won R8 to reach D2, won his last three for a positive 9-7 record, but never in the T8 hunt.
5426	121	2	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	79	Day 2	Portugese + Brazilians	Rakdos Midrange	5-3 overnight, but 1-2 in D2 draft ended his chances.
6644	757	2	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	80	Day 2	Channel Fireball		Decent 7-3 in Standard, but 2-4 in Draft left him too much to do.
7100	988	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	81	Day 2		Grixis Midrange	Plenty of back to back wins, but nothing dramatic, so out of the mix before the return to Standard.
5536	185	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	82	Day 2			Solid 6-4 in Standard, even 3-3 in Draft.
6918	899	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	83	Day 2	Maynard Takahama	Esper Legends	Just about reached D2, then put together a nice four round run, but was already out of the running.
5437	124	2	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	84	Day 2	Worldly Counsel	Rakdos Reanimator	2-4 in Ltd this time around, so again out of contention by the return to Standard on D2.
5506	168	2	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	85	Day 2	Handshake		Rattled off four straight to finish D1 5-3, and had a tremendous 8-2 record in Standard. 1-5 in Draft badly let him down.
6384	617	2	t	f	5	1	0	2	2	0	1	0	3	5	1	8	6	1	8-6-1	5	2	1	3	4	0	0	0	0	f	3	3	0	86	Day 2	Japan 2		Trophy in Draft D1, and solid 2-1 again on D2. 3-5-1 in Standard much less exciting.
5780	310	2	t	f	4	2	0	2	2	0	0	0	4	4	1	8	6	1	8-6-1	4	3	1	4	3	0	0	0	0	f	3	1	0	87	Day 2	Worldly Counsel	Rakdos Reanimator	A useful 3-1 start, but two draws did him no favors, with his last of eight wins coming in R13.
5320	62	2	t	f	4	1	1	2	2	0	0	0	4	6	0	8	7	1	8-7-1	6	1	1	2	6	0	0	0	0	f	4	6	0	88	Day 2			Superb start of 5-0-1, and again 8-1-1,crumbled with six straight defeats on D2. A real 'hit the wall' day.
5885	362	2	t	f	4	2	0	2	1	1	1	0	4	5	1	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	3	3	0	89	Day 2	Worldly Counsel	Grixis Incubate	3-0 Draft to start, but three straight defeats D2 took him out of contention.
6022	435	2	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	3	2	0	90	Day 2			Solid 5-2-1 D1, but 3-5 D2.
7041	957	2	t	f	3	3	0	2	1	0	1	1	5	4	1	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	4	4	0	91	Day 2	Canada+		Opened 4-0, and had another set of three wins in D2, but plenty of losses in between.
6353	601	2	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	4	2	0	92	Day 2	Worldly Counsel Heavy Play		After losing R1, rattled off four straight. Couldn't keep the momentum going on D2, going 3-4-1.
5830	339	2	t	f	2	3	1	2	0	1	0	0	6	4	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	2	2	0	93	Day 2			Alternated losses and wins throughout D1, winning R8 to complete the sequence and advance to D2. Draft draw with Willy Edel ultimately left him just above parity.
7208	1036	2	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	2	5	0	94	Day 2	Sanctum of All	RataBlade Combo	4-1 and 6-2 were well  on track for T8. A 2-1 D2 Draft did no harm, but there were no Standard wins down the stretch.
6106	474	2	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	5	3	1	95	Day 2	Misfits		5-0 and 7-1 made for a fantastic D1. Unfortunately saw the dreaded reverse slit, only winning once on D2 to finish a hugely disappointing even at 8-8.
6266	557	2	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	5	0	96	Day 2	Handshake		Trophy in Draft 1, but 0-3 second time around. Also even record in Standard, to finish 8-8.
6930	1060	2	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	97	Day 2	Moriyama Japan		Trophy in Draft 1, and solid 2-1 in Draft 2. 3-7 in Standard, however.
6325	589	2	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	8	5	1	98	Day 2		Grixis Midrange	Dug a horrible 0-3 Draft hole, then won eight straight, including a perfect 3-0 D2 Draft, before the swingiest of tournaments ended with five straight losses.
6911	896	2	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	3	4	0	99	Day 2	Calgary RC Top 8	Five-Color Ramp	Strong 6-2 D1, but lost his next four to end his chances.
6946	906	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	100	Day 2			Decent 5-3 D1, reversed on D2.
5988	415	2	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	5	1	101	Day 2	2Free		Five wins in a row took him to 5-2, but five losses in a row took him out of contention.
6655	765	2	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	102	Day 2	French	Grixis Midrange	4-4 overnight, won his D2 Draft pod to reach 7-4, but fell away, only winning once back in Standard.
5350	78	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	103	Day 2	French		Even in both Draft and Standard, never better placed than at 2-1 after Draft 1.
5682	252	2	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	104	Day 2			4-2 in Draft, but 4-6 in Standard to finish even.
5301	47	2	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	105	Day 2			Really decent 7-3 in Standard, but only a single Draft win.
6649	761	2	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	107	Day 2	Sewer Rats		Trophy in Draft 1, so a disappointing 1-2 to open D2. 4-6 in Standard.
5541	188	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	108	Day 2	Misfits	Domain Control	Four wins on the bounce to reach 4-1 was the highlight, with 1-2 in Ltd on D2 eliminating him from contention before the return to Standard.
6652	763	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	109	Day 2			Even across both formats and both days. Best placed when 8-6 before losing last two.
6844	859	2	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	110	Day 2	Killers Among Us		Won last three on D1 to finish 5-3, reversed to 3-5 on D2.
6810	837	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	111	Day 2	CFB Ultimate Guard	Domain Control	Advanced from 3-3 to 5-3, but soon out of contention on D2.
7015	941	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	112	Day 2	Channel Fireball	Rakdos Breach	4-4 D1, and soon out of the running.
5859	351	2	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	114	Day 2	Worldly Counsel	Rakdos Reanimator	Matching 4-4 records both days, never more than two wins on the bounce.
7054	964	2	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	115	Day 2			Better in Standard (6-4) than Draft (2-4)
5919	381	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	116	Day 2	Sewer Rats		Best stretch was three wins on D2 across both formats. Ended even in both.
6446	655	2	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	117	Day 2			Twice won three in a row, but 2-4 in Draft kept him midfield.
5776	308	2	t	f	2	4	0	2	1	1	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	118	Day 2	Sewer Rats		Winless in Draft D2, then won last four in Standard to turn 4-8 into 8-8.
6264	556	2	t	f	4	0	2	2	2	0	1	0	3	7	0	7	7	2	7-7-2	5	3	0	2	4	2	0	0	0	f	5	4	1	120	Day 2			Tremendous start at 5-0, but didn't win again until R11, including two unlikely draws in Draft on the second morning.
5271	27	2	t	f	3	2	1	2	1	0	0	0	4	5	0	7	7	1	7-7-1	4	3	1	3	4	0	0	0	0	f	2	2	0	121	Day 2			Out of contention at 4-5.
6380	613	2	t	f	3	3	0	2	1	1	0	0	4	4	1	7	7	1	7-7-1	4	3	1	3	4	0	0	0	0	f	2	4	0	122	Day 2			Never made it to three straight wins.
6138	493	2	t	f	4	2	0	2	1	1	1	0	3	6	1	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	5	0	123	Day 2			Trophy in Draft 1 the highlight, and still positive with two rounds to go, before defeats in R15 and R16.
5831	340	2	t	f	3	3	0	2	1	1	0	0	4	5	1	7	8	1	7-8-1	5	3	0	2	5	1	0	0	0	f	2	3	0	124	Day 2			Decent start with 2-1 in Draft, but couldn't get anything going beyond that.
5353	80	2	t	f	3	3	0	2	1	1	0	0	4	5	1	7	8	1	7-8-1	5	3	0	2	5	1	0	0	0	f	3	3	0	125	Day 2	Sanctum of All		Opened 2-1 in Draft, and a solid 5-3 overnight, but 2-5-1 on D2.
7021	943	2	t	f	3	3	0	2	1	1	0	0	4	5	1	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	2	3	0	126	Day 2			Just above even on D1, then 3-5 D2.
5355	81	2	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	5	0	127	Day 2			Decent 4-2 in Draft, but 3-7 in Standard.
5911	375	2	t	f	5	1	0	2	2	0	1	0	2	8	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	5	0	128	Day 2	Australians		After losing R1 to Claire Rianhard, churned out four straight. Also trophy on D2 in Draft, but from 7-4 lost all five Standard matches.
5564	196	2	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	4	0	129	Day 2	2Free		Four straight defeats mid-D2 ensured a losing record, including to Sam Pardee and Derrick Davis.
5448	129	2	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	5	1	130	Day 2			Won five straight, but a difficult 2-6 D2.
7025	947	2	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	3	0	131	Day 2			Very much alive at 7-3, but that was all the winning done.
5423	119	2	t	f	5	1	0	2	2	0	1	0	2	8	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	132	Day 2			Trophy in Draft 1, and solid 2-1 again the next morning. But horrible 2-8 record in Standard.
6293	570	2	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	6	0	133	Day 2	CFB Ultimate Guard		Trophy in Draft 1, but 0-3 second time around.
7206	1035	2	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	4	0	134	Day 2			Decent 5-3 D1, but 2-6 D2.
6900	890	2	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	135	Day 2			Even in Standard at 5-5, but 2-4 in Draft.
7043	959	2	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	136	Day 2		Grixis Reanimator	Out early on D2, couldn't get anything going.
6366	605	2	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	137	Day 2	Worldly Counsel Heavy Play		Tough road to reach D2, needing and getting wins ove Corey Burkhart R7 and Michael Belfatto R8. 3-5 on D2.
6511	684	2	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	138	Day 2	Scoreboard		Most of his wins came in pairs, but never better off than 2-0.
6555	705	2	t	f	1	5	0	2	0	2	0	1	5	4	1	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	3	5	0	140	Day 2			Came back from 1-4 to make D2 with three straight wins.
6043	446	2	t	f	2	4	0	2	1	1	0	1	4	5	1	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	2	3	0	142	Day 2	Moriyama Japan	Grixis Reanimator	Had to win R8 to advance, and was soon out of the running on D2.
5948	397	2	t	f	2	3	1	2	0	1	0	0	4	6	0	6	9	1	6-9-1	4	3	1	2	6	0	0	0	0	f	3	4	0	143	Day 2			Safely through to D2, but then 2-6.
6387	619	2	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	2	6	0	144	Day 2	New Zealand		Got to 3-1, but didn't press on, horror show D2 of 1-7, had to wait until R15 for that solitary win.
6021	434	2	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	145	Day 2			2-1 in both Drafts, but 2-8 in Standard.
6361	604	2	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	3	0	146	Day 2	Sewer Rats	Grixis Midrange	3-1, but had to win R8 to keep playing. Only 2-6 on a forgettable D2.
6517	687	2	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	5	3	0	0	7	0	0	0	0	f	3	7	0	147	Day 2			High point was 5-2, before a terrible run of eight straight losses.
5412	111	2	t	f	2	4	0	2	0	2	0	0	4	4	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	4	4	0	148	Day 2			Got some momentum with four straight wins, but of contention R10.
7121	998	2	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	5	0	149	Day 2	Bus Stop + Sewer Rats		Started out 0-3, so did well to make D2. Draft improved, going 2-1 on D2, but then no Standard wins.
7163	1016	2	t	f	0	6	0	2	0	2	0	2	6	4	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	4	0	150	Day 2	Moriyama Japan		Great work to reach D2, having started 0-4 and ended 4-4. Another tough day on D2, however, at 2-6.
7049	960	2	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	151	Day 2	Worldly Counsel Heavy Play		Needed two wins in elimination matches to advance, then 2-6 on a challenging D2.
6846	860	2	t	f	2	3	1	2	0	1	0	0	3	5	0	5	8	1	5-8-1	4	4	0	1	4	1	0	0	0	f	3	4	0	152	Day 2	Ferguson Rolph Rose Smith		Still battling at 5-4-1, then four straight defeats before abandoning.
6217	524	2	t	f	2	4	0	2	0	2	0	0	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	3	5	0	153	Day 2	Worldly Counsel Heavy Play		Won first three Standard matches, but went from 4-2 to 4-5 to be eliminated from contention.
7147	1011	2	t	f	2	4	0	2	0	2	0	0	3	4	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	4	4	0	154	Day 2	Milkshake	Jeskai Control	1-4, but still made it to D2. Dropped at 5-8.
6342	597	2	t	f	3	3	0	2	1	1	1	1	1	5	0	4	8	0	4-8-0	4	4	0	0	4	0	0	0	0	f	3	7	0	155	Day 2	Worldly Counsel		Trophy in Draft 1, but only won once more.
5982	412	2	t	f	2	4	0	2	1	1	0	1	2	4	0	4	8	0	4-8-0	4	4	0	0	4	0	0	0	0	f	2	4	0	156	Day 2			2-1 in Draft 1 the highlight, squeezing into D2 before losing four straight and calling it done.
6335	592	2	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	3	0	157	X	Swiss		2-1 in Draft, but only one win in Standard.
6412	637	2	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	158	X	Portugese		Opened with an unlikely Draft draw, and that ultimately left him 'half a win' short of D2
5981	411	2	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	1	0	160	X			Had to win R7 and R8 to advance, lost R8.
5309	53	2	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	3	3	0	161	X	Worldly Counsel		3-1-1 after R5, then three straight losses to miss D2.
5933	390	2	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	1	0	162	X	Irish		1-1-1 in Draft, lost elimination match in R8.
5514	174	2	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	163	X	Australians	Domain Control	Could only put together two straight wins in R7 and 8, too late for D2.
5829	338	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	164	X			Needed back to back wins to advance, lost in R8.
6755	814	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	165	X	Portugese		Got to 3-2, then lost all three chances to advance.
6789	829	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	166	X	Sanctum of All		Opened 2-0 in draft, but lost both chances to advance.
6338	594	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	167	X	Maynard Takahama		2-1 in Draft, but only one win in Standard.
5936	391	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	169	X	Australians		2-1 in Draft and then 3-2, lost his last elimination match to Andrea Mengucci.
6948	908	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	170	X			2-1 in Draft, but fell to 2-4 and lost R8.
6339	595	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	172	X			Started 2-0, but lost in the trophy final to Luis Scott-Vargas. Lost R6-8 to end things.
6153	499	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	174	X	Channel Fireball		Lost two elimination matches, so no D2.
6026	437	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	175	X	Australians		Needed two elimination match wins to advance, but lost R8 to Yuta Takahashi.
6914	897	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	176	X			Opened 2-0 in Draft, and had three chances to advance from 3-2, but couldn't take any of them.
5769	304	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	177	X			0-2, fought back to 2-2, 2-4, couldn't fight back to 4-4.
6491	675	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	178	X			Winless in Draft, came to 3-3 in Standard, but lost both matches from there.
5474	142	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	179	X	Worldly Counsel		Had two chances to advance from 3-3, couldn't convert.
6469	666	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	180	X	Italian		Got to 3-3, couldn't advance.
5369	92	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	181	X	Wu Hayne		Deep trouble at 1-4, won two straight to keep things interesting, lost R8.
6017	432	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	182	X			Decent 2-1 in Draft, but only one win in Standard.
5332	70	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	183	X	Wu Hayne		2-1 in draft, only one win in Standard.
6083	465	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	184	X			Decent 2-1 in Draft, but lost his last three in Standard.
5871	357	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	185	X			Lost four in a row to fall to 1-4, fought back, but lost R8.
6270	560	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	186	X			1-1 and 2-2, but couldn't claw back from 2-4.
6175	509	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	187	X	French		Won R1, but already eliminated by the time he won again in R7 and R8.
6841	857	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	188	X	Bergelin Eriksson Skorupa Tatian		Got to 3-2, before three straight losses.
6495	678	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	189	X			Opened 0-4, and ran out of rounds, despite going 3-1 from there.
6980	924	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	191	X	Sewer Rats		Recovered from 0-2 to 3-2, but then lost three straight to miss out.
5601	213	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	192	X	Italians		After an 0-3 Draft, eliminated in R7.
5305	50	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	193	X			Faced the ultimate challenge to advance at 0-4, and got most of the way there before a R8 defeat.
5600	212	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	194	X	Italians		0-4 became 3-4, but lost the final round.
6171	506	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	195	X	Canadians		Couldn't come back from 1-4, eliminated in R7.
6556	706	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	196	X	Japan 2		Ahead of the curve at 3-2, but couldn't get it done down the stretch.
5368	91	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	197	X	Wu Hayne		Needed three straight to advance, but Arne Huschenbeth got it done in R8.
6397	625	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	198	X	Sewer Rats		Never at parity, and eliminated by Shuhei Nakamura in R8.
6066	453	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	199	X			Won three of the last four in Standard, but eliminated by Jean-Emmanuel Depraz in R7.
6613	734	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	200	X			Got to 2-2 before three straight losses.
5728	278	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	202	X	2Free		Won the last two rounds of the day, but already out at that point.
6947	907	2	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	203	X			Credit for winning three straight to end things positively, but that was after an 0-5 start.
5622	219	2	f	f	2	0	1	1	1	0	0	0	0	5	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	2	5	0	204	X			Excellent 2-0-1 start in Draft, but couldn't register a single win in Standard.
5303	49	2	f	f	1	1	1	1	0	0	0	0	1	3	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	3	0	205	X	Sewer Rats		Costly Draft draw led to ultimate elimination in R7.
6120	486	2	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	2	0	206	X		Grixis Reanimator	Won R1, but that was it until R7. No D2.
5226	6	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	207	X			Won the first round of both Draft and Standard, but that was it.
5833	341	2	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	209	X	Handshake		Didn't win his lone match until R7.
6618	737	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	210	X	Canada+	Rakdos Midrange	One win in each format, not enough for D2.
6482	670	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	211	X	CFB Ultimate Guard		Got to 2-2, then three losses.
6210	519	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	212	X			Eliminated in R6.
6054	450	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	213	X	Worldly Counsel		Eliminated in R7.
6815	838	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	6	0	214	X			Won R1, won R8, lost everything in between.
7065	970	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	215	X			Won the opening rounds of both formats, but that was all.
6637	751	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	217	X			Eliminated in R7.
5277	31	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	218	X	Channel Fireball		Eliminated in R7 by Matti Kuisma.
5512	172	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	219	X	Australians		Eliminated in R7.
6103	472	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	220	X			Got to 2-2, then lost four straight.
6105	473	2	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	221	X			Eliminated in R6.
6282	567	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	223	X		Naya Counters	Won R1, but not much else.
6225	528	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	224	X	Sewer Rats		Eliminated in R7.
5387	101	2	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	225	X			Winning 2-1 start in Draft, but no Standard wins.
6222	527	2	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	226	X	Sewer Rats		0-3 in Draft, won a couple, eliminated in R7.
5390	102	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	227	X	Handshake		From 2-2, ended 2-5.
7224	1044	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	228	X	Worldly Counsel		Fell from 2-2 to 2-6.
5419	116	2	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	229	X	Canadians		From 2-2 to 2-6.
5520	175	2	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	230	X	Italians		0-4 start left too much to do. Out after R7.
7019	942	2	f	f	0	2	1	1	0	1	0	0	1	4	0	1	6	1	1-6-1	1	6	1	0	0	0	0	0	0	f	1	4	0	231	X			Only win was the first round of Standard.
6728	801	2	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	232	X			Won R1, but that was all.
6454	660	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	233	X			After 0-3 Draft, won first round of Standard, but that was all.
6646	758	2	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	234	X	Boston		Opened with a win, but that was the only one.
5370	93	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	235	X			0-3 Draft, won R4 in Standard, but eliminated after R6.
6849	862	2	f	f	1	2	0	1	0	1	0	0	0	1	0	1	3	0	1-3-0	1	3	0	0	0	0	0	0	0	f	1	2	0	236	X	Scoreboard		Pulled out at 1-3.
6226	529	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	237	X	Misfits		0-3 Draft, won the first round of Standard, but that was all.
6250	547	2	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	238	X	Worldly Counsel		Won the opening Draft round, but that was the only one.
5592	207	2	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	4	0	239	X	Australians		Won the opening round of Standard, but that was all.
6820	842	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	240	X			After 0-3 Draft, won the opener in Standard, but out after R6.
7154	1013	2	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	241	X	Handshake		Got to 1-1, but that was the only win.
6405	632	2	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	242	X	Portugese+Brazilians		Won R1, but nothing else.
6878	1119	2	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	243	X		Dimir Toxic	Just a single D1 win, so no D2.
6857	870	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	244	X	Calgary RC Top 8		Started 0-4, and only got one of the needed four wins from there.
6992	931	2	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	245	X		Rakdos Midrange	One win after R1, one win after R7. Not a good day.
6950	910	2	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	246	X			Winless through six rounds, with three game wins.
6169	505	2	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	247	X			0-3 in Draft, won R4 in Standard before eliminated after R6.
7109	992	2	f	f	0	2	1	1	0	1	0	0	0	1	0	0	3	1	0-3-1	0	3	1	0	0	0	0	0	0	f	0	3	0	248	X	Handshake		A draw and three losses was enough to end things.
6781	824	2	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	250	X	Sewer Rats		0-5, with three game wins.
6126	488	2	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	251	X			0-6, with three game wins.
5295	45	3	t	t	4	2	0	2	1	1	1	0	11	1	1	15	3	1	15-3-1	7	1	0	5	2	1	3	0	0	t	4	1	0	1	Champion		Rakdos Grief	As good as it gets. 3-0 in Draft, 7-1 D1, four straight wins in Modern to reach T8, then wins over Marco Del Pivo, Dominic Harvey, and Christian Calcano to take the trophy. Glorious.
5396	107	3	t	t	4	1	1	2	1	0	1	0	10	3	0	14	4	1	14-4-1	7	1	0	5	2	1	2	1	0	t	5	1	1	2	Finals	Worldly Counsel	Mono-Green Tron	A 5-0 start was the foundation of a Top 8 run, with 4-1 in Modern on D2 sealing the deal. After a 3-0 sweep of Kai Budde in the QFs, he reached the Final with a 3-2 win over Simon Nielsen, before taking Jake Beardsley to a deciding G5.
6499	679	3	t	t	6	0	0	2	2	0	2	0	7	4	1	13	4	1	13-4-1	8	0	0	4	3	1	1	1	0	t	12	3	1	3	Semifinals	Handshake	Mono-Green Tron	One of the greatest starts ever, reaching 12-0, and making a second successive T8. Beat Stefano Vinci in the QFs, before Christian Calcano edged him out in G5 of the Semis.
5860	351	3	t	t	4	2	0	2	1	1	1	0	9	3	0	13	5	0	13-5-0	5	3	0	7	1	0	1	1	0	t	7	2	1	4	Semifinals	Worldly Counsel	Amulet Titan	0-2 was a deep hole, but what a comeback. 5-3 overnight, a Draft pod win to start D2, then four of five in Modern took him into the T8. He defeated Javier Dominguez handily in the QFs, before losing to eventual Champion Jake Beardsley in the Semis.
5608	217	3	t	t	5	1	0	2	2	0	1	0	8	2	0	13	3	0	13-3-0	6	2	0	7	0	0	0	1	0	t	11	1	1	5	Top 8	Handshake	Mono-Green Tron	From 2-2, a breathtaking 11 win streak to reach a second successive T8. Sadly, also a second successive QF loss, this time 3-1 to Dom Harvey with Amulet Titan.
5571	200	3	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	6	2	0	6	2	0	0	1	0	t	5	1	1	6	Top 8	Worldly Counsel	Temur Rhinos	A five win streak was the backbone of 6-2 on D1, and secured T8 thanks to four straight that included fellow T8ers Dom Harvey and Simon Nielsen. Eventual Champion Jake Beardsley brought his run to an end by 3-1 in the Quarterfinals.
7059	968	3	t	t	6	0	0	2	2	0	2	0	6	5	0	12	5	0	12-5-0	5	3	0	7	1	0	0	1	0	t	4	2	0	7	Top 8	Martin Orellana Perals Vigo	Temur Rhinos	A perfect 6-0 in Draft set him up for a T8 run, and winning his last four rounds got the job done. Defeated by Simon Nielsen in the QFs.
5372	94	3	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	8	2	1	8	Top 8			After losing R1, eight straight victories. After losing to Gabriel Nassif in R13, he needed three straight to reach Sunday. He did so, ultimately swept by Christian Calcano in the QFs.
5874	358	3	t	f	4	2	0	2	2	0	0	0	7	1	2	11	3	2	11-3-2	6	2	0	5	1	2	0	0	0	t	5	1	1	9	Top 16	Handshake	Mono-Green Tron	Five straight wins kept him in contention, but a R13 draw against Kevin Anctil left him running out of rounds, finishing just outside the T8.
6131	491	3	t	f	3	2	1	2	1	0	0	0	8	1	1	11	3	2	11-3-2	6	2	0	5	1	2	0	0	0	t	5	1	1	10	Top 16	Japan 2	Rakdos Grief	Won all five Modern matches D1, leaving him 7-1 overnight. Once again reached R14 in contention, before Javier Dominguez eliminated him from the reckoning.
5971	406	3	t	f	6	0	0	2	2	0	2	0	5	4	1	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	f	5	2	1	11	Top 16	Moriyama Japan	Mono-Green Tron	Great start at 5-0. Won his D2 Draft pod, and his last three of D2, leaving him just short of T8.
6546	701	3	t	f	4	2	0	2	1	1	1	0	7	2	1	11	4	1	11-4-1	7	0	1	4	4	0	0	0	0	t	5	2	1	12	Top 16		Four-Color Control	Outstanding D1, just a draw away from perfect. But 4-4 D2 left him just short of the T8.
6476	669	3	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	5	2	1	13	Top 16	Channel Fireball	Living End	Another 3-0 start, another 6-2, another Draft pod win, another push for T8. It took Alexander Hayne to finish him in R15.
7044	959	3	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	1	0	14	Top 16	Italians	Five-Color Reanimator	Kept winning multiple rounds in a row to go deep, including four straight back in Modern on D2. Lost his win-and-in to Stefano Vinci in the final round.
5748	291	3	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	4	2	0	15	Top 16		Rakdos Grief	Perfect 3-0 in Draft, kept winning multiple matches in a row, just finished one win short of T8.
5414	113	3	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	2	1	17	Top 32			A tale of two formats: perfect 6-0 in Draft, literally average 5-5 in Modern.
5781	310	3	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	8	3	1	18	Top 32	Worldly Counsel	Five-Color Creativity	Won his D1 Draft pod, fell away to 3-3, then ran up eight straight. That earned him two win-and-ins, but it was Jake Beardsley and Kai Budde who claimed the Sunday seats.
5316	59	3	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	t	9	2	1	19	Top 32			Was in horrible shape at 2-4, then went on one of the great sequences, featuring two Modern D1 wins, a trophy in Draft on D2, and four more Modern successes, before a R16 lost to Dominic Harvey denied him what would have been an amazing Top 8.
5791	312	3	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	21	Top 32	Sewer Rats	Four-Color Rhinos	5-3 overnight, but began D2 with a loss. Four straight wins kept him alive back in Modern, before Marco Cammilluzzi finished his contention in R14.
5406	109	3	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	22	Top 32		Temur Rhinos	From 2-3, an excellent 8 of the next 9 left him live going into the penultimate round, before Toru Inoue ended his hopes.
7075	975	3	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	4	3	0	23	Top 32	Channel Fireball	Rakdos Grief	3-1 to 3-4, just made D2. One his Draft pod, and four out of five in Modern, but not quite enough.
6159	502	3	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	6	2	1	24	Top 32	Handshake	Mono-Green Tron	Again had to win R8 to reach D2, and again took the opportunity, winning his Draft pod, going 7-1 D2, but still ending one win short of T8.
5449	130	3	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	7	3	1	25	Top 32			Out of contention early when falling to 4-5, but then swept the board to finish 11-5.
5438	124	3	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	f	3	1	0	26	Top 32	Worldly Counsel	Five-Color Creativity	6-2 overnight, but a draw and two losses mid-way through D2 cost him.
6560	709	3	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	2	0	27	Top 32	2Free	Izzet Murktide	Two sets of four wins in a row were enough to keep him live until R15, when Miguel Castro ended his chances.
5809	322	3	t	f	2	3	1	2	0	1	0	0	8	2	0	10	5	1	10-5-1	5	3	0	5	2	1	0	0	0	f	3	2	0	29	Top 32	Sewer Rats		Three sets of three straight wins kept him alive, but ultimately starting 0-2 in Draft on the first morning was costly.
5615	218	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	t	5	4	1	30	Top 32		Four-Color Omnath	Perfectly poised at 9-1, but lost five of his last six for a true what might have been.
5998	423	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	31	Top 32		Five-Color Creativity	Won his opening Draft, advanced to 6-2, and still in the mix before Socrates Rozakeas ended his run in R14.
5459	137	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	2	0	32	Top 32	Chen Chen Ji Sun	Temur Rhinos	Won his D1 Draft, 6-2 overnight, and then 9-3. Lost to Marco Vassallo in R15 to end his run.
7125	1000	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	5	2	1	33	Day 2	Coalition Victory		From 2-2, hit his stride with five straight wins, and was still in with a shout until R15.
6019	433	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	3	1	34	Day 2	Sewer Rats		After losing R1, rattled off five straight, and returned to Modern at 7-4. Three losses ended the dream.
7037	956	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	3	0	35	Day 2		Dimir Control	3-0 Draft to open, 5-3 overnight, 2-1 in D2 Draft, out of contention after R12.
6993	931	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	4	0	36	Day 2		Jeskai Breach	A game of four quarters. A 4-0, an 0-4, a 1-3, and a 4-0 that came too late.
6847	861	3	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	5	1	37	Day 2	2Free		Streaks of five wins and four, but it was the three Draft losses on the second morning that couldn't be overcome.
7195	1030	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	1	0	38	Day 2	Sanctum of All	Rakdos Grief	Needed a last round win to advance to D2, and added five more wins on D2.
6588	723	3	t	f	3	1	2	2	1	0	0	0	6	3	1	9	4	3	9-4-3	4	2	2	5	2	1	0	0	0	f	3	1	0	39	Day 2	Italians	Azorius Hammer	Three draws were an important part of his story, since he only lost four times all tournament, but the draws were more than enough to keep him away from T8, despite 4-1 down the stretch in Modern.
7066	971	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	3	0	40	Day 2			Trophy on D1, 2-1 in Draft D2, but couldn't press on in Modern.
6443	653	3	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	2	1	41	Day 2	Moriyama Japan		Started slowly at 1-3, then roared back into the mix with eight wins in the next nine. Kai Budde eliminated him in R14.
6301	575	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	42	Day 2	Channel Fireball	Rakdos Grief	After a struggle D1 (4-4), a better 6-2 D2, although out of contention by the return to Modern.
5940	394	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	43	Day 2	Channel Fireball	Temur Rhinos	4-4 overnight, so even a 6-2 D2 couldn't get him into the mix.
5542	188	3	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	4	1	44	Day 2	Misfits	Four-Color Omnath	Very swingy event, with both four and five win streaks, separated by four defining losses to end D1 and start D2.
7143	1010	3	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	45	Day 2	Rampant Growth Heavy Play	Esper Control	4-2 then 4-4, and four wins in a row D2, but already out of contention, a couple of missed opportunities.
7219	1042	3	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	5	2	1	46	Day 2		Four-Color Omnath	1-3, but then five wins in a row, and four straight on D2. Not enough to trouble the leaders, but a great turnaround.
7169	1019	3	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	47	Day 2		Rakdos Grief	Out of the running by R10, but still had five wins in a row D2.
6965	920	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	48	Day 2	Italians	Living End	In the last chance saloon at 2-4, powered on to 7-4, before elimination from contention in R12.
5551	189	3	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	49	Day 2	Channel Fireball	Golgari Yawgmoth	4-2 became 4-5 to leave him in the also-rans, but impressively swept D2 Modern with Golgari Yawgmoth.
6835	854	3	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	50	Day 2	Tenacious Underdogs	Rakdos Grief	Got some momentum late on D1, winning three in a row for 5-3 overnight, but was soon out of the mix.
6568	711	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	51	Day 2	Channel Fireball	Samwise Gamgee Combo	Improved the minimum 4-4 into 8-4, before Brian Zilles ended his T8 interest in R13.
6326	589	3	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	3	0	52	Day 2		Rakdos Grief	Once again survived an opening 0-3 Draft, and again had a strong D2 at 6-2. But at 4-5, he was soon out of contention.
6937	903	3	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	53	Day 2	Misfits	Four-Color Omnath	Here we are again. 2-4 into 4-4, 6-2 D2.
5826	336	3	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	54	Day 2	Tilt		A horrible 1-4 start essentially ended all hope, but put together runs of four and five straight wins for a tremendous 10-6 that meant requalification.
5813	325	3	t	f	2	4	0	2	1	1	0	1	7	1	2	9	5	2	9-5-2	6	2	0	3	3	2	0	0	0	f	6	4	1	55	Day 2	Misfits		Six straight wins on D1, and only lost once in Modern. Two constructed draws left him well short of T8.
5851	349	3	t	f	5	1	0	2	2	0	1	0	4	4	2	9	5	2	9-5-2	5	3	0	4	2	2	0	0	0	f	3	1	0	56	Day 2	Moriyama Japan	Four-Color Omnath	5-2 overnight, then into contention with a 3-0 Draft sweep D2. Only won once back in Modern, however.
6748	813	3	t	f	3	2	1	2	1	0	0	0	6	4	0	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	5	3	1	57	Day 2		Rakdos Grief	Five straight wins the backbone of another solid effort. D2 once again challenging, going 3-4-1
6058	451	3	t	f	2	3	0	2	1	1	0	0	6	3	1	8	6	1	8-6-1	5	3	0	3	3	1	0	0	0	f	3	3	0	58	Day 2	Channel Fireball	Samwise Gamgee Combo	Never quite had the momentum, and three wins R12-14 were too late to matter.
6700	786	3	t	f	3	2	1	2	1	1	0	0	6	3	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	5	3	1	59	Day 2	Rohan Terlizzi		Only lost once before R10, and in the thick of things at 9-3-1, but lost the last three, all by the odd game in three.
7166	1018	3	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	3	1	0	60	Day 2			6-2 overnight, but a losing record on D2.
5427	121	3	t	f	2	4	0	2	0	2	0	0	7	2	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	3	2	0	61	Day 2	Portugese+Brazilians	Rakdos Grief	A solid 5-2-1 on D1, but 2-4 in Draft overall kept him from a T8 chance.
6527	693	3	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	5	0	62	Day 2			Twice won four straight, and live going back into Modern, but 9-2 became 9-7.
6457	661	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	3	0	63	Day 2	Moriyama Japan	Rakdos Grief	2-1 in Draft, then 6-1 before being pegged back to 6-4, with R13 ending his T8 interest.
6931	1060	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	7	4	1	64	Day 2	Worldly Counsel		Work to do at 1-2, turned it into 8-2, but then fell away back in Modern.
6428	644	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	1	0	65	Day 2	Italians	Rakdos Grief	5-3 D1, then 4-4 D2. Just never any real momentum.
6698	785	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	66	Day 2	Worldly Counsel		5-3 overnight into 4-4 D2. Never managed three wins in a row.
5995	421	3	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	4	1	67	Day 2	Chen Chen Ji Sun		Perfect Draft on D1, doubled up to 6-0, but 3-7 from there, not even enough to requalify. Disappointing after such a great opportunity.
5678	249	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	3	0	68	Day 2	Handshake		Solid 4-2 in Draft, positive 2-1s both days, but only 5-5 in Modern.
6005	425	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	69	Day 2	Jirkal Pisano		6-2 D1, only 3-5 D2, eliminated in R14.
5568	199	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	70	Day 2			Uphill struggle from 1-3, recovered to 5-3, then 4-4 D2.
5951	398	3	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	71	Day 2	Moriyama Japan	Four-Color Omnath	Draft pod win D1, 5-3 overnight, but no momentum in a 4-4 D2.
6141	495	3	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	73	Day 2		Golgari Yawgmoth	3-0 in Draft, 5-3 D1, eliminated early in Modern on D2.
7070	973	3	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	74	Day 2	Coalition Victory		Trophy in D1 Draft, but fell away from a high point at 5-1, ending 5-5 in Modern.
5774	307	3	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	4	0	75	Day 2			Started with a Draft trophy, advanced to 7-2, but then hit four straight losses to eliminate from contention.
6174	508	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	76	Day 2			Nice run of five from six in the middle rounds, but out of the running in R12.
6283	567	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	77	Day 2		Rakdos Grief	From 1-3, five straight wins put him back into the mix, and he lasted until R13 before fading.
5263	24	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	78	Day 2			Decent 4-2 in Draft, 2-1 both days, but only 5-5 in Modern.
5452	131	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	79	Day 2	Chang Lee		Scraped into D2, but eliminated at 4-5 before a solid finishing run.
6121	486	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	80	Day 2	Japan 2	Four-Color Omnath	4-4 D1, 5-3 D2, but out of the running before the return to Modern.
5761	298	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	81	Day 2	Scoreboard		6-4 in Modern, 3-3 in Draft not enough.
6523	691	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	82	Day 2			6-4 in Modern, 3-3 in Draft not enough.
6776	821	3	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	84	Day 2	Guillotine		Turned around a 1-3 start to 5-3 overnight, won the last couple of rounds for a positive finish.
6640	753	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	85	Day 2			From 2-4 won seven of the next eight, but those four early losses were critical.
5241	14	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	86	Day 2		Four-Color Rhinos	Won five of his last seven on D2, but already out of contention at 4-5.
5486	150	3	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	3	1	87	Day 2			Fell to 0-2 before six straight wins left him on target for Top 8. An 0-3 D2 Draft changed that.
7068	972	3	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	88	Day 2	Sewer Rats		Four times had back to back wins. Never turned that into three straight.
5921	382	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	89	Day 2	Heng Hoon Soh		Fought back from 1-4 to reach D2, and then had a positive 5-3 there.
6148	498	3	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	90	Day 2		Merfolk	Once again Constructed dominated. An excellent 8-2 in Modern with Merfolk, but only a single Draft win more than compensated.
5507	168	3	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	91	Day 2	Handshake		1-3 became 5-3, but a second 1-2 Draft eliminated him.
7156	1014	3	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	92	Day 2	Handshake	Rakdos Grief	4-4 into 5-3 D2, never in the running.
5701	264	3	t	f	3	3	0	2	1	1	0	0	5	3	2	8	6	2	8-6-2	5	1	2	3	5	0	0	0	0	f	2	2	0	93	Day 2			Only one D1 loss, but two Modern draws kept him mid-table through a 3-5 D2.
6760	816	3	t	f	3	2	1	2	1	0	0	0	5	5	0	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	2	2	0	94	Day 2	Handshake	Rakdos Grief	5-3 overnight, but a mixed D2 saw him out of contention early.
5453	132	3	t	f	5	1	0	2	2	0	1	0	3	6	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	4	2	0	95	Day 2			Highlight was trophy in D2, but a 3-6-1 Modern record was nowhere near sufficient.
5604	216	3	t	f	4	2	0	2	1	1	1	0	4	5	1	8	7	1	8-7-1	6	2	0	2	5	1	0	0	0	f	5	4	1	96	Day 2			Recovered from 0-2 start, winning eight of the next nine to be 8-3 heading back to constructed. Unfortunately, didn't win a match in the last five.
6009	428	3	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	3	0	97	Day 2	Tilt	Four-Color Omnath	Midfield throughout, with D2 5-3 giving him a winning record.
6215	523	3	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	3	0	98	Day 2	Sewer Rats		A Modern draw on D2 ultimately contributed to an overall winning record of 8-7-1.
6803	834	3	t	f	3	2	1	2	1	0	0	0	5	5	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	2	3	0	99	Day 2			Fair 3-2-1 Draft record, average 5-5 in Modern.
6087	467	3	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	7	5	1	100	Day 2	Handshake		So much promise, then so much heartache. 3-0, then 7-0, then out at 7-5, with a 7-1 D1, 1-7 D2 split.
6290	569	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	101	Day 2			After a disastrous 0-3 Draft, won six of the next seven, before slipping away back in Modern.
6194	515	3	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	5	1	104	Day 2	Italians	Rakdos Grief	At 3-3, put together five on the bounce, before unfortunately matching that with five straight defeats, ending even at 8-8.
7007	937	3	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	105	Day 2			Already out at 4-5 before four straight wins pushed him to eventual parity.
6004	424	3	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	5	0	106	Day 2	Jia Jiao Yu		High point was 5-1, but eliminated after an 0-3 D2 Draft.
6081	463	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	107	Day 2			3-1 the high point, and 5-3 overnight before a 3-5 reverse on D2.
6794	831	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	109	Day 2	Handshake	Izzet Murktide	Two stretches of three wins kept him in the mix until Modern on D2, but once there he only found a single win.
5266	25	3	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	110	Day 2	Channel Fireball	Rakdos Grief	Another 4-1 start, but ended D1 at 4-4, and matched that on D2.
6860	871	3	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	111	Day 2			2-1 in both Drafts, but 4-6 in Modern.
6201	516	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	112	Day 2	Handshake	Mono-Green Tron	Matching 4-4 records, and an even split in both Draft (3-3) and Modern (5-5)
6346	598	3	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	113	Day 2	French	Temur Rhinos	Four straight D1 wins were the highlight, but 3-5 on D2 kept him firmly out of the mix.
6897	888	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	114	Day 2			5-3 D1 into 3-5 D2.
5280	33	3	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	5	0	115	Day 2			Perfect 4-0 led to elimination at 4-5, before righting the ship towards the end.
5559	191	3	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	5	0	116	Day 2			Solid 6-4 in Modern, but a costly 0-3 in Draft on the second morning.
5276	30	3	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	117	Day 2	Sewer Rats		Highlight was trophy in Draft on D2, but 4-6 in Modern.
6046	447	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	118	Day 2	Sanctum of All	Rakdos Grief	Solid D1, but quickly out of contention on D2.
6320	587	3	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	119	Day 2	Worldly Counsel		Perfect start with Draft trophy D1, but out of contention after R10.
7042	958	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	120	Day 2	Canadians		Even all the way, and had to win the last three to get there.
6181	513	3	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	121	Day 2		Rakdos Grief	Four straight D1 wins ensured D2, but soon out of the running.
5965	403	3	t	f	1	4	0	2	0	2	0	0	6	4	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	3	0	122	Day 2	Handshake	Rakdos Grief	Battled back from 1-3 to make D2, but soon out of contention.
7188	1025	3	t	f	2	3	0	2	1	0	0	0	5	5	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	2	2	0	123	Day 2			Only won twice in a row on one occasion, and quickly out of contention on D2.
6684	775	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	124	Day 2	Sanctum of All		Managed four straight from R6-9, and that included three must wins to advance,
6451	658	3	t	f	1	4	0	2	0	2	0	0	6	4	0	7	8	0	7-8-0	3	4	0	4	4	0	0	0	0	f	3	3	0	125	Day 2	Rampant Growth Heavy Play		Had the opening round bye, but couldn't take advantage, losing two 'real' Draft rounds, before endind Day 1 even. Won last three rounds to reach parity.
5807	321	3	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	126	Day 2	Scoreboard		Strong in Modern (7-3), weak in Draft (1-5).
5996	422	3	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	127	Day 2	Jia Jiao Yu		Strung three wins together, and two in a row twice, but out of contention by the end of R9.
6601	728	3	t	f	1	4	0	2	0	2	0	0	6	4	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	2	2	0	128	Day 2	Sanctum of All	Living End	Did well to fight back from 1-3 to reach D2, and finished 8-8 without ever threatening.
6915	897	3	t	f	3	3	0	2	1	1	0	0	4	5	1	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	3	0	130	Day 2			Great start, opening 4-1, before losing five of the next six.
5653	238	3	t	f	2	3	1	2	0	1	0	0	5	5	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	4	0	131	Day 2		Rakdos Grief	For the third event running, he scraped into D2. This time there was no solid recovery.
6627	744	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	7	0	132	Day 2	Sewer Rats		A tale of two halves, going 2-1, 4-2, 7-2, and then enduring a miserable streak of seven straight losses.
5946	395	3	t	f	5	1	0	2	2	0	1	0	2	6	0	7	7	0	7-7-0	5	3	0	2	4	0	0	0	0	f	4	3	0	133	Day 2			Trophy on the first morning in Draft, reached 4-0 before settling back into the pack.
6887	882	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	2	6	0	134	Day 2	Handshake	Mono-Green Tron	6-2 D1 before the wheels came off in a big way D2, with just a single match win.
6402	630	3	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	6	0	135	Day 2	Japan 2		Trophy to open in Draft, reached 4-0 and 5-3 overnight, but a difficult 2-6 on D2, including a reverse 0-3 in the second Draft.
5524	177	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	5	0	136	Day 2		Four-Color Omnath	Solid 5-3 D1, but a horrible 2-6 D2.
6531	696	3	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	5	1	137	Day 2	Canadians	Jeskai Breach	Five straight wins on D1 was followed by five straight defeats, more than enough to end his chances.
5341	75	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	138	Day 2			3-1 the highpoint. Fair 3-3 in Draft, but 4-6 in Modern.
6552	702	3	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	139	Day 2	Wu Hayne		Turned R1 loss around, reaching 4-1, then falling away.
6295	571	3	t	f	2	4	0	2	0	2	0	0	5	3	0	7	7	0	7-7-0	5	3	0	2	4	0	0	0	0	f	3	2	0	140	Day 2			Best phase when winning three straight at the end of D1, lost R13 and R14 to extinguish requalification hopes.
6863	872	3	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	5	0	141	Day 2			Tremendous start, opening 5-1, and still live heading back to Modern on D2, but then lost to Japanese Hall of Famers Shuhei Nakamura and Shota Yasooka.
6623	740	3	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	4	0	142	Day 2			Four in a row on D1, 2-4 overall in Draft was the weak spot.
7202	1032	3	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	143	Day 2	Moriyama Japan		Lost the last four on D2 to slide below parity.
6585	721	3	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	145	Day 2			Won elimination match R8 to advance, then 3-5 on D2.
5825	335	3	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	146	Day 2			After a slow 0-2 start, won five of six to reach 5-3 overnight. Disappointing 2-6 on D2.
6223	527	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	147	Day 2	Sewer Rats		Won five of six R6-11, but that was most of the winning.
6394	624	3	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	2	0	148	Day 2			Won three in a row, but all his other four victories were alone.
6883	880	3	t	f	0	5	0	2	0	2	0	1	6	4	0	6	9	0	6-9-0	3	4	0	3	5	0	0	0	0	f	2	3	0	149	Day 2	Sanctum of All		Decent 6-4 in Modern, but couldn't win a match in Draft.
6489	674	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	150	Day 2	CFB Ultimate Guard		Solid start at 4-2 and 5-3 overnight, but eliminated by Shota Yasooka in R10.
5315	58	3	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	151	Day 2			Only 2-4 in Draft meant never really in contention.
6721	797	3	t	f	3	2	1	2	1	0	0	0	3	4	0	6	6	1	6-6-1	5	3	0	1	3	1	0	0	0	f	2	2	0	152	Day 2	Sewer Rats		In decent shape at 5-2, but only one win from there before abandoming after R13.
6128	490	3	t	f	3	3	0	2	1	1	0	0	3	6	1	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	2	3	0	153	Day 2	Scoreboard		Opened 2-0, but needed R8 victory to advance. Only two wins on D2.
7155	1013	3	t	f	2	4	0	2	1	1	0	1	4	5	1	6	9	1	6-9-1	5	3	0	1	6	1	0	0	0	f	2	3	0	154	Day 2	Handshake		3-1 and then 5-3 overnight. Only a single D2 win.
6434	646	3	t	f	3	3	0	2	1	1	0	0	3	6	0	6	9	0	6-9-0	5	3	0	1	6	0	0	0	0	f	3	6	0	155	Day 2	Italians		Got to 4-1 and 5-3, but only a single win on D2.
5537	185	3	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	3	7	0	156	Day 2			Trophy on the first morning, wheels fell off D2 with just a single win.
5886	362	3	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	7	0	157	Day 2	Heng Hoon Soh	Rakdos Grief	The minimum 4-4 to advance, then a surprising 0-3 Draft.
6466	664	3	t	f	1	5	0	2	0	2	0	1	4	5	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	4	0	158	Day 2			1-5 in Draft the clear culprit.
6317	585	3	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	5	0	159	Day 2	Martin Orellana Perals Vigo		Strung four wins together R6-9, but 2-6 on D2.
6616	736	3	t	f	2	4	0	2	0	2	0	0	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	5	0	160	Day 2	Temple of Malady		Not much to shout about in either format.
7058	967	3	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	161	Day 2	CFB Ultimate Guard		Never better than 2-1, and eliminated by Anthony Lee in R9.
6016	431	3	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	6	0	162	Day 2	Alexander Johnson		From 1-3, won five of the next six, before elimination in R11. Then lost all five in Modern on D2.
5497	160	3	t	f	3	3	0	2	1	1	0	0	2	4	1	5	7	1	5-7-1	4	3	1	1	4	0	0	0	0	f	2	2	0	164	Day 2			Won twice to advance to D2, but only one win in five there before packing it in.
7148	1011	3	t	f	3	3	0	2	1	1	0	0	2	4	0	5	7	0	5-7-0	4	4	0	1	3	0	0	0	0	f	2	3	0	165	Day 2		Jeskai Control	3-1 and 4-2 but only 4-4 D1, and out of the running before the return to Modern.
6944	904	3	t	f	1	5	0	2	0	2	0	1	4	4	0	5	9	0	5-9-0	5	3	0	0	6	0	0	0	0	f	3	6	0	166	Day 2	Wu Hayne		5-3 D1, didn't win a match on D2.
5403	108	3	t	f	1	5	0	2	0	2	0	1	3	4	0	4	9	0	4-9-0	4	4	0	0	5	0	0	0	0	f	3	6	0	167	Day 2			Made it to D2, but couldn't win a match there.
5868	355	3	f	f	2	0	1	1	1	0	0	0	1	4	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	168	X	Hatchel Poulosky Zilles		Excellent start at 2-0-1, but lost in both R7 and R8 to be eliminated.
5836	342	3	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	169	X			Elimination came after two tough losses in R7 and R8.
6508	682	3	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	170	X	Channel Fireball		Forgettable 0-5 in Modern, but a fantatic Draft trophy to treasure.
7140	1009	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	171	X	Wu Hayne		Opened 2-1 in Draft, lost the last three in Modern to miss out.
6593	724	3	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	172	X	Worldly Counsel Heavy Play		Trophy in Draft, zero wins in Modern.
6089	468	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	173	X	Worldly Counsel	Rakdos Grief	2-1 in Draft, but just a single Modern win. No D2.
7091	981	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	174	X			Opened 2-1, lost R7 and R8 to fail to advance.
6675	773	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	175	X			Perfect 2-0, but only one win from there.
6095	469	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	176	X		Boros Burn	3-3, but lost his last two to be out D1.
6905	891	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	178	X	Chen Sun		Alternated losses and wins through R7, then didn't get the W R8.
5469	139	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	179	X	Chen Chen Ji Sun	Oops! All Spells!	2-1 in Draft, once again constructed was not his friend, going 1-4.
5710	267	3	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	180	X	Portugese+Brazilians		Trophy in Draft, zero wins in Modern.
6403	631	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	181	X			From 3-2 to 3-5 and no D2.
6806	835	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	182	X	Channel Fireball	Samwise Gamgee Combo	1-2 in Draft, then 2-3 in Modern, so no D2.
7083	978	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	183	X			Lost R7 and R8 from 3-3, so no D2.
6756	814	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	184	X	Portugese+Brazilians		Needed a R8 win, but lost to Willy Edel.
6218	524	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	186	X	Sewer Rats		3-3 into 3-5 to miss D2.
6962	919	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	187	X	Italians		Losses to Seth Manfield and Brent Vos in R7 and R8 meant no D2.
6445	654	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	189	X	Japan 2		Opened 2-0, lost elimination match R8 to Jordan Berkowitz.
7016	941	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	190	X	Channel Fireball	Golgari Yawgmoth	3-1 was a good start, but that was it. No D2.
7101	988	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	191	X	Wu Hayne	Four-Color Omnath	2-1 in Draft, but out before the last round of the day.
5329	67	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	192	X			Lost the elimination match R8.
6470	667	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	193	X	Italians		From 3-3 to 3-5, so no D2.
5274	29	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	194	X	French		Needed back to back wins R7 and R8, only got one of them.
5581	202	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	195	X	French	Golgari Yawgmoth	Somehow forced a win-and-advance from an 0-4 start, but lost to Living End for an unlikely elimination.
5720	273	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	196	X			3-3 to 3-5. No D2.
6294	570	3	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	197	X			Lost in R7 and R8 so no D2.
5755	293	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	198	X	Scoreboard		1-1, 2-2, 3-3, but not 4-4.
6029	438	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	199	X	Worldly Counsel		Needed back to back to advance, lost R8.
7138	1008	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	200	X			Won three straight, but that was it, leaving him one short.
6647	759	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	201	X	Worldly Counsel		In a 1-4 hole, won two in a row, but not R8.
6653	764	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	202	X			Lost R8 elimination match.
7162	1015	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	203	X	Moriyama Japan		Lost to Rob Pisano in R8 elimination match.
5925	385	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	205	X			Lost R8 elimination match.
6176	509	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	206	X			Lost R8 elimination match to Lee Shi Tian.
6790	829	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	207	X			Turned 0-4 into 3-5, but the last two wins were too late.
6896	887	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	208	X	Swiss		Won R1, and the last two, but too much losing in between.
6038	442	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	209	X	Elci Kacmaz		0-3 in Draft, fought back with 3-2 in Modern, but not enough for D2.
6268	558	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	210	X	Handshake		Never managed back to back wins.
5485	149	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	211	X			0-3 in Draft meant no D2, despite 3-2 Modern comeback.
6401	629	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	212	X			Kept going after 0-5 start, rewarded with three Modern wins.
6514	685	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	213	X	Milkshake		Lost R7 and R8 when a win in either would have seen D2 action.
6735	807	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	214	X	Spain		Creditable 3-2 in Modern after 0-3 Draft.
6625	742	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	215	X			Decent 3-2 in Modern, following 0-3 Draft.
5254	18	8	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	2	0	107	X		Mono-red Prowess	Just a single Draft win to show from five rounds before dropping.
5983	413	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	216	X	Scoreboard		Mountain to climb at 0-4, eliminated R7.
6619	737	3	f	f	1	1	1	1	0	0	0	0	1	3	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	3	0	217	X		Golgari Yawgmoth	Same story, one win in each format, no D2.
6912	896	3	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	4	1	0	1	0	0	0	0	f	1	2	0	218	X	Canadians	Temur Rhinos	One win in each format, so out on D1.
5383	100	3	f	f	1	1	1	1	0	0	0	0	1	3	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	2	0	219	X		Esper Control	Fought Rei Sato to an opening round draw in Ltd, but things didn't get much better. Out after R6.
6787	828	3	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	220	X	Sewer Rats		Got to 2-1, didn't win again.
5857	350	3	f	f	0	3	0	1	0	1	0	1	1	0	0	1	3	0	1-3-0	1	3	0	0	0	0	0	0	0	f	1	3	0	221	X			Pulled out at 1-3 after R4.
6420	643	3	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	222	X	Moriyama Japan	Four-Color Omnath	2-1 in the opening Draft, but didn’t win a round in Modern, meaning no D2.
6139	494	3	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	223	X	Sanctum of All		2-1 in Draft, but no Modern wins.
6701	787	3	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	225	X	Worldly Counsel		2-1 in Draft, but no wins in Modern.
5920	381	3	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	226	X	Sewer Rats		One win in each format, so no D2.
5635	228	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	227	X	Channel Fireball	Golgari Yawgmoth	A horror show on D1, with just one win in each format.
6919	899	3	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	228	X	2Free	jeskai Breach	A nice 2-1 in Draft to start, but nothing from Modern, so no D2.
5989	415	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	229	X	Worldly Counsel		Opened with a win, only got one more.
6077	461	3	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	230	X	Worldly Counsel		Begain 2-0, didn't win again.
6212	520	3	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	231	X			One win in each format.
7152	1012	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	232	X			Won the first round of both formats, but that was it.
6624	741	3	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	233	X			Reached 0-4 before winning a couple.
5824	334	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	234	X			1-0, but eliminated before his second win.
6724	798	3	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	235	X	Hauch Russel		2-3 in Modern, but 0-3 in Draft killed his chances.
6124	487	3	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	236	X			2-1 in Draft, zero wins in Modern.
6336	592	3	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	238	X	Wu Hayne		0-3 Draft meant no D2.
6952	912	3	f	f	0	2	0	1	0	1	0	0	1	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	3	0	239	X	Guillotine		Had to wait until R7 for lone win.
5434	122	3	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	240	X			One win in each format.
6629	745	3	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	241	X			Eliminated R7.
5561	193	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	243	X			One win in each format. Eliminated R7.
5674	246	3	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	244	X	Elci Kacmaz		It's not your day when your 0-2 Draft opponent is Shota Yasooka. Won twice in Modern.
5644	231	3	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	245	X	Arthur. Dutcher		1-1, then didn't win again.
6354	601	3	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	246	X			After 0-3 Draft, won a couple in Modern before eliminated R7.
7110	993	3	f	f	1	2	0	1	0	1	0	0	0	1	1	1	3	1	1-3-1	1	3	1	0	0	0	0	0	0	f	1	1	0	247	X			Lone win came in Draft.
6614	735	3	f	f	0	2	1	1	0	1	0	0	1	2	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	2	0	248	X			Out after R6 with one win.
6688	777	3	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	249	X	CFB Ultimate Guard		1-2 Draft, 0-3 Modern before elimination.
6976	922	3	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	250	X	Canadians		Opened 1-0, that was the only win.
6557	707	3	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	251	X	Moriyama Japan		Lone win at 0-2 in Draft.
5932	389	3	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	252	X	Worldly Counsel		Withdrew at 1-4.
7097	986	3	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	253	X			Lone win was the opener in Modern.
6101	471	3	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	254	X			1-1 to open, but no wins in Modern.
5306	51	3	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	255	X			Winless.
5812	324	3	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	256	X			1-2 Draft, 0-3 Modern, out.
6643	756	3	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	257	X			From 0-4, won once before elimination.
6393	623	3	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	258	X			1-2 Draft, but 0-5 Modern.
6316	584	3	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	259	X			Lone win was in Modern.
5445	127	3	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	263	X			Had to wait until R6 to win a game. No match wins.
7192	1027	3	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	265	X			Dropped at 0-5.
6536	697	3	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	266	X	Scoreboard	Rakdos Grief	Began and ended with zero wins, dropping after R5.
5582	202	4	t	t	5	1	0	2	2	0	1	0	8	2	0	13	3	0	13-3-0	4	3	0	6	0	0	3	0	0	t	3	2	0	1	Champion	French	Esper Legends	From 4-1 to 4-3, but only lost once on D2 to reach the T8. After edging Greg Orange in the QFs, he swept both Anthony Lee and then Kazune Kosaka to claim the title.
6132	491	4	t	t	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	5	2	0	5	1	0	2	1	0	t	5	2	1	2	Finals	Japan 2	Esper Midrange	Only 2-2 to start, but brilliant from there on. 5-2 overnight, five straight on D2 to reach the T8 with a round to spare. Beat Willy Edel in the QFs before sweeping aside Simon Nielsen 3-0 in the Semis. But Jean-Emmanuel Depraz in the Final was a bridge too far.
6500	679	4	t	t	4	2	0	2	1	1	1	0	7	1	0	11	3	0	11-3-0	5	2	0	5	0	0	1	1	0	t	10	2	1	3	Semifinals	Handshake	Azorius Soldiers	A THIRD T8 in a row, this time from a precarious 0-2. Ten wins in a row followed, frankly absurd numbers. Beat Lorenzo Terlizzi in the QFs, but was swept by Kazune Kosaka in the Semis. Nonetheless, and incredible season.
6202	516	4	t	t	5	1	0	2	2	0	1	0	5	3	1	10	4	1	10-4-1	6	0	1	3	3	0	1	1	0	t	4	2	0	4	Semifinals	Handshake	Golgari Midrange	A career-best performance. First, only a single draw blemished an otherwise perfect D1. Despite two losses in three rounds to Reid Duke, he held his nerve, securing his T8 berth with a win over Eli Kassis. Got the one that really mattered against Reid Duke in the QFs, before eventual winner Jean-Emmanuel Depraz swept him in the Semis.
5636	228	4	t	t	5	1	0	2	2	0	1	0	5	1	0	10	2	0	10-2-0	6	1	0	4	0	0	0	1	0	t	9	1	1	5	Top 8	CFB Ultimate Guard	Domain Ramp	Perfect in Standard on D1, perfect in Draft on D2, a crushing performance that saw him into the T8 with three rounds to spare. Anthony Lee got in the way in the QFs, defeating him in the deciding game.
6547	701	4	t	t	3	3	0	2	1	1	0	0	7	2	0	10	5	0	10-5-0	6	1	0	4	3	0	0	1	0	t	6	2	1	6	Top 8		Bant Control	After losing R1 to Yuta Takahashi, was perfect the rest of D1. 1-2 in Draft D2 set him back, but won his last three to secure a T8 spot. Lost the deciding game of the QFs to Jean-Emmanuel Depraz.
5654	238	4	t	t	4	2	0	2	1	1	1	0	6	3	0	10	5	0	10-5-0	4	3	0	6	1	0	0	1	0	t	4	1	0	7	Top 8	Portugese+Brazilians	Domain Ramp	4-3 on D1 turned into 6-1 on D2, taking him into the T8, where he faced Kazune Kosaka for a second time. And, for a second time, Kosaka's Esper Midrange deck defeated him, leaving Edel out in the QFs.
6966	920	4	t	t	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	4	3	0	6	1	0	0	1	0	t	6	1	1	8	Top 8		Esper Midrange	Reached D2 with a final round win over Stefan Schutz, then only lost once on D2, winning his last six to reach the T8. Swept by Simon Nielsen in the QFs.
6580	717	4	t	f	5	1	0	2	2	0	1	0	4	2	1	9	3	1	9-3-1	5	2	0	4	1	1	0	0	0	t	3	2	0	9	Top 16	Handshake Ultimate Guard		Excellent 5-1 in Draf, but a deeply costly draw against Eli Kassis in R12 saw him fall agaonizingly short of Top 8.
5810	322	4	t	f	5	1	0	2	2	0	1	0	4	3	1	9	4	1	9-4-1	6	1	0	3	3	1	0	0	0	t	6	2	1	10	Top 16			Paced the field at 6-0 and again at 8-1. Only one won of the last five.
6059	451	4	t	f	6	0	0	2	2	0	2	0	3	4	1	9	4	1	9-4-1	5	2	0	4	2	1	0	0	0	t	4	1	0	11	Top 16	CFB Ultimate Guard	Domain Control	Won his D1 Draft, then 5-2 overnight, before another pod win to start D2. At 8-2 in tremendous shape to T8, before two losses and a draw derailed him.
6920	899	4	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	6	1	0	3	4	0	0	0	0	t	5	2	1	12	Top 16	Misfits	Esper Midrange	Super start, ending D1 at 6-1, lasted until R13 before being knocked out of contention by Kazune Kosaka.
6816	838	4	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	6	1	0	3	4	0	0	0	0	t	5	2	1	13	Top 16	Japan 2		Powered to 6-1 overnight, but losing record on D2.
6938	903	4	t	f	4	2	0	2	1	1	1	0	5	3	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	5	3	1	14	Top 16	Misfits	Golgari Midrange	Much better start at 5-0. Won his last three, but T8 was out of reach.
6569	711	4	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	t	3	1	0	15	Top 16	Channel Fireball	Mono-White Humans	Average D1 at 4-3 improved to 5-2 D2, but ran out of rounds.
7071	973	4	t	f	2	4	0	2	0	2	0	0	7	1	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	5	2	1	16	Top 16	Misfits		Turned 1-2 into 6-2, and went 3-1 on D2 in Standard, but still not quite enough.
6302	575	4	t	f	4	2	0	2	2	0	0	0	4	3	1	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	t	2	2	0	17	Top 32	Channel Fireball	Domain Ramp	2-1 in both Drafts kept him in contention to the penultimate round, where Alexey Paulot ended his run.
5242	14	4	t	f	5	1	0	2	2	0	1	0	3	4	0	8	5	0	8-5-0	4	3	0	4	2	0	0	0	0	t	3	3	0	18	Top 32	Sewer Rats	Esper Midrange	Perfect 3-0 start in draft, then lost the first three in Standard. Still in contention with two rounds to go, Willy Edel ended his chances.
5723	276	4	t	f	4	1	1	2	2	0	0	0	4	4	0	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	f	2	1	0	19	Top 32	Sanctum of All		Solid 4-1-1 in Draft, but only even at 4-4 in Standard.
5756	293	4	t	f	4	2	0	2	2	0	0	0	4	3	0	8	5	0	8-5-0	5	2	0	3	3	0	0	0	0	t	3	2	0	20	Top 32	Scoreboard		Twice won three in a row, and was right in the thick of it at 8-3, before failing to beat Esper Midrange three rounds in a row.
6678	774	4	t	f	3	2	1	2	1	1	0	0	5	3	0	8	5	1	8-5-1	4	3	0	4	2	1	0	0	0	f	3	2	0	21	Top 32	Sanctum of All	Grixis Midrange	4-3 D1, improved with 2-0-1 D2 Draft, before Seth Manfield eliminated her from contention in R12.
6211	519	4	t	f	2	4	0	2	0	2	0	0	6	1	1	8	5	1	8-5-1	4	2	1	4	3	0	0	0	0	f	3	3	0	22	Top 32			In an 0-2 hole, had too much to do at 5-5-1. Still won his last three, including wins over Jim Davis and Gabriel Nassif.
6347	598	4	t	f	2	4	0	2	0	2	0	0	6	2	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	5	3	1	23	Top 32	French	Esper Legends	1-2 became 5-2, but three straight D2 losses eliminated him.
5704	265	4	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	3	3	0	24	Top 32	Misfits	Rakdos Sacrifice	Only 3-3 in Draft this time, and couldn't accelerate in Standard on D2.
6284	567	4	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	2	0	25	Top 32		Rakdos Sacrifice	4-3 overnight, before three wins kept him alive to the penultimate round, where Mitchell Tamblyn ended things.
6421	643	4	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	2	0	26	Top 32	Moriyama Japan	Esper Legends	From a tenuous 4-3 to 7-4, before Sam Pardee eliminated him from contention in R12.
5907	374	4	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	3	0	27	Top 32	Moriyama Japan		Solid 4-2, 2-1 in both Drafts, but only 4-4 in Standard.
5371	93	4	t	f	4	2	0	2	2	0	0	0	3	3	2	7	5	2	7-5-2	4	2	1	3	3	1	0	0	0	t	3	2	0	28	Top 32			4-1-1, later 7-3-1 still in contention, but lost the last two rounds to Jean-Emmanuel Depraz and Sam Pardee.
6429	644	4	t	f	4	2	0	2	1	1	1	0	3	4	1	7	6	1	7-6-1	4	2	1	3	4	0	0	0	0	f	4	3	0	29	Top 32		Esper Midrange	3-0 Draft start, peaked at 5-0, but 3-4 on D2 kept him well away from T8.
6477	669	4	t	f	3	2	1	2	1	1	0	0	4	4	0	7	6	1	7-6-1	5	1	1	2	5	0	0	0	0	f	3	3	0	30	Top 32	Channel Fireball	Domain Ramp	5-1-1 D1, but three defeats early on D2 killed his chances.
6160	502	4	t	f	5	1	0	2	2	0	1	0	2	5	0	7	6	0	7-6-0	4	3	0	3	3	0	0	0	0	f	4	4	0	31	Top 32	Handshake	Esper Control	Perfect 3-0 Draft, but fell from 4-0 to 4-3 overnight. Lost an Esper Midrange mirror in R11 to end his chances.
5887	362	4	t	f	3	3	0	2	1	1	0	0	4	3	0	7	6	0	7-6-0	5	2	0	2	4	0	0	0	0	f	4	3	0	32	Top 32	SE Asia	Mono-Red Aggro	5-2 D1, but 1-2 D2 Draft damaged his chances.
5296	45	4	t	f	4	2	0	2	2	0	0	0	3	4	0	7	6	0	7-6-0	4	3	0	3	3	0	0	0	0	f	3	2	0	33	Day 2	Sanctum of All	Domain Ramp	Won his last two to reach D2, got to 7-4, before Greg Orange finished his hopes.
6932	1060	4	t	f	2	4	0	2	0	2	0	0	5	2	0	7	6	0	7-6-0	5	2	0	2	4	0	0	0	0	f	4	2	0	34	Day 2	Worldly Counsel		From 1-2, went to 5-2 overnight, but eliminated R11.
5609	217	4	t	f	2	4	0	2	1	1	0	1	5	2	0	7	6	0	7-6-0	5	2	0	2	4	0	0	0	0	f	2	3	0	35	Day 2	Handshake	Golgari Midrange	5-2 overnight, but 0-3 in D2 Draft took him out of the running.
5428	121	4	t	f	4	1	1	2	2	0	0	0	3	5	0	7	6	1	7-6-1	4	3	0	3	3	1	0	0	0	f	4	3	0	36	Day 2	Portugese+Brazilians	Mono-Red Aggro	6-3-1 and in the mix after R10, but then the wheels fell off with three straight defeats.
6761	816	4	t	f	4	2	0	2	1	0	1	0	3	4	1	7	6	1	7-6-1	4	3	0	3	3	1	0	0	0	f	3	3	0	37	Day 2	Handshake	Esper Control	3-0 in Draft to start, but only one D1 Standard win. Soon out of contention on D2.
5407	109	4	t	f	2	4	0	2	0	2	0	0	5	2	0	7	6	0	7-6-0	4	3	0	3	3	0	0	0	0	f	3	2	0	38	Day 2	Italians	Esper Control	From 1-3, won his last three on D1 to advance. Finished with an honorable 7-6-1 record.
6532	696	4	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	5	2	0	2	5	0	0	0	0	f	3	5	0	39	Day 2	Scoreboard	Mono-Blue Cauldron	A fair 3-2 became an interesting 6-2, before an 0-3 D2 Draft eliminated him from contention.
5552	189	4	t	f	1	5	0	2	0	2	0	1	7	1	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	4	5	0	40	Day 2	CFB Ultimate Guard	Mono-White Humans	His Constructed prowess continued from LOTR on D1 here, sweeping D1 Standard. He fell away after an 0-3 in Draft to open D2.
6898	888	4	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	4	3	0	41	Day 2			Lost R1, then won four straight. Couldn't press on from there.
6788	828	4	t	f	2	4	0	2	1	1	0	1	4	4	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	2	0	44	Day 2			Got to 4-2, then didn't win again until R12.
6717	796	4	t	f	1	5	0	2	0	2	0	1	4	3	0	5	8	0	5-8-0	4	3	0	1	5	0	0	0	0	f	2	3	0	45	Day 2	Sewer Rats	Golgari Midrange	Barely made D2, before 0-3 on D2 Draft.
6170	505	4	t	f	4	2	0	2	2	0	0	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	4	0	46	Day 2			4-3 D1 into 2-5 D2.
5875	358	4	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	3	0	47	Day 2		Azorius Tokens	4-3 D1, but only 2-5 D2.
6821	842	4	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	4	5	0	48	Day 2	Channel Fireball		High water mark of 4-1, but a poor 2-5 D2.
5439	124	4	t	f	2	3	1	2	1	1	0	0	3	5	0	5	8	1	5-8-1	4	3	0	1	5	1	0	0	0	f	2	3	0	49	Day 2	Worldly Counsel	Rakdos Reanimator	Won his D2 eliminator in R7, but only a draw from Ltd on D2, and lost his last three.
7170	1019	4	t	f	1	5	0	2	0	2	0	1	3	3	1	4	8	1	4-8-1	4	2	1	0	6	0	0	0	0	f	3	4	0	50	Day 2		Sultai Faeries	4-2-1 overnight, but 0-3 in D2 Draft to take him out of the running.
6404	631	4	f	f	3	0	0	1	1	0	1	0	0	3	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	3	3	0	51	X			Trophy in Draft, but with no Standard wins, no D2.
6553	703	4	f	f	2	1	0	1	1	0	0	0	1	2	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	2	0	52	X	Martin Orellana Perals Vigo		Started 2-0, but lost the elimination match in R7.
7082	977	4	f	f	1	2	0	1	0	1	0	0	2	1	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	3	0	53	X	Misfits		Won the last two, but already eliminated by then.
6892	884	4	f	f	0	3	0	1	0	1	0	1	3	0	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	3	0	54	X			So close. 3-0-1 in Standard, but an 0-3 Draft saw him fall short of D2.
7060	968	4	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	55	X		Esper Legends	3-2, but lost his last two rounds to miss D2.
7193	1028	4	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	3	0	56	X	Worldly Counsel		Got to 3-1, so had three chances to advance, and took none of them.
5525	177	4	f	f	3	0	0	1	1	0	1	0	0	4	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	4	0	58	X	Sewer Rats	Selesnya Enchantments	Perfect Draft 3-0, imperfect Standard 0-4, no D2.
5384	100	4	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	59	X	Sanctum of All	Azorius Soldiers	3-1 became 3-4, at the hands of Javier Dominguez, Jim Davis, and Karl Sarap - quite the gauntlet.
5442	125	4	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	60	X	Portugese+Brazilians		Opened 2-0, but lost twice at the back end to miss D2.
5366	90	4	f	f	3	0	0	1	1	0	1	0	0	4	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	4	0	61	X			Trophy in Draft, zilch in Standard.
6356	602	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	1	0	62	X	Portugese+Brazilians		Lost to Marcio Carvalho in a must-win R7.
5861	351	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	63	X	Worldly Counsel	Esper Midrange	1-2 in Draft, and eliminated by Takumi Matsuura in R6.
6122	486	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	64	X	Japan 2	Esper Midrange	Always being from 0-2, had to win his last round of the day, and didn't.
6861	871	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	65	X	Heng Hoon Soh		3-2, but lost both chances to advance.
6795	831	4	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	3	0	66	X	Handshake	Esper Control	0-3 in Draft, and 3-1 in Standard couldn't save him.
5952	398	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	67	X	Moriyama Japan	Esper Midrange	1-2 in Draft left him in trouble, and lost to Rei Hirayama in R7 to miss out on D2.
5267	25	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	68	X	Worldly Counsel	Rakdos Reanimator	Failed to make D2, eliminated after R6, won his meaningless final match to end 3-4.
6172	506	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	69	X	Scoreboard		Out after R5 at 1-4.
6537	697	4	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	3	0	70	X	Sewer Rats	Mono-Red Aggro	From 0-3 to 3-3, but lost R7 to miss D2.
6355	601	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	2	0	71	X	Sanctum of All		Turned 0-2 into 3-2, but lost twice to be out on D1.
6327	589	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	72	X	Moriyama Japan	Mono-Red Aggro	1-2 in Draft, and couldn't turn it round in Standard, meaning no D2.
7038	956	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	73	X		Esper Legends	Always behind, ruled out of D2 after R6.
5543	188	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	75	X	Misfits	Esper Midrange	Beaten twice by Matt Foreman, he was never above .500, and didn't make D2.
5470	139	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	3	0	76	X	Chinese	Rakdos Burn	From 1-3, couldn't get it done.
6055	450	4	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	2	4	0	77	X	Worldly Counsel		2-0, before four straight defeats.
5984	413	4	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	78	X	Scoreboard		Began 2-0, but nothing after that.
6780	823	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	79	X	Sewer Rats		Eliminated after R6.
5616	218	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	80	X		Esper Midrange	One win in each format, not close to D2.
7020	942	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	82	X			2-2, but finished 2-5.
6594	724	4	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	83	X			Already out when winning a couple of Standard rounds.
6372	608	4	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	84	X	French		Couldn't come back from an 0-3 Draft. Eliminated by Jake Beardsley in R6.
5572	200	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	85	X	Worldly Counsel	Rakdos Reanimator	Only one win in each format, nowhere near enough for D2.
7045	959	4	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	2	3	0	86	X		Five-Color Reanimator	2-1 in Draft, but 0-3 in Standard meant no D2.
7122	998	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	87	X			Needed three straight to advance from 1-3, only managed one.
5255	18	9	t	f	3	2	1	2	1	0	0	0	8	2	0	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	t	5	1	1	14	Top 16		Gruul Mice	
7214	1038	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	151	X			Not a great day, losing three straight to finish 3-5.
5779	309	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	88	X	SE Asia		Still live at 2-3, but ended 2-5.
5792	312	4	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	89	X	Sewer Rats	Selesnya Enchantments	After three straight D2s, this was a D1 horror show, with just one win in each format.
6770	818	4	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	90	X	Japan 2		Out at the earliest opportunity at 0-4. Won a couple in Standard when it didn't matter.
6811	837	4	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	2	0	91	X	Misfits	Sultai Midrange	One win in Draft, none in Standard, out after R5.
5782	310	4	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	2	0	93	X	Worldly Counsel	Rakdos Reanimator	Just a single Draft win, before being eliminated at 1-4.
6195	515	4	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	94	X		Esper Legends	Won R1. That's the tweet, won R1.
6702	787	4	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	4	0	95	X			Won R1 before four straight losses.
6773	819	4	f	f	0	3	0	1	0	1	0	1	1	1	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	97	X	Moriyama Japan	Mono-Red Aggro	Just one win all day, out after R5. Again.
5597	210	4	f	f	0	3	0	1	0	1	0	1	1	1	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	98	X			0-3 in Draft meant a quick exit.
6542	699	4	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	100	X	Bus Stop + Sewer Rats		0-4 drop, winning a single game in Draft.
5397	107	4	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	102	X	Worldly Counsel	Esper Midrange	A horror show of 0-4 drop, leaving Calcano without a match win at the World Championship.
6149	498	4	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	103	X		Invasion of Alara	The worst possible outcome, eliminated after the minimum four rounds.
6749	813	4	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	104	X		Domain Ramp	Disaster. Came with nothing, left with nothing.
6303	575	5	t	t	4	2	0	2	2	0	0	0	11	1	1	15	3	1	15-3-1	5	2	1	7	1	0	3	0	0	t	6	1	1	1	Champion	CFB Ultimate Guard	Rakdos Vampires	After a 4-1 start, a draw and loss looked like derailing things. He only lost once more, early on D2, before rattling off six wins to make T8. With the outstanding Rakdos Vampires, he was never in trouble in the elimination rounds, beating Jean-Emmanuel Depraz, Mingyang Chen, and finally Simon Nielsen, all by 3-1, to claim the title.
6501	679	5	t	t	4	2	0	2	1	1	1	0	10	2	0	14	4	0	14-4-0	7	1	0	5	2	0	2	1	0	t	5	2	1	2	Finals	Handshake	Boros Heroic	A stupendous four in a row, despite, for him, an only average 4-2 Draft record. With Boros Heroic, he went 8-2, then took it past Adam Edelson and Christoffer Larsen, before losing the Final to Seth Manfield, setting up an epic Player of the Year race in the process.
6182	513	5	t	t	4	2	0	2	2	0	0	0	9	3	0	13	5	0	13-5-0	6	2	0	6	2	0	1	1	0	t	5	2	1	3	Semifinals	Handshake	Amalia Combo	A tremendous 6-1 looked like being squandered at 6-3, before another four straight wins. Beat Izzet Phoenix decks twice to reach the T8. Beat Alex Friedrichsen in the QFs before narrowly losing a remarkable SF to fellow Dane Simon Nielsen.
5460	137	5	t	t	5	1	0	2	2	0	1	0	8	3	0	13	4	0	13-4-0	6	2	0	6	1	0	1	1	0	t	4	1	0	4	Semifinals		Lotus Field Combo	Great Draft start, 6-2 overnight, another positive Draft D2, and won his last three in Pioneer to reach T8. Swept Sam Pardee in the QFs, before losing to Seth Manfield in the Semis.
6570	711	5	t	t	5	1	0	2	2	0	1	0	7	2	0	12	3	0	12-3-0	6	2	0	6	0	0	0	1	0	t	6	1	1	5	Top 8	CFB Ultimate Guard	Rakdos Vampires	Made the most of playing the deck of the tournament. Six straight wins D1, six straight wins D2, into the T8 with two rounds to spare. And then ran into a horrible match against Mingyang Chen, losing the QFs in an 0-3 sweep.
5734	282	5	t	t	4	2	0	2	2	0	0	0	8	1	1	12	3	1	12-3-1	6	1	1	6	0	0	0	1	0	t	6	1	1	6	Top 8		Lotus Field Combo	R1 was his only loss of D1 (with one draw), and astonishingly the same was true on D2, losing his opener to Logan Nettles, before six wins on the bounce took him to the T8. Lost 1-3 to Christoffer Larsen in the QFs.
5660	239	5	t	t	6	0	0	2	2	0	2	0	6	4	0	12	4	0	12-4-0	7	1	0	5	0	0	0	1	0	t	6	2	1	7	Top 8		Izzet Phoenix	Started winning his Draft pod, kept things going to 7-1, then got the Draft 6-0, leaving him in prime position for T8. Lost a couple of chances, but took the third, beating Simon Nielsen in R15 to reach the T8. Nielsen was waiting there, and soon had his revenge, sweeping Edelson out in the QFs.
5583	202	5	t	t	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	6	2	0	6	1	\N	0	1	0	t	6	2	1	8	Top 8	Guillotine	Izzet Phoenix	Turned an 0-2 start well and truly around, finishing D1 at 6-2, then only losing once on D2 for the second tournament running. Went into the T8 unbeaten in Pioneer, but lost to the deck of the tournament (Rakdos Vampires) in the hands of Seth Manfield in the Quarterfinals.
5610	217	5	t	f	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	5	2	1	9	Top 16	Handshake	Izzet Phoenix	Three of his four losses were to Reid Duke, Marcio Carvalho, and Willy Edel. But four losses were also just enough to keep him out of the T8, despite winning his last five in a row.
7236	18	10	t	f	3	2	1	2	1	0	0	0	8	2	0	11	4	1	11-4-1	7	1	0	4	3	1	0	0	0	t	7	1	1	12	Top 16		Mono-Red Aggro	
6096	469	5	t	f	4	2	0	2	1	1	1	0	7	2	1	11	4	1	11-4-1	5	3	0	6	1	1	0	0	0	t	6	2	1	10	Top 16	Bus Stop	Azorius Control	From 2-3, went into overdrive, he only lost once more, to Christoffer Larsen in R12, finishing just short of T8.
6836	854	5	t	f	4	2	0	2	1	1	1	0	7	2	0	11	4	0	11-4-0	6	2	0	5	2	0	0	0	0	t	8	1	1	11	Top 16	Portugese+Brazilians	Izzet Phoenix	1-2, then a tremendous run of eight straight took him deep. Alex Friedrichsen ended his chances in R15.
6925	900	5	t	f	5	1	0	2	2	0	1	0	6	3	1	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	f	3	2	0	12	Top 16	Moriyama Japan	Azorius Control	3-0 Draft, handy 5-2-1 overnight. 4-1 down the stretch wasn't quite enough, a D1 draw against Shota Yasooka ultimately proving costly.
6954	914	5	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	7	3	1	13	Top 16		Lotus Field Combo	Outstanding 7-0 start, and 9-1, eventually losing a last round win-and-in against Seth Manfield.
7176	1020	5	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	6	3	1	14	Top 16		Jeskai Creativity	Solid 2-1 into excellent 8-2, then 11-2. Three brutal losses, against Sam Pardee, Jean-Emmanuel Depraz, and Simon Nielsen (all win-and-ins), meant no T8.
5900	371	5	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	f	4	2	0	15	Top 16	Sewer Rats	Izzzet Ensoul	From a 3-0 Draft, accelerated to 7-1. Couldn't keep things moving, but still live until R14, when Dillon Kikkawa stopped him.
5841	346	5	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	8	0	0	3	5	0	0	0	0	t	8	2	1	16	Top 16	Handshake	Izzet Phoenix	Perfect D1 in both formats. Tougher D2, obviously, reaching 3-3, giving him two win-and-ins for T8. He lost to Seth Manfield, and then Christoffer Larsen in R16.
6060	451	5	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	4	3	0	17	Top 32	Handshake	Amalia Combo	6-2, then 5-3, but winning his last four matches was already irrelevant thanks to three straight losses early on D2.
5783	310	5	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	3	2	0	19	Top 32	Worldly Counsel	Lotus Field Combo	3-0 in Draft, 6-2 overnight, then 9-3. Luis Scott-Vargas and Brian Boss ended his chances, before he won his last two.
6665	768	5	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	1	0	20	Top 32			A frsutrating loss to Piotr Glogowski when at 7-4 meant no T8, despite then winning the last four.
6422	643	5	t	f	2	4	0	2	0	2	0	0	9	1	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	2	1	21	Top 32	Moriyama Japan	Izzet Phoenix	A decent 5-3 saw him out of contention at  6-5, before he swept his way through D2 in Pioneer, 5-0.
6439	650	5	t	f	2	4	0	2	1	1	0	1	9	1	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	7	3	1	22	Top 32	Temple of Malady		Left rueing an 0-3 first Draft, because followed with seven straight. Later, won the last four rounds, but by then it was too late.
6187	514	5	t	f	6	0	0	2	2	0	2	0	4	5	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	1	0	23	Top 32	Bus Stop	Azorius Control	Two four win bursts kept him alive going back to Pioneer, eventually knocked out of contention by Seth Manfield in R14.
5429	121	5	t	f	6	0	0	2	2	0	2	0	4	5	0	10	5	0	10-5-0	4	4	0	6	1	0	0	0	0	f	3	3	0	24	Top 32	Worldly Counsel	Izzet Phoenix	6-0 in Ltd, but lost five of his first six Pioneer matches. Strong finish couldn't make up the deficit.
5282	35	5	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	6	2	0	4	3	0	0	0	0	f	6	3	1	25	Top 32			From 2-2, advanced to 8-2. Eliminated by Logan Nettles in R13.
6161	502	5	t	f	3	3	0	2	1	1	0	0	7	2	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	4	2	0	26	Top 32	Handshake	Izzet Phoenix	In contention down the stretch, repairing an 0-2 start. Streaks of four and three wins took him to R14, where Logan Nettles ended his chances.
5342	76	5	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	t	5	1	1	27	Top 32		Boros Heroic	Comfortably into D2, and a five win streak brought him into contention. Lost in the penultimate round to Luis Scott-Vargas to end his run.
7171	1019	5	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	3	1	0	28	Top 32		Azorius Control	Strong start at 4-1, but couldn't build from there.
6656	765	5	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	5	2	1	29	Top 32	French	Izzet Phoenix	Costly Draw in R8, and a 1-2 Draft on D2 took him out of contention. Won all five Pioneer rounds to finish strong.
5391	103	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	t	6	4	1	30	Top 32	Sanctum of All		Tremendous 7-1 D1, into disappointing 3-5 D2, with last win coming in R12.
5278	32	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	32	Top 32	Sanctum of All		Won four in a row, and in contention until the end of R14.
5770	305	5	t	f	3	3	0	2	1	1	1	1	7	3	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	f	6	5	1	33	Day 2	Bus Stop		Perfect start, with trophy in Draft, then another three straight in Pioneer. But from 6-0, went 1-6, before winning the last three to requalify.
6796	831	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	3	2	0	34	Day 2	Handshake	Izzet Phoenix	4-1 was the high point, but kept winning enough to keep things interesting until the penultimate round, when Javier Dominguez ended his chances.
5637	228	5	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	2	1	37	Day 2	CFB Ultimate Guard	Rakdos Vampires	1-2 on D1 draft took time to repair, but after 3-0 in Draft D2 he was right in the mix. Losses to Luis Scott-Vargas and Brian Boss ended his hopes.
6879	1119	5	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	38	Day 2		Boros Burn	Won four of his last five, but was already out of contention.
5724	276	5	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	39	Day 2	Sanctum of All		Eliminated at 6-5 after R11, won the last four to requalify.
6679	774	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	2	1	0	40	Day 2	Sanctum of All	Jeskai Creativity	A matching pair of 5-3s, but an overall 6-4 in Pioneer wasn't enough.
5689	257	5	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	7	3	1	41	Day 2	Italy	Amalia Combo	Started 0-2, but then hit seven wins in a row. Three defeats took him out of contention, before he won three of his last four for a rock solid 10-6.
6868	876	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	42	Day 2	Brazilians (Edel)	Rakdos Vampires	A solid 10-6, 5-3 both days, but not in the running after R12.
6030	439	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	43	Day 2	CFB Ultimate Guard	Rakdos Vampires	Used up his losses by R10, won three in a row, before Marco Del Pivo ended his hopes in R14.
5573	200	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	3	2	0	44	Day 2	Worldly Counsel	Izzet Phoenix	Just alive heading into D2 Pioneer, he eliminated Paul Rietzl, Kenta Harane, and Theodore Jung, before Christoffer Larsen took care of business in R15.
7157	1014	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	45	Day 2		Boros Convoke	4-4 again D1, improved to 6-2 D2, including his last three.
6561	709	5	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	46	Day 2		Izzet Phoenix	From 4-4, had a perfect Draft on D2 then two more wins to keep the dream alive, before falling to Stefan Schutz in R14 to end things.
5471	139	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	3	1	47	Day 2		Boros Heroic	Turned 2-2 into 7-2, and still alive into constructed D2, where 2-3 wasn't enough.
6359	603	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	48	Day 2		Enigmatic Fires	5-3 on both days, out of the running after R13.
6740	811	5	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	49	Day 2	Spanish	Boros Convoke	Safely into D2, but out of contention early. Impressively won his last four.
6478	669	5	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	51	Day 2	CFB Ultimate Guard	Dimir Control	A surprising 1-3, but still made D2 after four straight wins. Matched his 5-3 record from D1 on D2, but that wasn't enough.
6538	697	5	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	52	Day 2	Sewer Rats	Quintorius Combo	Struggling at 2-4, still made D2. Out of contention before the return to Pioneer, but rattled off four wins to close out D2.
5480	145	5	t	f	5	1	0	2	2	0	1	0	4	5	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	6	5	1	53	Day 2			So nearly so good. 2-1 in Draft, 6-1-1 overnight, trophy on the second morning, pacing the field at 9-1-1. Then five Pioneer losses, so not even requalification. Wow.
5493	156	5	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	3	2	0	54	Day 2			Decent 6-3-1 in Pioneer, the 3-3 in Draft kept him short of the mark.
5450	130	5	t	f	2	4	0	2	0	2	0	0	7	2	1	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	3	2	0	55	Day 2			5-2-1 overnight, and an excellent 7-2-1 overall in Pioneer. 2-4 in Draft just not good enough.
6967	920	5	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	4	2	0	56	Day 2	Worldly Counsel	Izzet Phoenix	A middling D1, soon out of the running on D2, but had a decent four round streak in Pioneer.
6909	895	5	t	f	4	1	1	2	2	0	0	0	5	5	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	2	3	0	57	Day 2			Opening Pioneer 0-3 was the key to ending up short of requlaification.
6533	696	5	t	f	3	2	1	2	1	0	0	0	6	4	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	2	2	0	58	Day 2	Scoreboard	Lotus Field Combo	Above average on both days, but not by much, and soon out of contention.
7220	1042	5	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	59	Day 2	Hatchel Poulosky Zilles	Izzet Phoenix	Strong start at 4-1, and won his D2 Draft pod to sit at 8-3 heading back to Pioneer. Only one win from there saw him fade.
5869	355	5	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	4	0	60	Day 2			Perfect in Draft both days for the double trophy, so obviously less exciting in Pioneer, 3-7 less exciting to be precise.
6142	495	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	61	Day 2	Sewer Rats	Rakdos Midrange	5-0 fell to 5-3 overnight, and out of the running before the return to Pioneer.
5758	295	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	62	Day 2	Spain		Five straight wins on D1 led to 6-2 overnight, but 3-5 on D2.
5929	387	5	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	63	Day 2			Four wins, three wins, two wins - they came in multiples, but still added up to nine, not ten.
5705	265	5	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	6	3	1	64	Day 2	Misfits	Izzet Ensoul	In trouble at 3-4, then six on the bounce, before Javier Dominguez ended his run.
6889	882	5	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	3	0	65	Day 2	Handshake	Izzet Phoenix	Another streak took him from 2-2 to 6-2 overnight, but then the hard work was undone with an 0-3 Draft D2.
6548	701	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	2	0	66	Day 2		Azorius Control	2-2 became 6-2, but a 1-2 D2 Draft was costly. Things petered out, going 2-3 in Pioneer.
5999	423	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	7	3	1	67	Day 2		Abzan Greasefang	1-3 meant afterburners required. Seven wins followed, but, once back in Pioneer, Sean Goddard and Javier Dominguez gave him too much to do.
5258	21	2	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	2	0	18	Top 32			Four in a row, three in a row, two in a row, and still not quite enough. Still plenty to requalify, though.
5257	20	2	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	139	Day 2			Won R7 and R8 to advance, then 3-5 D2.
5261	22	2	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	249	X	Japan 2		0-5 drop, with two game wins.
5259	21	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	185	X	Arthur. Dutcher		3-3 into 3-5 to miss D2.
5852	349	5	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	4	1	68	Day 2	Moriyama Japan	Lotus Field Combo	Opened 5-0, so 5-3 D1 was a disappointment. Still alive heading back to Pioneer, but Marco Del Pivo in R12 ended his T8 interest.
6973	921	5	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	69	Day 2	Sunnydaze		Solid 4-2 in Draft, 2-1 both days, but only even 5-5 in Pioneer.
5565	197	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	70	Day 2			Five straight wins on D1, but 7-3 became 7-6, and lost the qualification match in R16.
6090	468	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	71	Day 2	Worldly Counsel	Izzet Phoenix	Won D1 Draft pod, 6-2 overnight, again found D2 more challenging, going 3-5.
6285	567	5	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	72	Day 2	Misfits	Izzet Creativity	3-0 opening Draft, a solid 5-3 D1 overall, but lost three of his last four on D2 to fade.
6589	723	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	73	Day 2	Martin Orellana Perals Vigo	Amalia Combo	4-4 overnight, and soon out of contention. Won his last three to have a winning record.
7144	1010	5	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	74	Day 2	Sanctum of All	Azorius Control	4-2, but already out of the running at 4-5, before an encouraging five wins out of the last seven.
5767	303	5	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	75	Day 2			3-1 the best spot, eliminated before the return to Pioneer.
5777	308	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	6	3	1	76	Day 2	Sewer Rats		Got into gear from 2-4, turning it into 8-4 before elimination from contention in R13.
6203	516	5	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	78	Day 2	Handshake	Izzet Phoenix	Could never quite get things going. 4-2 to 4-4, and out of contention at 6-5.
5478	144	5	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	2	1	79	Day 2			Won three straigh on D1, and five straight on D2, but couldn't stack up more wins.
5731	280	5	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	80	Day 2	Sanctum of All		Won R7 and R8 to advance, then a solid 5-3 on D2.
6977	923	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	2	1	81	Day 2	Scoreboard		In a hole at 2-4, won five straight to still be alive heading back to Pioneer at 7-4, eliminated by Brian Boss in R12.
5617	218	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	82	Day 2		Niv to Light	Solid 5-3 D1, but couldn't make a run on D2.
5876	358	5	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	83	Day 2		Azorius Control	From 1-2 in Draft to 5-3 overnight. Draft the achilles heel once more, so out of contention heading back to Pioneer.
5553	189	5	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	84	Day 2	CFB Ultimate Guard	Rakdos Vampires	Needed a R8 win to secure his D2 berth, and then kept his hopes alive with a 3-0 in Draft. Toru Inoue ended his chances in R12.
6343	597	5	t	f	1	4	0	2	0	2	0	0	7	3	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	2	0	86	Day 2	Wu Hayne		Already out after R9, soldiered on to a positive record.
6583	720	5	t	f	2	3	0	2	0	1	0	0	6	4	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	4	0	87	Day 2	Guillotine		Credit for making D2 after a 1-4 start. Quickly out of contention on D2.
5972	406	5	t	f	5	1	0	2	2	0	1	0	3	5	2	8	6	2	8-6-2	5	2	1	3	4	1	0	0	0	f	3	3	0	88	Day 2	Moriyama Japan	Azorius Control	3-0 Draft to start into 6-1-1 D1, but only a single Pioneer win D2.
7111	993	5	t	f	3	3	0	2	1	1	0	0	5	3	2	8	6	2	8-6-2	6	1	1	2	5	1	0	0	0	f	3	2	0	90	Day 2	Sanctum of All		Terrific 6-1-1 on D1 melted into nothing with a 2-5-1 D2.
7086	1502	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	85	Day 2	Sanctum of All	Amalia Combo	At a perilous 1-4, did well to reach D2. Won four straight early on D2, so a creditable 9-7 after that start.
7381	21	10	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	157	Day 2		Mono-Red Aggro	
5262	23	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	284	x		Domain Overlords	
5264	25	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	106	Day 2		Mono-Green Devotion	Never more than two straight wins in an 8-8 finish.
5275	29	9	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	213	Day 2		Dimir Midrange	
7555	31	10	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	331	x	CFB Ultimate Guard	Izzet Prowess	
5281	34	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	94	Day 2		Gruul Mice	
5290	40	9	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	49	Day 2		Esper Pixie	
5291	41	9	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	4	3	0	30	Top 32		Temur Otters	
7509	41	10	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	285	x		Azorius Omniscience	
5292	42	7	t	f	4	1	1	2	2	0	0	0	2	6	0	6	7	1	6-7-1	4	3	1	2	4	0	0	0	0	f	2	3	0	130	Day 2			
5294	44	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	177	X			
5299	45	7	f	f	1	2	0	1	0	1	0	0	0	3	1	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	3	0	223	X	Sanctum of All	Ruby Storm	R1 win became the only positive result of a torrid D1.
7470	45	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	246	x	Cosmos Heavy Play	Izzet Cauldron	
5302	48	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	24	Top 32	Italian Team	Domain Overlords	
7297	48	10	t	f	2	3	0	2	1	1	0	0	6	3	1	8	6	1	8-6-1	5	3	0	3	3	1	0	0	0	f	3	2	0	73	Day 2	Italian Team	Azorius Omniscience	
5304	50	1	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	52	Day 2	Belfatto Kurz Parson Wienburg		Outstanding 6-0 in Draft,but the math means a pretty horrible 3-7 in Pioneer, including 1-4 down the stretch.
5313	57	1	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	100	Day 2	Bergelin Eriksson Skorupa Tatian		Had to win twice to reach D2, then repeated a 1-2 Draft. Won his last two to reach parity.
5319	61	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	177	X			Turned 1-4 into 3-4, but Mitchell Tamblyn eliminated him in R8.
5328	67	2	t	f	3	3	0	2	1	1	1	1	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	3	1	38	Day 2			Solid 7-3 in Standard, but only 3-3 in Draft, which was a horror 0-3 D1, and a trophy on D2.
5248	15	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	235	x	Sanctum of All	Esper Paragon	
5307	51	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	265	x	Nerd Rage Gaming	Mono-Red Aggro	
5310	54	9	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	195	Day 2		Gruul Mice	
5311	55	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	58	Day 2		Azorius Omniscience	
7395	55	10	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	171	Day 2	Scryhard	Simic Terror	
7363	57	10	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	139	Day 2	Scryhard	Azorius Omniscience	
5322	62	9	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	220	x	Italian Team	Azorius Control	
7415	62	10	t	f	2	4	0	2	1	1	0	0	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	1	3	0	191	Day 2	Italian Team	Azorius Control	
5323	63	7	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	123	Day 2			
5324	63	9	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	328	x	Nerd Rage Gaming	Boros Convoke	
5326	65	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	231	x		Gruul Leyline	
5327	66	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	252	x	Italian Team	Domain Overlords	
5330	68	7	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	211	X			
5336	72	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	207	X	Sunnydaze		Won R1 2-0, easy game? Lost R2-6. No.
5232	8	9	t	f	1	5	0	2	0	2	0	1	5	4	1	6	9	1	6-9-1	4	3	1	2	6	0	0	0	0	f	2	5	0	203	Day 2		Gruul Exhaust	
5233	9	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	329	x	Sanctum of All	Gruul Mice	
5235	10	9	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	3	0	43	Day 2	Team Bus Stop	Domain Overlords	
5239	13	7	t	f	1	3	1	2	0	1	0	0	5	5	0	6	8	1	6-8-1	3	3	1	3	5	0	0	0	0	f	3	5	0	114	Day 2	Temple of Malady		
5240	14	2	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	19	Top 32	Sewer Rats	Rakdos Reanimator	Three wins to end D1, and four straight from 7-5 for an excellent 11-5 record.
5334	71	2	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	4	2	0	21	Top 32	Blesso Bogue Pyka		A strange split. From a solid 4-2 to an even 4-4, then a brilliant D2 of 7-1, including a tremendous Draft trophy against opponents Eliott Boussaud, Jakub toth, and Greg Orange.
5338	73	2	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	34	Day 2	Sewer Rats		Five win streak early took him to 5-1, and still live at 9-4 before YiwenChen eliminated him in R14.
5337	72	2	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	106	Day 2	Blesso Bogue Pyka		Even all the way - 3-3 in Draft, 5-5 in Standard, 4-4 D1, 4-4 D2.
5234	10	3	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	4	2	0	16	Top 16			Excellent 8-2 in Modern, but 3-3 in Draft meant not quite enough for T8.
5228	8	3	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	f	6	1	1	28	Top 32		Temur Rhinos	From 1-2, knocked out six straight to be in the thick of the T8 race. A draw against Alexander Hayne in R13, coupled with R14 defeat to Greg Orange, ended his run.
5333	70	3	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	83	Day 2	Worldly Counsel		Solid 7-3 in Modern, couldn't overcome a poor 2-4 in Draft, 1-2 both days.
5339	73	3	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	5	4	1	102	Day 2	Sewer Rats		Trophy D1 draft, got to 5-0, but only two wins after that.
5237	12	3	t	f	3	3	0	2	1	1	0	0	3	4	0	6	7	0	6-7-0	4	4	0	2	3	0	0	0	0	f	3	2	0	163	Day 2			Credit for reaching D2 after an 0-2 start.
5270	26	3	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	242	X			Couldn't come back from 0-4.
5238	12	4	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	1	3	0	81	X			2-1 became 2-4.
7406	72	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	182	Day 2	Sanctum of All	Izzet Prowess	
5340	74	9	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	289	x		Gruul Mice	
5376	95	9	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	6	0	210	Day 2		Esper Pixie	
5346	76	9	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	315	x		Gruul Leyline	
5348	77	9	f	f	1	2	0	1	0	1	0	0	1	1	2	2	3	2	2-3-2	2	4	1	0	0	0	0	0	0	f	2	2	0	288	x	Sanctum of All	Azorius Control	
7378	78	10	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	154	Day 2		Izzet Prowess	
5354	80	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	272	x	Sanctum of All	Esper Pixie	
5358	82	9	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	6	1	1	19	Top 32	SystemMagic	Gruul Mice	
7237	82	10	t	f	5	1	0	2	2	0	1	0	6	3	0	11	4	0	11-4-0	5	3	0	6	1	0	0	0	0	t	6	2	1	13	Top 16	Flexslot Diamond	Izzet Prowess	
5359	83	9	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	4	0	333	x		Esper Pixie	
5362	86	9	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	2	0	40	Day 2	Sanctum of All	Esper Paragon	
7488	86	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	264	x	Sanctum of All	Izzet Prowess	
5373	94	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	236	X	CFB Ultimate Guard		
5374	94	8	t	t	5	1	0	2	2	0	1	0	5	4	0	10	5	0	10-5-0	4	3	0	6	1	0	0	1	0	t	5	1	1	8	Top 8	CFB Ultimate Guard		
5375	95	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	168	X			
5379	98	9	t	f	3	3	0	2	1	1	0	0	2	6	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	3	4	0	217	Day 2	Cosmos Heavy Play	Gruul Mice	
5380	99	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	89	Day 2		Esper Pixie	
5388	101	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	190	Day 2	Nerd Rage Gaming	Esper Pixie	
7326	103	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	102	Day 2	Sanctum of All	Mono-Red Aggro	
5395	106	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	190	X			
5402	107	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	246	x	Worldly Counsel Heavy Play	Azorius Oculus	
7314	116	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	90	Day 2		Azorius Omniscience	
5420	117	9	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	345	x		Esper Pixie	
5424	120	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	264	x	Worldly Counsel Heavy Play	Golgari Roots	
5433	121	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	3	0	61	Day 2	Cosmos Heavy Play	Golgari Midrange	
7370	121	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	146	Day 2	Cosmos Heavy Play	Izzet Prowess	
5435	123	9	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	197	Day 2		Esper Pixie	
7480	123	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	256	x		Esper Pixie	
7523	76	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	299	x		Izzet Prowess	
5465	138	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	201	X	Chen Huang		Eliminated in R7.
5446	128	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	188	X			
5451	130	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	230	X			
5454	133	7	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	228	X	Temple of Malady		
5456	134	8	f	f	1	1	0	1	0	0	0	0	1	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	1	2	0	64	X			
5457	135	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	62	Day 2		Domain Overlords	
7495	135	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	271	x		Azorius Omniscience	
5458	136	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	270	x	Seedcore	Esper Pixie	
7483	137	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	259	x	MTG Sheep	Azorius Omniscience	
5464	137	9	t	f	1	4	0	2	0	2	0	0	6	4	0	7	8	0	7-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	170	Day 2		Gruul Mice	
5466	138	9	t	f	4	2	0	2	1	1	1	0	4	5	1	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	3	2	0	122	Day 2		Boros Goblins	
5472	140	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	1	2	0	192	Day 2	Sanctum of All	Esper Paragon	
5476	142	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	257	x		Domain Overlords	
7275	142	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	4	0	0	0	0	f	4	2	0	51	Day 2		Izzet Prowess	
5477	143	9	t	f	3	3	0	2	1	1	0	0	5	4	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	4	2	0	129	Day 2		Esper Pixie	
5481	145	9	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	150	Day 2		Esper Pixie	
5482	146	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	161	X			
5483	147	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	250	x	Team Bus Stop	Gruul Mice	
5487	151	7	t	f	3	2	1	2	1	1	0	0	5	5	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	2	2	0	87	Day 2	Milkshake		
5489	153	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	159	X			
5492	155	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	334	x	Rampant Growth Heavy Play	Gruul Mice	
5494	157	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	232	X			
5499	162	8	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	4	3	0	18	Top 32	Sanctum of All		
5500	162	9	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	3	1	27	Top 32	Sanctum of All	Mono-Red Aggro	
7335	162	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	111	Day 2	Sanctum of All	Izzet Prowess	
5503	165	9	t	f	2	4	0	2	1	1	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	5	1	114	Day 2		Domain Overlords	
7413	165	10	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	6	0	189	Day 2	Team Pluto	Azorius Omniscience	
5505	167	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	187	X			
5508	169	7	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	192	X			
5511	171	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	t	7	3	1	39	Day 2	Rampant Growth Heavy Play	Esper Pixie	
7336	171	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	112	Day 2	Rampant Growth Heavy Play	Dimir Midrange	
5502	164	1	t	f	3	3	0	2	1	1	0	0	3	6	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	4	0	123	Day 2			Highlight the 2-1 in Draft on Saturday. Lowlight the last four round defeats on Saturday.
5479	145	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	147	X			Drafted 2-1, needed a R8 win to advance, lost to Jacob Hauch.
5501	163	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	171	X			Three in a row took him to 3-1, but then no more wins.
5518	174	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	240	x	Team Bus Stop	Domain Overlords	
5521	176	7	t	f	3	2	1	2	1	0	0	0	3	7	0	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	2	4	0	131	Day 2	Tenacious Underdogs		
5530	181	7	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	96	Day 2			
5532	182	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	54	Day 2	Nerd Rage Gaming	Mono-Red Aggro	
7497	182	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	273	x	CFB Ultimate Guard	Izzet Prowess	
5533	183	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	178	X	Sanctum of All		
5535	184	9	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	2	5	0	295	x		Dimir Midrange	
5538	186	9	t	f	5	0	1	2	2	0	1	0	3	7	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	4	4	0	124	Day 2		Esper Pixie	
5548	188	9	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	102	Day 2	Worldly Counsel Heavy Play	Domain Overlords	
7242	188	10	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	6	1	1	18	Top 32	Worldly Counsel Heavy Play	Azorius Omniscience	
5563	1445	9	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	193	Day 2		Esper Pixie	
7514	1445	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	290	x	Team Serious Players Only	Azorius Omniscience	
5566	198	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	67	Day 2		Domain Overlords	
7400	198	10	t	f	4	2	0	2	2	0	0	0	3	5	0	7	7	0	7-7-0	4	4	0	3	5	0	0	0	0	f	3	3	0	176	Day 2		Orzhov Pixie	
5577	200	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	68	Day 2	Cosmos Heavy Play	Azorius Omniscience	
5580	202	2	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	4	4	0	5	2	1	0	0	0	f	4	4	0	57	Day 2	French	Grixis Midrange	Four straight D1 defeats meant he needed two wins just to scrape into D2. Four Standard wins at the back end wasn't enough to contend.
5599	212	1	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	2	0	50	Day 2	Italians		A pair of solid 2-1s in Draft, but just even at 5-5 in Pioneer, which was disappointing having started out 4-0 in the constructed format.
5602	214	1	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	3	2	0	83	Day 2	Portugese		3-0 in Draft to open, but 1-2 the next morning left him too much to do. A 6-2, 2-6 reverse.
5527	178	9	t	f	2	4	0	2	1	1	0	1	6	3	1	8	7	1	8-7-1	6	2	0	2	5	1	0	0	0	f	4	3	0	123	Day 2	Italian Team	Domain Overlords	
5587	202	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	92	Day 2		Gruul Leyline	
5588	203	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	143	Day 2		Esper Pixie	
7339	203	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	115	Day 2	Team Serious Players Only	Azorius Omniscience	
5589	204	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	168	Day 2		Gruul Leyline	
5593	207	9	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	326	x		Golgari Midrange	
7491	208	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	267	x	Italian Team	Mono-Red Aggro	
5594	208	9	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	1	1	72	Day 2		Gruul Mice	
5595	209	7	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	235	X	Rampant Growth Heavy Play		
5598	211	7	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	205	X			
5603	215	9	t	t	4	2	0	2	2	0	0	0	10	2	0	14	4	0	14-4-0	6	2	0	6	1	0	2	1	0	t	6	2	1	2	Finalist		Domain Overlords	
7325	215	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	101	Day 2		Izzet Prowess	
5633	228	1	t	t	5	1	0	2	2	0	1	0	11	2	0	16	3	0	16-3-0	6	2	0	7	1	0	3	0	0	t	7	1	1	1	Champion	Channel Fireball	Izzet Creativity	3-0 D1 Draft got the ball rolling before a first defeat to eventual Finalist Benton Madsen. 8-3 heading back to Pioneer, four straight wins, including a mirror against Gabriel Nassif, secured his T8 slot. Nathan Steuer and Derrick Davis fell, before he completed the assignment by sweeping aside Benton Madsen when it mattered most.
5614	217	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	163	Day 2	Cosmos Heavy Play	Golgari Obliterator	
5621	218	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	282	x	Team Pluto	Domain Overlords	
5624	221	9	t	f	3	3	0	2	1	1	0	0	5	4	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	2	0	128	Day 2	Worldly Counsel Heavy Play	Domain Overlords	
7241	221	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	1	0	17	Top 32	Worldly Counsel Heavy Play	Azorius Omniscience	
5625	222	9	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	212	Day 2		Bant Cage	
5626	223	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	230	x		Gruul Mice	
5627	224	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	280	x	Sanctum of All	Gruul Mice	
5628	225	9	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	79	Day 2		Esper Pixie	
5630	226	8	t	f	4	2	0	2	1	1	1	0	6	2	0	10	4	0	10-4-0	6	1	0	4	3	0	0	0	0	t	4	2	0	9	Top 16	Rampant Growth Heavy Play		
5631	226	9	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	1	0	0	1	0	t	5	2	1	7	Top 8	Rampant Growth Heavy Play	Gruul Leyline	
7371	226	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	147	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
5558	190	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	227	X			
5651	238	1	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	62	Day 2		Gruul Vehicles	After 4-1 became a disappointing 4-4, a Draft pod win to start D2 put him in contention. Two wins from five in Pioneer D2 didn't get it done.
5641	228	9	t	f	3	3	0	2	1	1	0	0	8	1	1	11	4	1	11-4-1	6	1	1	5	3	0	0	0	0	f	3	2	0	13	Top 16	CFB Ultimate Guard	Domain Overlords	
5643	230	9	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	223	x		Esper Pixie	
5645	232	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	140	Day 2	Seedcore	Jeskai Monument	
5655	238	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	170	X	Worldly Counsel	Rakdos Midrange	3-1 was a strong start. Four defeats turned it around in a hurry.
5659	238	9	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	146	Day 2	Cosmos Heavy Play	Azorius Omniscience	
7407	238	10	t	f	1	5	0	2	0	2	0	1	5	4	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	6	0	183	Day 2	Cosmos Heavy Play	Azorius Omniscience	
5663	239	8	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	78	X	Rampant Growth Heavy Play	Gruul Prowess	3-1 in Standard came too late after a horror 0-3 Draft.
5664	239	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	52	Day 2	Rampant Growth Heavy Play	Gruul Mice	
7352	200	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	128	Day 2	Cosmos Heavy Play	Azorius Omniscience	
5606	217	1	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	2	1	19	Top 32	Handshake	Rakdos Midrange	A slow 0-2 start rescued to 5-3 overnight, then into contention, winning his D2 Draft pod.Losses to Reid Duke and Daniel Goetschel meant he finished one round shy of T8.
5688	256	3	f	f	1	1	0	1	0	0	0	0	1	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	188	X			Eliminated in R7.
7294	239	10	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	70	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
5667	240	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	74	X	Sanctum of All		
5668	240	9	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	10	3	1	21	Top 32	Sanctum of All	Esper Pixie	
7517	240	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	293	x	Sanctum of All	Izzet Prowess	
5670	242	7	t	f	2	4	0	2	1	1	0	1	3	4	1	5	8	1	5-8-1	4	3	1	1	5	0	0	0	0	f	2	4	0	140	Day 2			
5672	244	7	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	94	Day 2	Temple of Malady		
5673	245	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	273	x		Jeskai Oculus	
5675	247	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	249	x	0	Gruul Mice	
5685	255	7	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	4	6	0	132	Day 2			
5686	255	8	t	f	3	3	0	2	1	1	0	0	5	2	0	8	5	0	8-5-0	6	1	0	2	4	0	0	0	0	f	7	4	1	21	Top 32			
5687	255	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	298	x	Italian Team	Dimir Midrange	
5693	257	9	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	3	3	0	37	Day 2	Italian Team	Esper Pixie	
7493	257	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	269	x	Italian Team	Azorius Omniscience	
5695	258	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	154	Day 2	Seedcore	Esper Pixie	
5696	259	7	t	f	2	4	0	2	0	2	0	0	5	3	0	7	7	0	7-7-0	4	4	0	3	3	0	0	0	0	f	2	1	0	120	Day 2			
5697	260	7	t	f	4	1	1	2	1	0	1	0	4	6	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	2	0	84	Day 2	Sanctum of All		
7255	217	10	t	f	2	4	0	2	0	2	0	0	9	1	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	3	1	31	Top 32	Cosmos Heavy Play	Azorius Omniscience	
5702	265	1	t	t	5	1	0	2	2	0	1	0	7	4	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	5	2	1	7	Top 8		Lotus Field Combo	3-0 Draft to start, 7-1 overnight, needed three straight wins to reach T8, got there. Lost to Takumi Matsuura in the QFs.
5698	261	9	t	t	6	0	0	2	2	0	2	0	6	3	0	12	3	0	12-3-0	6	2	0	6	2	0	0	1	0	t	6	1	1	5	Top 8	Nerd Rage Gaming	Golgari Graveyard	
7344	261	10	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	3	2	0	120	Day 2	Handshake Moxfield	Jeskai Control	
7404	262	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	180	Day 2	Team Pluto	Izzet Prowess	
5712	268	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	4	4	0	0	0	0	f	2	2	0	101	Day 2		Gruul Mice	
5714	269	7	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	240	X			
5715	269	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	65	X	Argentina+Spain		
7273	269	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	49	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
5717	271	7	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	207	X	CFB Ultimate Guard		
5718	271	9	t	f	4	2	0	2	2	0	0	0	3	3	0	7	5	0	7-5-0	5	3	0	2	4	0	0	0	0	f	4	3	0	184	Day 2	CFB Ultimate Guard	Jeskai Oculus	
5719	272	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	258	x		Esper Pixie	
7340	272	10	t	f	3	2	0	2	1	1	0	0	5	5	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	4	2	0	116	Day 2	Scryhard	Mono-Red Aggro	
5721	274	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	69	Day 2		Gruul Mice	
7429	274	10	t	f	2	2	1	2	1	0	0	0	2	3	0	4	5	1	4-5-1	4	3	1	0	2	0	0	0	0	f	2	3	0	205	Day 2		Mono-Red Aggro	
5722	275	9	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	178	Day 2		Mono-Red Aggro	
5725	276	7	f	f	1	2	0	1	0	1	0	0	1	2	1	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	2	0	193	X	Sanctum of All		
5729	279	7	f	f	1	2	0	1	0	1	0	0	1	2	1	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	2	0	198	X			
5730	279	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	296	x		Gruul Mice	
7250	228	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	2	0	26	Top 32	CFB Ultimate Guard	Domain Overlords	
5743	287	1	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	68	Day 2			Excellent 7-3 in Pioneer, handicapped by negative 1-2 record in both Drafts.
5732	280	9	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	278	x	SystemMagic	Gruul Mice	
5733	281	7	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	4	0	86	Day 2	French		
5738	282	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	156	Day 2	Handshake Moxfield	Azorius Control	
7317	282	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	93	Day 2	Handshake Moxfield	Golgari Roots	
5739	283	9	t	f	3	2	1	2	1	1	1	0	4	6	0	7	8	1	7-8-1	5	3	0	2	5	1	0	0	0	f	4	2	0	172	Day 2		Selesnya Cage	
7299	283	10	t	f	1	4	1	2	0	2	0	1	8	2	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	5	3	1	75	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
5740	284	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	320	x		Bant Gearhulk	
5742	286	9	t	f	3	2	1	2	1	1	1	0	3	7	0	6	9	1	6-9-1	5	3	0	1	6	1	0	0	0	f	4	4	0	202	Day 2		Mono-White Caretaker	
5745	288	9	t	f	2	3	1	2	0	1	0	0	5	5	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	2	2	0	173	Day 2	Seedcore	Esper Pixie	
5752	291	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	3	0	71	Day 2	Seedcore	Esper Pixie	
7232	291	10	t	t	5	1	0	2	2	0	1	0	7	4	0	12	5	0	12-5-0	6	2	0	6	2	0	0	1	0	t	4	2	0	8	Top 8		Mono-Red Aggro	
5757	294	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	180	Day 2	Sanctum of All	Esper Paragon	
5759	296	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	263	x		Jeskai Oculus	
5762	299	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	271	x	Team Pluto	Golgari Midrange	
5763	300	9	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	145	Day 2		Gruul Mice	
5766	302	7	f	f	2	1	0	1	1	0	0	0	0	2	3	2	3	3	2-3-3	3	5	0	\N	\N	3	0	0	0	f	1	1	0	179	X	Italians		
5768	303	8	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	103	X	Bus Stop + Sewer Rats		
5772	305	9	t	f	6	0	0	2	2	0	2	0	4	6	0	10	6	0	10-6-0	7	1	0	3	5	0	0	0	0	t	7	5	1	45	Day 2	Team Bus Stop	Gruul Mice	
7389	305	10	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	5	0	165	Day 2	Scryhard	Izzet Prowess	
5773	306	7	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	3	1	106	Day 2	Tenacious Underdogs		
5787	310	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	7	2	1	56	Day 2	Cosmos Heavy Play	Azorius Omniscience	
5788	311	9	t	f	3	3	0	2	1	1	0	0	3	5	2	6	8	2	6-8-2	5	1	2	1	7	0	0	0	0	f	2	5	0	201	Day 2		Domain Overlords	
5797	312	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	286	x	Rampant Growth Heavy Play	Gruul Mice	
7365	312	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	141	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
5798	313	9	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	2	5	0	294	x		Orzhov Control	
5799	314	9	t	f	2	4	0	2	1	1	0	1	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	6	0	211	Day 2	Seedcore	Esper Pixie	
5801	316	9	t	f	2	3	1	2	0	1	0	0	3	6	0	5	9	1	5-9-1	4	4	0	1	5	1	0	0	0	f	2	5	0	216	Day 2		Dimir Midrange	
5802	317	9	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	4	5	0	135	Day 2		Dimir Enchantments	
5805	318	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	277	x		Azorius Oculus	
5806	320	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	316	x		Izzet Artifacts	
7432	320	10	t	f	2	4	0	2	1	1	0	1	2	4	0	4	8	0	4-8-0	4	4	0	0	4	0	0	0	0	f	2	4	0	208	Day 2		Dimir Midrange	
5811	323	9	t	f	2	4	0	2	0	2	0	0	3	7	0	5	11	0	5-11-0	4	4	0	1	7	0	0	0	0	f	3	6	0	219	Day 2		Jund Exhaust	
5814	326	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	312	x		Esper Pixie	
5815	327	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	173	X	Temple of Malady		
5816	328	9	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	3	0	307	x	Sanctum of All	Mono-Red Aggro	
7546	328	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	322	x	Sanctum of All	Izzet Prowess	
5818	329	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	53	Day 2	SystemMagic	Gruul Mice	
7331	329	10	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	107	Day 2	Sanctum of All	Izzet Prowess	
5819	330	9	f	f	1	2	0	2	0	1	0	0	1	3	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	3	0	308	x		Esper Pixie	
5820	331	5	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	50	Day 2			
5822	332	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	65	Day 2		Esper Pixie	
7292	332	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	3	0	68	Day 2	Scryhard	Mono-Red Aggro	
5823	333	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	184	X			
7550	334	10	f	f	0	2	1	1	0	1	0	0	0	2	0	0	4	1	0-4-1	0	4	1	0	0	0	0	0	0	f	0	4	0	326	x	Italian Team	Izzet Prowess	
5835	341	9	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	99	Day 2	Handshake Moxfield	Jeskai Convoke	
7477	341	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	253	x	Handshake Moxfield	Izzet Prowess	
5837	342	7	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	139	Day 2			
5838	343	9	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	325	x	Seedcore	Gruul Mice	
5840	345	9	t	f	2	4	0	2	0	2	0	0	4	4	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	2	3	0	206	Day 2		Abzan Roots	
5845	346	9	t	f	2	4	0	2	0	2	0	0	7	2	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	4	1	0	77	Day 2	Handshake Moxfield	Azorius Control	
7437	346	10	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	213	x	Handshake Moxfield	Jeskai Control	
5846	347	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	279	x		Gruul Mice	
5856	349	9	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	1	0	0	1	0	t	6	2	1	6	Top 8	Moriyama Japan	Jeskai Oculus	
7532	349	10	f	f	0	2	1	1	0	1	0	0	1	2	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	2	0	308	x	Moriyama Japan	Dimir Midrange	
5850	349	2	t	f	1	5	0	2	0	2	0	1	9	1	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	46	Day 2	Moriyama Japan	Grixis Reanimator	Two starkly different formats. 1-5 in Draft, and a brilliant 9-1 in Standard. Rarely can pride and despair have balanced so perfectly.
7471	351	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	247	x	CFB Ultimate Guard	Izzet Prowess	
5865	352	9	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	5	0	188	Day 2		Jeskai Convoke	
5872	357	9	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	139	Day 2		Esper Pixie	
5881	359	7	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	233	X	Temple of Malady		
5883	361	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	158	X	Tenacious Underdogs		
5884	362	1	t	f	5	0	1	2	2	0	1	0	6	4	0	11	4	1	11-4-1	6	2	0	5	2	1	0	0	0	t	3	1	0	10	Top 16	SEA RC Top 8	Mono-White Humans	In the mix to the very end thanks to three separate three win bursts. 5-0-1 in Draft and solid in Pioneer left him just short of T8.
5890	363	8	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	3	3	0	33	Day 2			
5892	364	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	115	Day 2	Handshake Moxfield	Gruul Mice	
7468	364	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	244	x	Handshake Moxfield	Golgari Roots	
5894	365	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	23	Top 32		Domain Overlords	
7234	365	10	t	f	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	6	2	0	6	2	0	0	0	0	t	7	2	1	10	Top 16	Scryhard	Azorius Omniscience	
5895	366	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	107	Day 2		Azorius Oculus	
5897	368	9	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	3	0	121	Day 2	Seedcore	Esper Pixie	
5898	369	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	234	x		Golgari Midrange	
5899	370	9	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	346	x	Seedcore	Esper Pixie	
5904	371	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	105	Day 2	Team Bus Stop	Gruul Mice	
5905	372	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	293	x		Azorius Omniscience	
5906	373	9	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	112	Day 2		Jeskai Oculus	
5908	374	7	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	3	0	116	Day 2	Moriyama Japan		
5909	374	8	t	f	4	2	0	2	2	0	0	0	4	3	0	8	5	0	8-5-0	5	2	0	3	3	0	0	0	0	t	4	2	0	22	Top 32	Moriyama Japan		
5910	374	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	317	x	Moriyama Japan	Jeskai Oculus	
5913	377	7	t	f	2	3	1	2	0	1	0	0	5	5	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	2	3	0	112	Day 2	Scoreboard		
5914	377	8	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	98	X	Rampant Growth Heavy Play		
5915	378	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	269	x		Gruul Mice	
5916	379	9	f	f	1	1	0	1	0	0	0	0	0	0	0	1	1	0	1-1-0	1	1	0	0	0	0	0	0	0	f	1	1	0	322	x	Team Pluto	Selesnya Cage	
7348	379	10	t	f	5	1	0	2	2	0	1	0	3	6	0	8	7	0	8-7-0	5	3	0	3	4	0	0	0	0	f	4	4	0	124	Day 2		Naya Yuna	
5917	380	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	179	Day 2	Rampant Growth Heavy Play	Gruul Mice	
5927	385	8	f	f	2	1	0	1	1	0	0	0	1	2	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	2	1	0	59	X			
5934	390	7	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	208	X	Tenacious Underdogs		
5935	390	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	144	Day 2		Selesnya Cage	
5937	392	9	f	f	0	2	1	1	0	1	0	0	0	2	0	0	4	1	0-4-1	0	4	1	0	0	0	0	0	0	f	0	4	0	340	x		Dimir Enchantments	
5938	393	9	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	338	x		Abzan Ketramose	
5944	394	8	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	5	0	90	X	CFB Ultimate Guard	Dimir Midrange	One win in each format nowhere near enough for D2.
5945	394	9	t	f	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	5	2	1	12	Top 16	Handshake Moxfield	Azorius Control	
7265	394	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	2	0	41	Day 2	Handshake Moxfield	Jeskai Control	
5956	400	7	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	212	X			
5961	401	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	57	Day 2	Moriyama Japan	Jeskai Oculus	
7543	401	10	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	6	0	319	x	Moriyama Japan	Boros Aggro	
5966	403	4	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	74	X	Handshake	Azorius Soldiers	Out after just five rounds.
5967	403	5	f	f	0	2	1	1	0	0	0	0	1	4	0	1	6	1	1-6-1	1	6	1	0	0	0	0	0	0	f	1	2	0	237	X	Handshake	Boros Heroic	Just a single match win in a horrible D1.
7254	403	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	5	2	1	30	Top 32	Handshake Moxfield	Azorius Omniscience	
5969	404	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	274	x		Azorius Omniscience	
5970	405	9	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	348	x		Dimir Bounce	
5975	406	8	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	4	0	0	1	0	0	0	0	f	0	5	0	113	X	Moriyama Japan	Gruul Prowess	A disastrous 0-5 to end the season.
5976	406	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	109	Day 2	Moriyama Japan	Jeskai Oculus	
7239	406	10	t	f	3	2	1	2	1	1	0	0	8	2	0	11	4	1	11-4-1	4	4	0	7	0	1	0	0	0	f	7	3	1	15	Top 16	Moriyama Japan	Mono-Red Aggro	
5980	410	9	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	4	0	302	x		Gruul Delirium	
5986	414	7	f	f	1	1	1	1	0	0	0	0	1	3	0	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	2	0	196	X			
5987	414	8	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	4	3	0	4	3	0	0	0	0	f	2	2	0	28	Top 32			
5992	418	7	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	218	X			
6003	423	9	t	f	1	4	0	2	0	2	0	0	6	4	0	7	8	0	7-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	169	Day 2		Dimir Bounce	
7253	423	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	2	0	29	Top 32		Azorius Omniscience	
5994	420	1	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	185	X			2-0 yay. 2-5 not yay, not D2.
6024	435	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	229	x	Rampant Growth Heavy Play	Gruul Mice	
6027	437	7	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	154	X	Sewer Rats		
6034	439	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	64	Day 2	Nerd Rage Gaming	Mono-Red Aggro	
7240	439	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	3	1	0	16	Top 16	CFB Ultimate Guard	Izzet Prowess	
6036	440	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	138	Day 2	CFB Ultimate Guard	Domain Overlords	
6041	445	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	81	Day 2		Golgari Midrange	
7329	445	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	105	Day 2		Boros Aggro	
6018	433	1	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	205	X	Sewer Rats		1-1, then no more wins, out after R6.
6056	451	1	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	117	Day 2	Channel Fireball	Izzet Creativity	Four straight wins on D1 was still only enough for 4-4, and then four straight defeats was more than enough to see him out of contention.
6045	446	7	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	225	X	Moriyama Japan	Mardu Energy	Only one win all day.
6050	447	9	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	2	1	63	Day 2	Worldly Counsel Heavy Play	Gruul Mice	
7310	447	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	86	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	
6051	448	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	73	Day 2	Seedcore	Jeskai Monument	
7307	448	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	83	Day 2		Boros Monument	
6052	449	9	t	f	4	2	0	2	1	1	1	0	8	2	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	9	1	1	9	Top 16		Esper Pixie	
7498	449	10	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	4	0	274	x	Worldly Counsel Heavy Play	Izzet Prowess	
6064	451	9	t	f	4	1	1	2	2	0	0	0	6	4	0	10	5	1	10-5-1	6	2	0	4	3	1	0	0	0	f	5	3	1	36	Day 2	Handshake Moxfield	Azorius Control	
7243	451	10	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	8	3	1	19	Top 32	Handshake Moxfield	Golgari Roots	
6068	455	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	243	x		Dimir Midrange	
6069	456	9	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	205	Day 2		Jeskai Oculus	
6072	457	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	t	9	4	1	31	Top 32		Azorius Oculus	
7258	457	10	t	f	4	2	0	2	1	1	1	0	6	3	0	10	5	0	10-5-0	7	1	0	3	4	0	0	0	0	t	5	2	1	34	Day 2		Golgari Graveyard	
6073	458	9	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	343	x		Domain Overlords	
6074	459	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	160	X			
6075	459	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	227	x		Esper Pixie	
6082	464	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	4	0	182	Day 2		Sultai Terror	
7274	466	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	2	1	50	Day 2		Azorius Control	
7264	468	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	4	2	0	40	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
6094	468	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	91	Day 2		Gruul Mice	
6099	469	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	157	Day 2	Team Bus Stop	Gruul Mice	
6100	470	7	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	5	0	133	Day 2			
7316	473	10	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	92	Day 2		Dimir Midrange	
6107	475	7	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	7	0	134	Day 2	Temple of Malady		
6108	476	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	4	0	47	Day 2	SystemMagic	Gruul Mice	
7342	476	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	118	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
6111	479	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	113	Day 2		Esper Pixie	
6112	480	9	f	f	0	3	0	1	0	1	0	1	0	5	0	0	8	0	0-8-0	0	8	0	0	0	0	0	0	0	f	0	8	0	347	x		Esper Pixie	
7323	482	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	99	Day 2	Moriyama Japan	Izzet Prowess	
6117	484	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	189	Day 2	Nerd Rage Gaming	Esper Pixie	
6127	489	9	t	f	3	3	0	2	1	1	0	0	5	4	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	3	0	134	Day 2		Temur Exhaust	
6145	497	9	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	221	x		Gruul Mice	
6155	500	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	331	x		Azorius Artifacts	
6156	501	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	276	x		Domain Overlords	
6163	502	7	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	3	0	153	X	Handshake Ultimate Guard	Bant Nadu	3-1-1 before three straight defeats to miss out on D2.
6164	502	8	f	f	1	2	0	1	0	1	0	0	2	1	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	1	2	0	58	X	Handshake Ultimate Guard	Domain Ramp	A R6 draw in the Domain Ramp mirror against Mitchell Tamblyn ultimately cost him his D2 place.
6165	502	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	70	Day 2	Handshake Moxfield	Jeskai Convoke	
7295	502	10	t	f	2	4	0	2	1	1	0	1	7	2	1	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	3	3	0	71	Day 2	Handshake Moxfield	Golgari Roots	
7337	503	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	113	Day 2	Moriyama Japan	Izzet Prowess	
6173	507	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	93	Day 2	Seedcore	Mardu Monument	
6192	515	1	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	51	Day 2		Izzet Phoenix	5-1 in Draft excellent, 4-6 in Pioneer less so.
6114	482	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	66	Day 2	Moriyama Japan	Esper Pixie	
6179	511	8	f	f	0	3	0	1	0	1	0	1	2	1	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	2	3	0	94	X			
6184	513	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	93	Day 2	Handshake Ultimate Guard	Bant Nadu	5-2 and  6-3 before two losses ended his chances.
6186	513	9	t	f	2	4	0	2	1	1	0	1	9	1	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	6	3	1	34	Day 2	Cosmos Heavy Play	Golgari Obliterator	
7249	513	10	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	7	3	1	25	Top 32	Cosmos Heavy Play	Azorius Omniscience	
6191	514	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	323	x	Team Bus Stop	Domain Overlords	
6193	515	2	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	119	Day 2	Italians	Rakdos Midrange	Edged into D2 but was soon out of contention.
6197	515	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	139	X	Italy	Boros Convoke	2-0 but couldn't reach D2 with only one more win.
6200	516	2	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	2	0	69	Day 2	Handshake	Rakdos Midrange	6-2 D1 meant he was in contention heading back to Standard D2. 2-3 record there wasn't enough.
6205	516	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	69	Day 2	Handshake Ultimate Guard	Jeskai Control	4-4 again on D1 left him too much to do. Solid 5-3 D2.
6207	516	9	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	153	Day 2	Cosmos Heavy Play	Gruul Mice	
7247	516	10	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	7	2	1	23	Top 32	Cosmos Heavy Play	Azorius Omniscience	
6209	518	9	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	290	x		Esper Pixie	
6213	521	7	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	157	X	Chang Lee		
6216	523	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	97	Day 2	Worldly Counsel		
6219	525	9	t	t	4	2	0	2	1	1	1	0	9	2	0	13	4	0	13-4-0	6	2	0	6	1	0	1	1	0	t	10	2	1	3	Semifinals		Domain Overlords	
7520	525	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	296	x		Domain Overlords	
6224	527	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	4	0	100	Day 2	Team Pluto	Azorius Bunnicorn	
6228	529	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	98	Day 2		Domain Overlords	
6227	529	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	174	X	Channel Fireball		
6229	530	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	239	x		Dimir Midrange	
6230	531	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	7	5	1	142	Day 2		Gruul Leyline	
6231	532	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	256	x		Gruul Mice	
6232	533	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	234	X	CFB Ultimate Guard		
6233	533	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	2	0	196	Day 2	Nerd Rage Gaming	Golgari Graveyard	
6234	534	7	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	201	X	Tenacious Underdogs		
6235	535	7	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	206	X			
6236	536	9	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	4	1	83	Day 2		Selesnya Aggro	
6239	538	8	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	106	X	Lim Wijaya		
6244	542	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	238	x	Italian Team	Domain Overlords	
6221	527	1	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	72	Day 2			Unsurprising 7-3 in Pioneer. Surprising 2-4 in Draft, including an 0-3 on D2.
6245	543	9	t	f	3	3	0	2	1	1	1	1	5	4	0	8	7	0	8-7-0	5	3	0	3	3	0	0	0	0	f	3	4	0	130	Day 2		Golgari Roots	
6246	544	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	171	X			
6248	545	9	t	t	6	0	0	2	2	0	2	0	7	5	0	13	5	0	13-5-0	7	1	0	5	3	0	1	1	0	t	6	2	1	4	Semifinals		Gruul Mice	
7227	545	10	t	t	4	2	0	2	2	0	0	0	9	2	0	13	4	0	13-4-0	6	2	0	6	1	0	1	1	0	t	6	1	1	3	Semifinals	MTG Sheep	Mono-Red Aggro	
6249	546	9	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	164	Day 2		Bant Cage	
7405	549	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	181	Day 2		Izzet Prowess	
6253	549	8	t	f	5	1	0	2	2	0	1	0	4	4	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	t	4	4	0	11	Top 16			
6256	551	7	t	f	1	4	1	2	0	1	0	1	4	3	2	5	7	3	5-7-3	3	2	3	2	5	0	0	0	0	f	2	3	0	128	Day 2			
6257	551	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	68	X			
6258	551	9	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	336	x		Dimir Bounce	
6259	552	7	f	f	1	1	1	1	0	0	0	0	2	2	1	3	3	2	3-3-2	3	3	2	0	0	0	0	0	0	f	1	2	0	149	X			
6261	554	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	228	x		Esper Pixie	
7408	554	10	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	184	Day 2		Izzet Prowess	
6262	555	9	t	f	5	0	1	2	2	0	1	0	3	6	1	8	6	2	8-6-2	5	2	1	3	4	1	0	0	0	f	5	3	1	120	Day 2		Mono-White Caretaker	
6267	557	9	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	108	Day 2	Nerd Rage Gaming	Mono-Red Aggro	
6274	562	8	t	f	2	3	0	2	1	1	0	0	3	4	1	5	7	1	5-7-1	3	3	0	2	4	1	0	0	0	f	3	2	0	49	Day 2			
6275	562	9	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	2	1	0	75	Day 2	CFB Ultimate Guard	Jeskai Oculus	
6276	563	7	t	f	2	4	0	2	0	2	0	0	3	5	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	3	3	0	142	Day 2	CFB Ultimate Guard		
6279	565	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	2	0	41	Day 2	SystemMagic	Domain Overlords	
7256	565	10	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	7	1	0	3	4	0	0	0	0	t	8	3	1	32	Top 32	Rampant Growth Heavy Play	Izzet Prowess	
6299	575	1	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	104	Day 2		Izzet Creativity	Fought back from 1-3 to sneak into D2, where a 1-2 Draft ended his chances.
6287	567	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	301	x	Worldly Counsel Heavy Play	Temur Analyst	
6289	568	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	160	Day 2		Azorius Oculus	
6291	569	7	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	2	0	117	Day 2	Channel Fireball		
6292	569	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	106	Day 2	CFB Ultimate Guard	Jeskai Oculus	
7233	569	10	t	f	6	0	0	2	2	0	2	0	6	4	0	12	4	0	12-4-0	6	2	0	6	2	0	0	0	0	t	3	1	0	9	Top 16	CFB Ultimate Guard	Domain Overlords	
7453	573	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	229	x	Team Pluto	Izzet Prowess	
6307	575	9	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	110	Day 2	CFB Ultimate Guard	Domain Overlords	
7475	575	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	251	x	CFB Ultimate Guard	Domain Overlords	
6309	577	7	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	186	X			
6310	578	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	324	x		Selesnya Cage	
6314	582	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	6	3	1	96	Day 2		Golgari Roots	
6315	583	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	259	x		Selesnya Cage	
6318	585	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	314	x		Esper Pixie	
6322	588	8	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	108	X			
6323	588	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	48	Day 2	Moriyama Japan	Domain Overlords	
7320	588	10	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	96	Day 2	Moriyama Japan	Domain Overlords	
7386	589	10	t	f	2	4	0	2	0	2	0	0	5	4	1	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	2	0	162	Day 2	Moriyama Japan	Mono-Red Aggro	
6332	589	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	159	Day 2	Moriyama Japan	Boros Convoke	
6340	595	9	t	f	3	3	0	2	1	1	0	0	4	4	2	7	7	2	7-7-2	4	2	2	3	5	0	0	0	0	f	2	3	0	171	Day 2	Worldly Counsel Heavy Play	Domain Overlords	
6341	596	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	5	1	1	22	Top 32	Rampant Growth Heavy Play	Dimir Bounce	
7456	596	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	232	x		Dimir Midrange	
6379	613	1	t	f	4	2	0	2	2	0	0	0	5	4	0	9	6	0	9-6-0	5	3	0	4	3	0	0	0	0	f	2	2	0	45	Day 2	Rampant Growth Heavy Play		Still alive for Top 8 heading back to Pioneer at 7-4, but soon out of contention.
6351	600	8	f	f	1	2	0	1	0	1	0	0	1	2	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	1	2	0	93	X	Worldly Counsel Heavy Play		
6352	600	9	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	5	0	207	Day 2		Esper Pixie	2
6357	603	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	143	X		Enigmatic Fires	Really disappointing from 3-1 to end 3-5 and out on D1.
6364	604	9	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	3	1	20	Top 32	Worldly Counsel Heavy Play	Domain Overlords	
7465	604	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	241	x	Worldly Counsel Heavy Play	Izzet Prowess	
6368	605	8	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	3	0	47	Day 2	Worldly Counsel		
6370	607	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	224	X	Canada+		
6373	609	9	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	6	4	1	118	Day 2		Domain Overlords	
6374	610	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	2	6	0	0	0	0	f	4	6	0	204	Day 2		Simic Merfolk	
6375	611	7	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	214	X	French		
6377	612	7	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	5	0	127	Day 2	Sanctum of All		
6383	616	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	335	x	Nerd Rage Gaming	Golgari Graveyard	
6280	566	7	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	217	X	Sewer Rats		
6418	643	1	t	f	2	4	0	2	1	1	0	1	9	1	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	3	1	17	Top 32	Sanctum of All	Selesnya Angels	A solid 2-1 into 6-2 on D1. Despite winning his last five on D2, he was already done, having gone 0-3 in Draft.
6385	618	9	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	5	0	309	x		Gruul Mice	
6388	620	7	t	f	3	2	1	2	1	0	0	0	4	6	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	3	2	0	113	Day 2	Worldly Counsel		
6389	621	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	102	Day 2	Worldly Counsel Heavy Play		
6390	621	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	76	X	Worldly Counsel Heavy Play		
6392	622	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	300	x	Italian Team	Gruul Mice	
6395	624	7	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	118	Day 2	Sanctum of All		
6407	633	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	327	x		Domain Overlords	
6409	635	7	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	200	X			
6410	636	7	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	199	X			
6415	640	9	f	f	0	2	1	1	0	1	0	0	2	3	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	2	3	0	287	x		Gruul Delirium	
6426	643	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	151	Day 2	Moriyama Japan	Jeskai Oculus	
7245	643	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	2	1	21	Top 32	Moriyama Japan	Mono-Red Aggro	
6432	644	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	104	Day 2	Italian Team	Domain Overlords	
6435	647	9	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	194	Day 2		Jeskai Oculus	
6436	648	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	268	x	Team Bus Stop	Gruul Prowess	
6438	649	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	232	x	Nerd Rage Gaming	Mono-Red Aggro	
7479	650	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	255	x	Sanctum of All	Izzet Prowess	
6450	657	9	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	42	Day 2	SystemMagic	Gruul Mice	
7334	657	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	4	0	110	Day 2	Flexslot Diamond	Azorius Omniscience	
6453	659	9	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	4	3	0	28	Top 32		Gruul Mice	
7452	659	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	228	x		Boros Aggro	
6474	669	1	t	t	4	2	0	2	1	1	1	0	8	3	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	5	2	1	8	Top 8	Rampant Growth Heavy Play	Izzet Creativity	Perfect 3-0 Draft to start, and in great shape at 7-1. 8-3 after Draft, he won three straight, getting him to the verge of T8. R15 saw him get there over Dan Kristoff, but he lost his QF to Benton Madsen.
6462	661	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	103	Day 2	Moriyama Japan	Jeskai Oculus	
7248	661	10	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	9	2	1	24	Top 32	Moriyama Japan	Izzet Prowess	
6465	663	8	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	4	0	105	X	Kenji		
6467	665	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	170	X	Japan 2		
7457	665	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	233	x		Izzet Prowess	
6471	667	8	t	f	4	2	0	2	1	1	1	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	4	0	41	Day 2			
6472	667	9	t	f	4	2	0	2	1	1	1	0	4	5	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	4	3	0	127	Day 2	Rampant Growth Heavy Play	Esper Pixie	
7290	667	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	66	Day 2	Rampant Growth Heavy Play	Azorius Omniscience	
6473	668	9	t	t	5	1	0	2	2	0	1	0	10	0	0	15	1	0	15-1-0	8	0	0	4	1	0	3	0	0	t	10	1	1	1	Champion	CFB Ultimate Guard	Domain Overlords	
7350	668	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	5	0	126	Day 2	CFB Ultimate Guard	Izzet Prowess	
6481	669	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	6	2	1	46	Day 2	CFB Ultimate Guard	Jeskai Oculus	
7309	669	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	85	Day 2	CFB Ultimate Guard	Domain Overlords	
6483	671	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	182	X	Worldly Counsel		
6486	673	2	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	252	X	Channel Fireball	Grixis Midrange	0-5. Drop.
6378	612	9	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	6	2	0	2	6	0	0	0	0	f	6	5	1	152	Day 2	SystemMagic	Gruul Mice	
6497	679	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	63	Day 2	Main Phase	Abzan Auras	1-3, recovered to make D2, then 5-3, but never in serious contention.
6487	673	5	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	5	2	1	31	Top 32	Channel Fireball	Rakdos Sacrifice	Excellent 5-0 start into 6-2 D1. Improved from 7-4 to 10-4 before Dillon Kikkawa won their R15 clash.
6493	676	8	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	101	X	Killers Among Us		
7327	678	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	3	0	103	Day 2		Izzet Prowess	
6502	679	6	t	f	5	1	0	2	2	0	1	0	5	4	0	10	5	0	10-5-0	4	4	0	6	1	0	0	0	0	t	6	2	1	27	Top 32	Handshake	Esper Midrange	A brilliant D2 that began 6-0 was wasted by a haphazard D1 that ended at the minimum 4-4. It still took Javier Dominguez in the penultimate round to prevent a fifth T8 in a row. Literally extraordinary.
6505	679	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	3	1	0	29	Top 32	Handshake Moxfield	Jeskai Convoke	
7318	679	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	94	Day 2	Handshake Moxfield	Golgari Roots	
6506	680	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	311	x		Esper Pixie	
6509	682	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	3	1	141	Day 2		Domain Overlords	
6510	683	9	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	183	Day 2		Esper Pixie	
6513	684	7	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	213	X	Misfits		
7280	684	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	5	1	56	Day 2	Team Serious Players Only	Izzet Prowess	
6515	686	8	t	f	2	4	0	2	1	1	0	1	5	2	1	7	6	1	7-6-1	5	2	0	2	4	1	0	0	0	f	3	3	0	37	Day 2			
6516	686	9	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	6	0	198	Day 2		Esper Pixie	
7364	686	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	140	Day 2		Izzet Prowess	
6529	337	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	224	x		Gruul Mice	
7469	691	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	245	x	Moriyama Japan	Mono-Red Aggro	
6525	692	9	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	199	Day 2		Dimir Bounce	
6540	698	8	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	3	3	0	27	Top 32	Sewer Rats		
6541	698	9	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	222	x	Team Bus Stop	Golgari Midrange	
6543	700	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	253	x		Dimir Bounce	
6524	691	4	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	92	X			Lone win was in Draft.
6566	711	1	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	5	3	1	54	Day 2		Rakdos Sacrifice	4-2 turned into 4-5, and a five win streak on D2 was already too late.
6554	704	9	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	191	Day 2		Gruul Mice	
6558	708	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	226	x	Nerd Rage Gaming	Esper Pixie	
7293	711	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	69	Day 2	CFB Ultimate Guard	Izzet Prowess	
6574	711	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	82	Day 2	CFB Ultimate Guard	Jeskai Oculus	
6577	714	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	225	x			
6579	716	8	t	f	2	4	0	2	1	1	0	1	5	3	0	7	7	0	7-7-0	5	2	0	2	5	0	0	0	0	f	2	3	0	43	Day 2	Belfatto Kurz Parson Wienburg		
6581	718	9	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	3	6	0	136	Day 2	Sanctum of All	Domain Overlords	
6584	720	8	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	97	X			
6586	722	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	299	x		Jeskai Oculus	
6592	723	9	t	f	5	1	0	2	2	0	1	0	4	4	2	9	5	2	9-5-2	5	3	0	4	2	2	0	0	0	f	3	2	0	74	Day 2	Worldly Counsel Heavy Play	Domain Overlords	
7383	723	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	159	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
6596	726	7	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	189	X			
6599	727	8	f	f	3	0	0	1	1	0	1	0	0	4	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	4	0	62	X	Sanctum of All		
6600	727	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	50	Day 2	Sanctum of All	Esper Pixie	
7455	727	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	231	x	Sanctum of All	Izzet Prowess	
7374	728	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	150	Day 2		Mono-Red Aggro	
6607	730	7	t	f	3	3	0	2	1	1	0	0	3	3	0	6	6	0	6-6-0	4	4	0	2	2	0	0	0	0	f	2	2	0	138	Day 2	Canada+		
7430	731	10	t	f	3	3	0	2	1	1	1	1	1	4	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	3	4	0	206	Day 2		Mono-Black Demons	
6610	732	8	t	t	5	1	0	2	2	0	1	0	6	3	0	11	4	0	11-4-0	5	2	0	6	1	0	0	1	0	t	5	1	1	5	Top 8	Scoreboard		
6611	732	9	f	f	1	1	1	1	0	0	0	0	0	3	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	3	0	321	x		Esper Pixie	
7257	732	10	t	f	6	0	0	2	2	0	2	0	4	5	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	5	2	1	33	Day 2		Dimir Midrange	
6612	733	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	266	x		Mardu Monument	
6615	735	7	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	3	0	115	Day 2			
6621	738	9	t	f	2	4	0	2	0	2	0	0	6	3	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	2	2	0	133	Day 2		Gruul Mice	
6626	743	9	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	f	6	4	1	16	Top 16	Sanctum of All	Esper Pixie	
7228	743	10	t	t	5	1	0	2	2	0	1	0	8	4	0	13	5	0	13-5-0	7	1	0	5	3	0	1	1	0	t	4	2	0	4	Semifinals	Sanctum of All	Izzet Prowess	
6633	747	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	77	X			
6642	755	9	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	185	Day 2	Nerd Rage Gaming	Golgari Graveyard	
7360	757	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	136	Day 2	Team Serious Players Only	Izzet Prowess	
6648	760	7	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	122	Day 2			
6650	761	7	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	5	3	1	103	Day 2	2Free		
6651	762	7	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	95	Day 2	Milkshake		
6635	749	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	98	Day 2			Even throughout. Won R8 to advance to D2.
6660	765	9	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	6	0	187	Day 2	Cosmos Heavy Play	Golgari Obliterator	
7283	765	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	1	0	59	Day 2	Cosmos Heavy Play	Azorius Omniscience	
6663	767	8	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	102	X			
6664	767	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	158	Day 2	Rampant Growth Heavy Play	Domain Overlords	
6670	769	8	t	t	2	4	0	2	0	2	0	0	8	1	0	10	5	0	10-5-0	5	2	0	5	2	0	0	1	0	t	5	2	1	7	Top 8			
6671	769	9	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	3	0	209	Day 2		Dimir Demons	
7388	769	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	6	0	164	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
6673	771	9	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	84	Day 2		Domain Overlords	
6674	772	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	251	x		Gruul Mice	
6677	774	3	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	237	X	Sewer Rats	Four-Color Omnath	Couldn't recover from an 0-3 Draft hole D1.
6681	774	7	f	f	1	1	1	1	0	0	0	0	0	3	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	3	0	220	X	Sanctum of All	Four-Color Nadu	Just a single win to show for six rounds of D1 effort.
6683	774	9	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	6	0	215	Day 2	Sanctum of All	Esper Paragon	
6686	776	9	t	f	3	2	1	2	1	1	1	0	6	4	0	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	3	3	0	76	Day 2	CFB Ultimate Guard	Domain Overlords	
7324	776	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	100	Day 2	CFB Ultimate Guard	Izzet Prowess	
6691	779	7	t	f	2	1	0	2	1	0	0	0	1	2	2	3	3	2	3-3-2	3	3	2	0	0	0	0	0	0	f	1	1	0	147	Day 2			
6692	780	9	t	t	4	2	0	2	2	0	0	0	8	3	0	12	5	0	12-5-0	5	3	0	7	1	0	0	1	0	t	5	2	1	8	Top 8	Nerd Rage Gaming	Mono-Red Aggro	
7226	780	10	t	t	6	0	0	2	2	0	2	0	8	3	0	14	3	0	14-3-0	7	1	0	5	1	0	2	1	0	t	7	1	1	2	Finals	Flexslot Diamond	Izzet Prowess	
6693	781	9	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	4	2	0	132	Day 2		Bant Gearhulk	
6696	784	7	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	226	X	Misfits		
7238	785	10	t	f	3	3	0	2	1	1	0	0	8	1	0	11	4	0	11-4-0	5	3	0	6	1	0	0	0	0	t	6	1	1	14	Top 16	Worldly Counsel Heavy Play	Izzet Prowess	
6704	788	7	t	f	3	0	0	2	1	0	1	0	1	4	0	4	4	0	4-4-0	4	4	0	0	0	0	0	0	0	f	3	3	0	146	Day 2	Ferguson Rolph Rose Smith		
6705	789	9	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	341	x	Seedcore	Esper Pixie	
6707	790	9	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	111	Day 2		Gruul Mice	
6709	792	9	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	44	Day 2		Dimir Midrange	
7260	792	10	t	f	4	1	1	2	1	0	1	0	6	4	0	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	5	1	1	36	Day 2		Azorius Omniscience	
6711	794	9	t	f	3	3	0	2	1	1	1	1	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	8	3	1	60	Day 2		Izzet Artifacts	
7315	794	10	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	7	1	0	2	6	0	0	0	0	f	7	3	1	91	Day 2		Izzet Prowess	
6713	795	9	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	2	5	0	0	0	0	f	3	3	0	200	Day 2	SystemMagic	Gruul Mice	
6716	796	3	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	1	0	20	Top 32	Sewer Rats	Rakdos Grief	Three and four round win streaks kept him in the mix until a R15 defeat to Dominic Harvey.
6718	796	5	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	35	Day 2	Sewer Rats	Rakdos Midrange	3-0 to start into 5-3 overnight. 1-2 second time around in Draft eliminated him from contention.
6722	797	7	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	210	X			
6726	799	9	t	f	1	5	0	2	0	2	0	1	7	2	0	8	7	0	8-7-0	5	3	0	3	4	0	0	0	0	f	6	3	1	125	Day 2		Dimir Enchantments	
6730	802	8	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	79	X	SE Asia		
7305	807	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	81	Day 2		Izzet Prowess	
6738	809	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	233	x		Golgari Midrange	
7328	809	10	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	104	Day 2	Team Pluto	Mono-Red Aggro	
6744	811	9	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	149	Day 2	Team Pluto	Domain Overlords	
7291	811	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	67	Day 2	Team Pluto	Mono-Red Aggro	
6753	813	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	262	x		Mono-White Caretaker	
6765	816	8	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	110	X	Handshake Ultimate Guard	Domain Ramp	Just one win in five before packing them up.
6766	816	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	6	2	1	32	Top 32	Handshake Moxfield	Jeskai Convoke	
7288	816	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	64	Day 2	Handshake Moxfield	Azorius Omniscience	
6768	817	8	t	f	1	4	0	2	0	2	0	0	6	2	0	7	6	0	7-6-0	4	3	0	3	3	0	0	0	0	f	2	2	0	36	Day 2	Sewer Rats		
7276	818	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	5	3	1	52	Day 2		Izzet Prowess	
6772	819	3	f	f	0	2	1	1	0	1	0	0	0	2	0	0	4	1	0-4-1	0	4	1	0	0	0	0	0	0	f	0	4	0	262	X	Moriyama Japan	Temur Rhinos	A R1 draw was the best result of the day. Dropped after R5.
6777	821	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	339	x		Dimir Midrange	
6783	824	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	83	X	Scoreboard		
6785	826	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	169	X			
6791	830	9	t	f	4	2	0	2	1	1	1	0	8	2	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	8	2	1	11	Top 16		Selesnya Cage	
7391	830	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	167	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
6792	831	1	t	f	2	3	1	2	0	1	0	0	6	4	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	2	0	80	Day 2		Lotus Field Combo	Barely made D2, and 4-4 thereafter.
7376	831	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	152	Day 2	Handshake Moxfield	Azorius Omniscience	
6801	832	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	305	x		Azorius Bunnicorn	
6807	835	5	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	6	2	1	18	Top 32	Channel Fireball	Rakdos Vampires	6-0 in Draft; six round wins in a row; playing an outstanding constructed deck in Rakdos Vampires; and 5-5 in Pioneer left him short of T8.
6809	836	9	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	337	x		Bant Gearhulk	
6818	840	9	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	4	0	117	Day 2	Italian Team	Domain Overlords	
6823	844	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	248	x	SystemMagic	Gruul Mice	
6824	845	8	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	109	X			
6827	848	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	176	Day 2		Mono-Red Aggro	
6832	852	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	191	X	Temple of Malady		
6833	852	8	f	f	2	1	0	1	1	0	0	0	0	3	1	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	2	2	0	84	X			
6834	853	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	92	Day 2			
6867	875	2	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	3	2	0	159	X			Won three in a row to reach 3-1, but no wins after that.
6843	858	9	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	344	x	Sanctum of All	Esper Paragon	
6853	866	9	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	6	0	177	Day 2		Domain Overlords	
6855	868	7	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	3	0	216	X			
6859	870	9	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	3	0	208	Day 2	Team Bus Stop	Golgari Roots	
6862	871	7	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	215	X	SE Asia		
6864	873	9	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	6	0	181	Day 2	Handshake Moxfield	Jeskai Convoke	
6866	874	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	236	x	Team Pluto	Rakdos Sacrifice	
6870	876	7	t	f	1	4	1	2	0	2	0	0	10	0	0	11	4	1	11-4-1	5	2	1	6	2	0	0	0	0	t	6	2	1	9	Top 16	CFB Ultimate Guard	Esper Goryo's	Heartbreaking. Literal constructed perfection of 10-0 neutered by 1-4-1 in Draft.
6872	876	9	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	5	2	1	18	Top 32	CFB Ultimate Guard	Esper Pixie	
7341	876	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	3	0	117	Day 2	CFB Ultimate Guard	Izzet Prowess	
6875	877	8	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	87	X	Temple of Malady		
6876	877	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	85	Day 2	Rampant Growth Heavy Play	Gruul Mice	
7351	877	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	3	5	0	127	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
7396	879	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	4	1	172	Day 2	Sanctum of All	Izzet Prowess	
6884	881	9	t	f	2	3	1	2	1	1	0	1	5	5	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	3	5	0	174	Day 2		Esper Pixie	
6888	882	4	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	2	0	99	X	Handshake	Azorius Soldiers	Only a single match win.
7333	889	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	5	0	109	Day 2	Flexslot Diamond	Izzet Prowess	
6902	890	8	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	t	3	2	0	12	Top 16	Worldly Counsel		
6903	890	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	242	x		Boros Convoke	
6906	892	9	t	f	2	4	0	2	0	2	0	0	3	7	0	5	11	0	5-11-0	4	4	0	1	7	0	0	0	0	f	2	5	0	218	Day 2		Esper Midrange	
6907	893	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	2	1	116	Day 2		Azorius Oculus	
6885	882	1	t	t	5	1	0	2	2	0	1	0	7	3	1	12	4	1	12-4-1	6	2	0	6	1	1	0	1	0	t	6	1	1	6	Top 8		Lotus Field Combo	Six straight wins D1, four straight D2, won his last two rounds to reach the T8. Lost narrowly to Reid Duke in QFs.
6910	896	1	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	3	2	0	18	Top 32	CFB Ultimate Guard	Abzan Greasefang	Excellent 8-2 in Pioneer with Abzan Greasefang, but 3-3 in Draft left him just shy of T8.
6899	889	1	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	89	Day 2	Chinese		Pair of 2-1s in Draft, 4-6 in Pioneer. Another positive was winning twice in elimination matches to reach D2.
6891	883	1	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	103	Day 2	Handshake Ultimate Guard		Really good 7-3 in Pioneer, but opportunity missed via 1-5 in Draft.
6916	898	9	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	3	2	0	25	Top 32		Gruul Mice	
7463	898	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	239	x		Mono-Red Aggro	
6923	900	3	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	144	Day 2	Moriyama Japan	Rakdos Grief	A familiar 4-4 D1. No big streak D2.
6924	900	4	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	57	X	Moriyama Japan	Esper Midrange	Needed to win twice to make D2. Couldn't get past Willy Edel in the final round.
6928	900	8	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	99	X	Moriyama Japan	Dimir Midrange	This time the 0-3 Draft was fatal.
6929	900	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	90	Day 2	Cosmos Heavy Play	Azorius Omniscience	
7296	900	10	t	f	4	1	1	2	2	0	0	0	5	5	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	2	2	0	72	Day 2	Cosmos Heavy Play	Dimir Midrange	
7367	902	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	143	Day 2		Izzet Prowess	
6939	903	5	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	36	Day 2	Misfits	Azorius Control	Excellent position at 8-2 before three straight losses eliminated him from the reckoning.
6921	900	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	41	Day 2	Misfits	Azorius Control	0-2, but made D2. Out of contention early, but still found five wins in a row late.
6935	903	1	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	44	Day 2		Azorius Control	Had to win R8 to reach D2, but was very solid once there, going 6-2 on the day, without ever being in contention.
6958	915	1	t	f	1	5	0	2	0	2	0	1	5	4	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	3	5	0	121	Day 2	Handshake Ultimate Guard		Above the line in Pioneer at 5-4, but 1-5 in Draft.
6960	917	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	142	X	Sanctum of All		From 3-1 to 3-5.
6943	903	9	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	330	x	SystemMagic	Domain Overlords	
6945	905	9	f	f	0	2	0	1	0	1	0	0	2	3	0	2	5	0	2-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	244	x		Gruul Mice	
7431	906	10	t	f	1	4	0	2	0	2	0	0	3	2	0	4	6	0	4-6-0	4	4	0	0	2	0	0	0	0	f	1	2	0	207	Day 2		Azorius Omniscience	
6963	920	1	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	2	1	32	Top 32		Gruul Vehicles	Centerpiece was a rock solid six round streak. Brent Vos effectively knocked him out in R14.
6969	920	7	t	f	5	1	0	2	2	0	1	0	5	4	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	4	1	0	26	Top 32	Worldly Counsel	Bant Nadu	5-3 overnight became 8-3 with a Draft pod win. Seth Manfield eliminated him from T8 contention in R14.
6971	920	9	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	5	0	186	Day 2	Worldly Counsel Heavy Play	Azorius Oculus	
7321	920	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	1	0	97	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
6981	925	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	148	Day 2		Selesnya Cage	
6985	927	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	81	X	Sanctum of All		
6986	927	9	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	1	1	26	Top 32	Sanctum of All	Esper Pixie	
7485	927	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	261	x	Sanctum of All	Izzet Prowess	
6988	928	9	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	332	x		Esper Pixie	
6989	929	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	283	x		Domain Overlords	
6990	930	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	303	x	Rampant Growth Heavy Play	Esper Pixie	
6995	931	9	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	147	Day 2		Esper Pixie	
7000	935	3	t	f	3	2	0	2	1	0	0	0	5	5	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	4	0	72	Day 2	2Free	Boros Burn	4-1 - good. 4-5 - bad. Won his last three when well out of contention.
7005	935	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	255	x	Nerd Rage Gaming	Mono-Red Aggro	
7246	935	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	5	2	1	22	Top 32	Cosmos Heavy Play	Mono-Red Aggro	
7010	937	9	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	1	0	119	Day 2	Cosmos Heavy Play	Gruul Mice	
7268	937	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	2	0	44	Day 2	Cosmos Heavy Play	Izzet Prowess	
7012	939	9	t	f	2	4	0	2	1	0	0	0	6	3	0	8	7	0	8-7-0	6	2	0	2	5	0	0	0	0	f	6	5	1	131	Day 2			
7013	940	7	f	f	0	2	1	1	0	1	0	0	2	3	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	2	0	197	X	French		
7017	941	4	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	96	X	Channel Fireball	Mono-White Humans	Just a single win before packing it in after R5.
7022	944	9	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	292	x		Dimir Midrange	
7023	945	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	313	x			
7026	947	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	175	X			
7027	948	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	161	Day 2	Seedcore	Gruul Leyline	
7028	949	9	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	165	Day 2		Bant Cage	
7029	950	7	f	f	1	2	0	1	0	1	0	0	0	3	1	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	3	0	221	X	Bus Stop		
7032	952	9	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	319	x		Golgari Midrange	
7033	953	7	t	f	4	1	1	2	1	0	0	0	4	6	0	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	2	2	0	85	Day 2			
7551	953	10	f	f	0	3	0	1	0	1	0	1	0	1	1	0	4	1	0-4-1	0	4	1	0	0	0	0	0	0	f	0	4	0	327	x		Azorius Control	
7035	955	7	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	2	0	121	Day 2			
7046	959	5	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	77	Day 2	Italians	Jeskai Creativity	4-2 into 4-5 to end his chances.
7031	951	3	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	224	X			One win in each format.
7052	963	7	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	203	X			
7056	965	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	180	X			
7064	969	7	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	185	X	Italians		
7076	975	4	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	101	X	Channel Fireball	Mono-White Humans	As bad as it can get. 0-4 drop.
6974	921	7	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	135	Day 2	Boston		
7108	991	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	150	X	Rampant Growth Heavy Play		Needed two wins to advance. Won R7, didn't R8.
7090	1502	9	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	5	0	166	Day 2		Esper Pixie	
7113	994	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	168	X	Sanctum of All		0-2 start led to 2-4. Needed two wins. Only got one.
7092	982	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	260	x		Jeskai Oculus	
7094	984	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	237	x		Dimir Bounce	
7098	986	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	306	x		Domain Overlords	
7099	987	9	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	162	Day 2		Gruul Mice	
7104	988	9	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	5	1	1	38	Day 2	SystemMagic	Gruul Mice	
7379	988	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	155	Day 2	Flexslot Diamond	Izzet Prowess	
7106	990	8	t	f	3	3	0	2	1	1	1	1	2	6	0	5	9	0	5-9-0	5	2	0	0	7	0	0	0	0	f	5	9	1	56	Day 2	Killers Among Us		
7107	990	9	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	155	Day 2	Rampant Growth Heavy Play	Gruul Mice	
7112	993	7	t	f	3	3	0	2	1	1	1	1	2	5	0	5	8	0	5-8-0	5	3	0	0	5	0	0	0	0	f	3	6	0	141	Day 2	Sewer Rats		
7118	997	7	f	f	0	1	2	1	0	1	0	0	0	2	1	0	3	3	0-3-3	0	3	3	0	0	0	0	0	0	f	0	1	0	229	X	Bus Stop		
7119	997	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	69	X	Bus Stop		
7120	997	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	318	x	Team Bus Stop	Gruul Mice	
7251	998	10	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	4	1	0	27	Top 32		Izzet Prowess	
7124	999	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	267	x	Rampant Growth Heavy Play	Gruul Mice	
7128	1001	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	285	x		Five-Color Legends	
7129	1002	9	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	4	1	0	33	Day 2	Handshake Moxfield	Azorius Control	
7368	1002	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	144	Day 2	Handshake Moxfield	Jeskai Control	
7133	1006	9	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	247	x	Seedcore	Mardu Monument	
7136	1007	8	t	f	4	2	0	2	1	1	1	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	3	0	52	Day 2	Tenacious Underdogs		
7137	1007	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	245	x		Selesnya Cage	
7434	1007	10	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	3	0	210	x	Scryhard	Mono-Red Aggro	
7346	1008	10	t	f	3	2	1	2	1	0	0	0	5	5	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	2	2	0	122	Day 2	CFB Ultimate Guard	Izzet Prowess	
7141	1009	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	163	X	Handshake		
7142	1009	9	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	8	3	1	17	Top 32	Handshake Moxfield	Gruul Mice	
7372	1009	10	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	148	Day 2	Handshake Moxfield	Izzet Prowess	
7160	1015	1	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	155	X			Winless in Draft, mounted a comeback to 3-3, but ran out of steam.
7425	1015	10	t	f	2	4	0	2	1	1	0	1	4	3	0	6	7	0	6-7-0	5	3	0	0	5	0	0	0	0	f	2	5	0	201	Day 2	Moriyama Japan	Izzet Prowess	
7164	1017	7	t	f	1	5	0	2	0	2	0	1	3	2	0	4	7	0	4-7-0	3	4	0	1	3	0	0	0	0	f	3	3	0	143	Day 2			
7165	1017	8	t	f	2	3	0	2	0	1	0	0	5	3	0	7	6	0	7-6-0	3	3	0	4	3	0	0	0	0	f	3	3	0	34	Day 2			
7263	1019	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	2	1	39	Day 2		Izzet Prowess	
7175	1019	9	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	86	Day 2		Domain Overlords	
7180	1020	9	t	f	3	3	0	2	1	1	0	0	8	2	0	11	5	0	11-5-0	4	4	0	7	1	0	0	0	0	f	6	1	1	35	Day 2	Sanctum of All	Esper Paragon	
7450	1020	10	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	226	x	Sanctum of All	Izzet Prowess	
7181	1021	9	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	3	2	0	78	Day 2	SystemMagic	Domain Overlords	
7182	1022	9	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	297	x		Domain Overlords	
7184	1023	8	t	f	3	3	0	2	1	1	0	0	5	2	0	8	5	0	8-5-0	4	3	0	4	2	0	0	0	0	f	3	2	0	23	Top 32			
7190	1026	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	3	0	82	X			
7191	1026	9	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	4	0	80	Day 2		Gruul Mice	
7375	1030	10	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	5	4	1	151	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	
7201	1031	9	t	f	3	3	0	2	1	1	0	0	9	1	0	12	4	0	12-4-0	6	2	0	6	2	0	0	0	0	t	6	2	1	10	Top 16	Moriyama Japan	Jeskai Oculus	
7225	1031	10	t	t	5	1	0	2	2	0	1	0	10	1	0	15	2	0	15-2-0	7	1	0	5	1	0	3	0	0	t	5	1	1	1	Champion	Moriyama Japan	Mono-Red Aggro	
7205	1034	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	275	x	Seedcore	Jeskai Monument	
7210	1036	7	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	101	Day 2	Sanctum of All	Four-Color Reclamation	It was a struggle to 3-3 before a four round burst lifted him into contention. Unfortunately it was followed by four straight defeats.
7212	1036	9	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	3	0	310	x	Sanctum of All	Esper Pixie	
7343	1036	10	t	f	4	0	2	2	2	0	0	0	4	6	0	8	6	2	8-6-2	6	1	1	2	5	1	0	0	0	f	3	5	0	119	Day 2	Sanctum of All	Izzet Prowess	
7213	1037	7	t	f	1	5	0	2	0	2	0	1	5	4	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	4	0	125	Day 2	Sanctum of All		
7217	1040	9	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	254	x			
7218	1041	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	261	x	Seedcore	Jeskai Monument	
7285	1248	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	1	0	61	Day 2		Izzet Prowess	
7229	1046	10	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	2	0	6	1	0	0	1	0	t	4	1	0	5	Top 8	Rampant Growth Heavy Play	Izzet Prowess	
7230	1047	10	t	t	4	2	0	2	1	1	1	0	8	2	0	12	4	0	12-4-0	5	3	0	7	0	0	0	1	0	t	8	1	1	6	Top 8	Team Serious Players Only	Mono-Red Aggro	
7231	1048	10	t	t	4	2	0	2	1	1	1	0	8	3	0	12	5	0	12-5-0	8	0	0	4	4	0	0	1	0	t	8	2	1	7	Top 8		Izzet Prowess	
7244	1049	10	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	20	Top 32		Izzet Prowess	
7252	1050	10	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	8	3	1	28	Top 32		Orzhov Demons	
7259	1051	10	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	2	0	35	Day 2	Moriyama Japan	Gruul Delirium	
7261	1052	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	8	4	1	37	Day 2		Izzet Prowess	
7262	1053	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	38	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
7266	1054	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	4	0	42	Day 2	Scryhard	Izzet Prowess	
7267	1055	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	43	Day 2	Scryhard	Azorius Omniscience	
7269	1056	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	1	0	45	Day 2	Sanctum of All	Izzet Prowess	
7271	1057	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	47	Day 2		Azorius Omniscience	
7272	1058	10	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	48	Day 2		Izzet Prowess	
7277	1059	10	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	53	Day 2	Team Serious Players Only	Izzet Prowess	
7278	1060	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	54	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
7281	1061	10	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	57	Day 2	Cosmos Heavy Play	Izzet Cauldron	
7282	1062	10	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	3	4	0	58	Day 2	Cosmos Heavy Play	Azorius Omniscience	
7286	1064	10	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	62	Day 2		Mono-Red Aggro	
7289	1066	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	65	Day 2	Italian Team	Izzet Prowess	
7298	1067	10	t	f	2	3	1	2	1	1	0	0	7	3	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	3	1	0	74	Day 2		Mono-Red Aggro	
7301	1068	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	4	1	77	Day 2	Flexslot Diamond	Jund Roots	
7302	1069	10	t	f	4	2	0	2	1	0	1	0	5	5	0	9	7	0	9-7-0	7	1	0	2	6	0	0	0	0	f	7	3	1	78	Day 2		Azorius Omniscience	
7303	1070	10	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	79	Day 2		Azorius Omniscience	
7304	1071	10	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	3	0	80	Day 2		Izzet Prowess	
7306	1072	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	5	0	82	Day 2		Selesnya Gearhulk	
7311	1074	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	3	1	87	Day 2		Mono-Red Aggro	
7312	1075	10	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	88	Day 2	Scryhard	Izzet Prowess	
7313	1076	10	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	4	4	0	89	Day 2		Orzhov Pixie	
7319	1077	10	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	95	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	
7322	1078	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	98	Day 2	Handshake Moxfield	Azorius Omniscience	
7330	1079	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	4	0	106	Day 2		Azorius Omniscience	
7308	923	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	84	Day 2	Team Serious Players Only	Azorius Omniscience	
7223	1043	2	t	f	3	2	1	2	1	0	0	0	3	6	1	6	8	2	6-8-2	4	3	1	2	5	1	0	0	0	f	4	3	0	141	Day 2	Temple of Malady		Won four straight to reach 6-3-1, but didn't win again.
7151	1011	9	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	342	x		Azorius Oculus	
7416	523	10	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	192	Day 2	Worldly Counsel Heavy Play	Azorius Omniscience	
7332	1080	10	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	108	Day 2	Scryhard	Izzet Prowess	
7338	1081	10	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	114	Day 2	Worldly Counsel Heavy Play	Izzet Prowess	
7345	1082	10	t	f	2	3	1	2	0	1	0	0	6	4	0	8	7	1	8-7-1	5	2	1	3	5	0	0	0	0	f	4	3	0	121	Day 2	Team Pluto	Izzet Prowess	
7349	1084	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	125	Day 2	Team Serious Players Only	Izzet Prowess	
7353	1085	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	129	Day 2		Orzhov Pixie	
7354	1086	10	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	130	Day 2		Mono-Red Aggro	
7355	1087	10	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	131	Day 2	Team Serious Players Only	Azorius Omniscience	
7356	1088	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	132	Day 2	Cosmos Heavy Play	Izzet Prowess	
7357	1089	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	133	Day 2		Golgari Midrange	
7358	1090	10	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	5	0	134	Day 2	Scryhard	Mono-Red Aggro	
7359	1091	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	135	Day 2	Team Pluto	Izzet Prowess	
7361	1092	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	5	0	137	Day 2		Izzet Prowess	
7362	1093	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	138	Day 2		Azorius Omniscience	
7366	1094	10	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	6	5	0	142	Day 2	Team Pluto	Mono-Red Aggro	
7369	1095	10	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	145	Day 2		Izzet Prowess	
7373	1096	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	149	Day 2		Izzet Prowess	
7377	1097	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	153	Day 2		Rakdos Aggro	
7380	1098	10	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	156	Day 2		Mono-Red Aggro	
7382	1099	10	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	158	Day 2		Mono-Red Aggro	
7384	1100	10	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	160	Day 2		Boros Aggro	
7385	1101	10	t	f	4	2	0	2	2	0	0	0	3	6	1	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	2	2	0	161	Day 2		Azorius Omniscience	
7387	1102	10	t	f	3	3	0	2	1	1	1	1	4	5	0	7	8	0	7-8-0	6	2	0	1	6	0	0	0	0	f	3	4	0	163	Day 2	Scryhard	Azorius Omniscience	
7390	1103	10	t	f	4	2	0	2	2	0	0	0	3	6	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	3	0	166	Day 2		Azorius Omniscience	
7392	1104	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	6	0	168	Day 2	Flexslot Diamond	Jeskai Oculus	
7394	1106	10	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	170	Day 2		Izzet Prowess	
7397	1107	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	173	Day 2	CFB Ultimate Guard	Izzet Prowess	
7398	1108	10	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	5	0	174	Day 2		Azorius Omniscience	
7399	1109	10	t	f	2	4	0	2	1	1	0	1	4	5	0	6	9	0	6-9-0	5	3	0	1	6	0	0	0	0	f	5	8	0	175	Day 2		Mono-Red Aggro	
7401	1110	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	177	Day 2		Izzet Prowess	
7403	1112	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	179	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
7409	1113	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	2	0	185	Day 2		Izzet Prowess	
7410	1114	10	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	5	3	1	186	Day 2	Rampant Growth Heavy Play	Izzet Prowess	
7411	1115	10	t	f	3	2	1	2	1	1	0	0	3	7	0	6	9	1	6-9-1	5	2	1	1	7	0	0	0	0	f	2	5	0	187	Day 2		Izzet Prowess	
7412	1116	10	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	5	3	0	1	5	0	0	0	0	f	2	5	0	188	Day 2		Izzet Prowess	
7414	1117	10	t	f	5	1	0	2	2	0	1	0	1	9	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	4	5	0	190	Day 2		Azorius Control	
7417	1119	10	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	4	0	193	Day 2		Domain Overlords	
7402	1502	10	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	178	Day 2		Izzet Prowess	
7393	1346	10	t	f	5	1	0	2	2	0	1	0	2	8	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	4	0	169	Day 2	Scryhard	Izzet Proft	
7418	1120	10	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	2	3	0	194	Day 2		Azorius Omniscience	
7419	1121	10	t	f	2	4	0	2	1	1	0	1	4	4	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	3	5	0	195	Day 2	Scryhard	Mono-Red Aggro	
7420	1122	10	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	2	4	0	196	Day 2		Azorius Omniscience	
7421	1123	10	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	3	0	197	Day 2		Izzet Prowess	
7422	1124	10	t	f	2	4	0	2	0	2	0	0	4	3	0	6	7	0	6-7-0	4	4	0	2	3	0	0	0	0	f	3	2	0	198	Day 2	Team Serious Players Only	Azorius Omniscience	
7423	1125	10	t	f	1	5	0	2	0	2	0	1	4	5	0	5	10	0	5-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	199	Day 2	Flexslot Diamond	Jund Roots	
7424	1126	10	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	5	3	0	0	7	0	0	0	0	f	3	7	0	200	Day 2		Mono-Black Demons	
7426	1127	10	t	f	2	4	0	2	0	2	0	0	3	5	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	1	3	0	202	Day 2		Izzet Prowess	
7427	1128	10	t	f	1	4	0	2	0	2	0	0	3	6	0	4	10	0	4-10-0	3	4	0	1	5	0	0	0	0	f	3	5	0	203	Day 2	Flexslot Diamond	Jund Roots	
7428	1129	10	t	f	1	4	0	2	0	2	0	0	3	3	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	2	2	0	204	Day 2		Izzet Prowess	
7433	1130	10	t	f	0	6	0	2	0	2	0	2	4	1	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	4	4	0	209	Day 2		Boros Mice	
7436	1132	10	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	212	x		Izzet Prowess	
7438	1133	10	f	f	0	2	1	1	0	0	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	214	x		Domain Overlords	
7439	1134	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	215	x		Dimir Midrange	
7440	1135	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	216	x	Scryhard	Azorius Omniscience	
7442	1136	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	218	x		Orzhov Pixie	
7443	1137	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	219	x		Izzet Prowess	
7444	1138	10	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	220	x		Mono-Red Aggro	
7445	1139	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	221	x		Rakdos Reanimator	
7446	1140	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	222	x	Flexslot Diamond	Jund Roots	
7447	1141	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	223	x	Scryhard	Mono-Red Aggro	
7448	1142	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	224	x	Flexslot Diamond	Jund Roots	
7449	1143	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	225	x	Moriyama Japan	Izzet Prowess	
7451	1144	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	227	x		Azorius Omniscience	
7458	1146	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	234	x		Izzet Prowess	
7459	1147	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	235	x		Izzet Prowess	
7460	1148	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	236	x		Domain Overlords	
7461	1149	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	237	x	Italian Team	Azorius Omniscience	
7462	1150	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	238	x		Domain Overlords	
7464	1151	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	240	x	Flexslot Diamond	Izzet Prowess	
7466	1152	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	242	x	Flexslot Diamond	Izzet Prowess	
7467	1153	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	243	x	Flexslot Diamond	Izzet Prowess	
7472	1154	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	248	x		Izzet Prowess	
7474	1156	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	250	x		Izzet Prowess	
7476	1157	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	252	x		Izzet Prowess	
7478	1158	10	f	f	0	2	0	1	0	1	0	0	2	3	0	2	5	0	2-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	254	x	Sanctum of All	Izzet Prowess	
7481	1159	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	257	x	Rampant Growth Heavy Play	Izzet Prowess	
7482	1160	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	258	x	Team Serious Players Only	Izzet Prowess	
7484	1161	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	260	x		Azorius Control	
7454	220	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	230	x		Izzet Prowess	
7435	422	10	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	211	x		Izzet Prowess	
7486	1162	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	262	x		Mono-Black Midrange	
5862	351	5	t	f	5	1	0	2	2	0	1	0	3	5	2	8	6	2	8-6-2	4	3	1	4	3	1	0	0	0	f	4	3	0	91	Day 2	Worldly Counsel	Amalia Combo	4-3-1 overnight, into contention with a D2 Draft pod win, before back to back losses against Yuta Takahashi and Shota Yasooka ended his interest.
5268	25	5	t	f	2	3	1	2	1	1	0	1	6	3	1	8	6	2	8-6-2	4	4	0	4	2	2	0	0	0	f	4	3	0	92	Day 2	CFB Ultimate Guard	Rakdos Vampires	Excellent four straight Pioneer wins on D1, repairing the damage of an 0-3 Draft. Still in contention after R12 at 7-4-1, but didn't win again until the final round.
7057	966	5	t	f	2	3	1	2	0	1	0	0	6	4	0	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	2	2	0	93	Day 2			Pretty even throughout, never gaining any momentum.
6602	728	5	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	3	1	4	4	0	0	0	0	f	3	2	0	94	Day 2	Sewer Rats	Izzet Phoenix	Needed two wins to advance, fought through to D2, but couldn't progress up the leaderboard.
6750	813	5	t	f	1	5	0	2	0	2	0	1	7	2	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	3	0	95	Day 2	Sanctum of All	Rakdos Midrange	Turned 0-3 around to make D2, and scraped above halfway with a 4-3-1 record there. Never in contention.
5491	155	5	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	6	5	1	96	Day 2			Blazing start, winning Draft trophy, then doubling in Pioneer to reach 6-0. Only won twice more from there.
6123	486	5	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	97	Day 2	Japan 2	Azorius Control	Won his D1 Draft, but four straight losses took him out of contention.
5297	45	5	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	5	0	98	Day 2	Sanctum of All	Rakdos Midrange	Won his opening Draft, but only 4-4 overnight, and soon out of the running.
5544	188	5	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	99	Day 2	Misfits	Enigmatic Fires	Aced his opening Draft, but only 1-4 on D1 Pioneer. Out of contention after R9, finished even at 8-8.
5793	312	5	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	5	1	100	Day 2	Sewer Rats	Izzet Phoenix	At 5-1 things were looking great. Five rounds later, he was done at 5-6, including an 0-3 Draft.
6196	515	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	3	0	101	Day 2	Italians	Izzet Phoenix	Turned 2-2 into 6-2 overnight. Kenta Harane ended his hopes in R12, leaving him to finish out at 8-8.
5398	107	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	102	Day 2	Worldly Counsel	Rakdos Midrange	An excellent 4-1 start was sadly reversed by five straight losses, ending his chances.
5443	125	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	103	Day 2	Worldly Counsel		Got to 5-2, but eliminated before Pioneer on D2.
5243	14	5	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	104	Day 2	Sewer Rats	Rakdos Midrange	3-1 as good as it got, closing D1 at 4-4, and two late defeats by Paul Rietzl and Derrick Davis ensuring no positive record.
5256	19	5	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	105	Day 2			Solid 4-2 in Draft, but 4-6 in Pioneer.
6620	737	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	2	0	106	Day 2	Scoreboard	Rakdos Midrange	Made D2 at 5-3, but soon out of contention.
5941	394	5	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	107	Day 2	CFB Ultimate Guard	Rakdos Vampires	Matching 4-4 records both days, and only 4-6 with the deck of the tournament in Pioneer.
6298	574	5	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	3	0	109	Day 2	Spanish		Solid 4-2 in Draft, but 4-6 in Pioneer.
6802	833	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	110	Day 2	Handshake Ultimate Guard		Even all the way, both formats, both days.
6150	498	5	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	111	Day 2		Omnath to Light	Two days of 4-4 action, but at least had two positive Drafts.
6638	752	5	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	112	Day 2			Still live returning to Pioneer on D2 at 7-4, then lost four straight.
6631	746	5	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	113	Day 2			4-2 in Draft, 4-6 in Pioneer.
6687	776	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	2	1	114	Day 2			Five wins in a row the highlight, but that was from a 1-3 hole.
6994	931	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	115	Day 2		Izzet Ensoul	Always struggling, just made D2, and out of touch before the return to Pioneer.
6269	559	5	t	f	2	4	0	2	1	1	0	1	5	4	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	4	0	116	Day 2			Won first two Draft rounds, but lost the remaining four, so positive Pioneer score not useful.
6661	766	5	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	117	Day 2	French		Excellent 7-3 in Pioneer, but way too much left to do after 1-5 in Draft.
7001	935	5	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	118	Day 2	Sanctum of All	Quintorius Combo	Won twice to reach D2, then 0-3 in Draft ended his chances.
7102	988	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	119	Day 2		Azorius Control	4-4 on both days, even in both formats.
5749	291	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	120	Day 2		Rakdos Midrange	Matching pair of 4-4s, couldn't get anything going.
5713	269	5	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	121	Day 2	Spain		Won four in a row, but still out before the return to Pioneer on D2.
6109	477	5	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	122	Day 2	Sewer Rats		Twice won three in a row, but couldn't overcome 2-4 in Draft.
5528	179	5	t	f	0	5	0	2	0	2	0	1	7	3	0	7	8	0	7-8-0	4	4	0	3	4	0	0	0	0	f	3	3	0	123	Day 2			Won the first three in Pioneer, and finished 7-3 in that format. Not a single Draft victory, however.
6852	865	5	t	f	3	3	0	2	1	1	0	0	4	4	2	7	7	2	7-7-2	5	2	1	2	5	1	0	0	0	f	2	2	0	124	Day 2	Sanctum of All		5-2-1 D1, reversed to 2-5-1 D2.
6826	847	5	t	f	4	2	0	2	2	0	0	0	3	6	1	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	4	3	0	125	Day 2			Lost R1 before four straight wins. Eliminated by Dom Harvey in R11.
6727	800	5	t	f	3	3	0	2	1	1	0	0	4	3	1	7	6	1	7-6-1	5	2	1	2	4	0	0	0	0	f	2	2	0	126	Day 2	Worldly Counsel		Decent 5-2-1 D1, but only a couple of wins on G2.
6463	662	5	t	f	2	3	1	2	1	1	0	1	5	5	0	7	8	1	7-8-1	5	2	1	2	6	0	0	0	0	f	3	4	0	127	Day 2	Moriyama Japan		5-2-1 D1, but 2-6 D2.
6519	688	5	t	f	4	2	0	2	1	1	1	0	3	6	1	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	3	2	0	128	Day 2	Misfits		Trophy in Draft 1, but only three Pioneer wins.
6430	644	5	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	6	0	129	Day 2	Italians	Rakdos Midrange	Another perfect Draft start, but from 6-2 a reversal in Draft of 0-3 ended his hopes before D2 Pioneer.
6662	767	5	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	6	0	130	Day 2			Opened with a Draft trophy, but went through six straight losses mid-tournament.
5229	8	5	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	2	3	0	131	Day 2		Lotus Field Combo	Comfortably advanced to D2, but only 2-6 there.
6296	572	5	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	132	Day 2			Broke even in Draft, but 4-6 in Pioneer.
6025	436	5	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	7	1	133	Day 2			From 0-1 won five straight, before losing seven on the bounce.
5866	353	5	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	134	Day 2	Moriyama Japan		Best placed when 3-1. Fell back to 4-4, then 3-5 D2.
5360	84	5	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	5	0	135	Day 2			Won four straight to reach 4-1, and was 5-3 overnight, before a 2-6 D2.
7077	975	5	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	136	Day 2	CFB Ultimate Guard	Rakdos Vampires	4-4 D1, and a poor D2 that began with an 0-3 Draft.
5417	115	5	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	137	Day 2	Scoreboard		Started out 4-1, but slipped to 4-4 overnight, then 3-5 D2.
6689	778	5	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	4	0	138	Day 2	French		Won four straight, but nothing after R12.
7196	1030	5	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	139	Day 2	Worldly Counsel	Lotus Field Combo	5-3 overnight, a terrible D2 Draft ended contention at 5-6.
6362	604	5	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	140	Day 2	Channel Fireball	Amalia Combo	Advanced with the minimum 4-4, only 3-5 D2.
7115	996	5	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	141	Day 2	Belfatto Kurz Parson Wienburg		Even record in Draft, 4-6 in Pioneer.
6237	537	5	t	f	2	4	0	2	1	1	0	1	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	5	0	142	Day 2			Even D1, but only two wins D2.
7126	1000	5	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	143	Day 2			Even in Pioneer, but 2-4 in Draft.
6458	661	5	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	5	0	144	Day 2	Moriyama Japan	Azorius Control	A horrible Draft 0-3 to start, but still made D2. Draft, this time 1-2, was more than enough to eliminate him.
5325	64	5	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	4	0	145	Day 2			Great effort to reach D2, winning three in a row to make it. 3-5 D2.
7067	971	5	t	f	3	3	0	2	1	1	1	1	2	6	1	5	9	1	5-9-1	4	3	1	1	6	0	0	0	0	f	4	5	0	146	Day 2	Savvidis Volakis		Trophy in Draft, and 4-0, but only a single win on D2.
6484	672	5	t	f	2	3	1	2	0	1	0	0	4	6	0	6	9	1	6-9-1	4	4	0	2	5	1	0	0	0	f	2	4	0	147	Day 2	Tenacious Underdogs		Even D1, then 2-5-1 D2.
5741	285	5	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	3	6	0	148	Day 2	Scoreboard		Got to 3-1 and 5-3, then just a lone win on D2.
6241	539	5	t	f	3	3	0	2	1	1	1	1	2	7	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	4	9	0	149	Day 2			Draft trophy and 4-0, but only one win on D2.
5496	159	5	t	f	4	2	0	2	1	1	1	0	2	8	0	6	10	0	6-10-0	5	3	0	1	7	0	0	0	0	f	3	5	0	150	Day 2			Draft trophy D1, 5-3 overnight, but horrible 1-7 D2.
6413	638	5	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	5	3	0	1	5	0	0	0	0	f	2	3	0	151	Day 2	Portugese+Brazilians		5-3 overnight, but just one win on D2.
5888	362	5	t	f	2	4	0	2	0	2	0	0	4	5	0	6	9	0	6-9-0	4	4	0	2	5	0	0	0	0	f	2	3	0	152	Day 2			2-4 in Draft the main culprit.
7489	1164	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	265	x		Izzet Prowess	
7490	1165	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	266	x	Flexslot Diamond	Jund Roots	
7504	1174	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	280	x		Golgari Graveyard	
7511	1180	10	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	287	x	Italian Team	Gruul Delirium	
7512	1181	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	288	x	Sanctum of All	Mono-Red Aggro	
7513	1182	10	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	6	0	0	0	0	0	0	0	f	1	2	0	289	x		Izzet Prowess	
7515	1183	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	291	x		Izzet Prowess	
7516	1184	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	292	x		Azorius Omniscience	
7519	1185	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	295	x		Izzet Prowess	
7537	1200	10	f	f	0	2	0	1	0	1	0	0	0	3	0	0	5	0	0-5-0	1	5	0	0	0	0	0	0	0	f	0	3	0	313	x	Scryhard	Domain Overlords	
7538	1201	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	314	x		Izzet Prowess	
7539	1202	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	315	x		Mono-Red Aggro	
7540	1203	10	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	316	x		Gruul Aggro	
7541	1204	10	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	317	x	Team Serious Players Only	Azorius Omniscience	
7542	1205	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	318	x		Izzet Prowess	
7544	1206	10	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	320	x		Mono-Red Aggro	
7545	1207	10	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	5	0	321	x		Jund Midrange	
7547	1208	10	f	f	0	3	0	1	0	1	0	1	1	4	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	7	0	323	x		Izzet Prowess	
7548	1209	10	f	f	1	2	0	1	0	1	0	0	0	5	0	1	7	0	1-7-0	1	7	0	0	0	0	0	0	0	f	1	6	0	324	x		Azorius Omniscience	
5760	297	5	t	f	4	2	0	2	2	0	0	0	2	8	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	153	Day 2			Got to 3-1, but only two wins in Pioneer from ten.
6260	553	5	t	f	1	5	0	2	0	2	0	1	4	5	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	4	0	154	Day 2	Temple of Malady		Even D1, then 1-6 D2.
6208	517	5	t	f	1	5	0	2	0	2	0	1	5	5	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	155	Day 2	Handshake Ultimate Guard		Won twice to reach D2, then 2-6 once there.
6444	653	5	t	f	3	3	0	2	1	1	0	0	2	7	1	5	10	1	5-10-1	4	4	0	1	6	1	0	0	0	f	3	3	0	156	Day 2	Japan 2		Got to 3-1 and 5-3, then only one win on D2.
6575	712	5	t	f	2	4	0	2	0	2	0	0	3	4	1	5	8	1	5-8-1	4	3	1	1	5	0	0	0	0	f	2	3	0	157	Day 2	CFB Ultimate Guard		Made D2 with a round to spare, but only won once on D2.
5858	350	5	t	f	1	5	0	2	0	2	0	1	4	5	1	5	10	1	5-10-1	5	3	0	0	7	1	0	0	0	f	2	6	0	158	Day 2			Solid 5-3 D1, didn't win a match D2.
6065	452	5	t	f	3	3	0	2	1	1	0	0	2	6	0	5	9	0	5-9-0	4	4	0	1	5	0	0	0	0	f	2	4	0	159	Day 2	Moriyama Japan		3-1 the highlight. Only one win D2.
5700	263	5	f	f	2	1	0	1	1	0	0	0	1	2	2	3	3	2	3-3-2	3	3	2	0	0	0	0	0	0	f	2	1	0	160	X			Two costly draws meant no D2.
6133	491	5	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	161	X	Japan 2	Rakdos Midrange	2-1 in Draft, but only a single Pioneer win. Out on D1.
5623	220	5	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	3	3	0	162	X	Scoreboard		Won three straight, but an unlikely Draft draw meant no D2.
6020	433	5	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	163	X	Worldly Counsel		Opened 2-0, but only one win from there.
5711	267	5	f	f	0	2	1	1	0	1	0	0	3	2	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	164	X			3-2 in Pioneer, but couldn't win at all in Draft.
5378	98	5	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	1	0	165	X	Handshake		A Pioneer draw proved costly. No D2.
7039	956	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	166	X	Italians	Rakdos Midrange	2-0 to start, but only one more win, so no D2.
5646	233	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	167	X	Misfits		Opened 2-0, but couldn't advance.
6893	885	5	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	168	X	CFB Ultimate Guard		Had a tough schedule (Christoffer Larsen, Javibier Dominguez, Logan Nettles) and didn't reach D2.
6710	793	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	169	X	Ferguson Rolph Rose Smith		Went from 3-1 to 3-5. Ouch.
5415	113	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	171	X			Got to 3-2, but lost the last three.
5699	262	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	172	X	Spain		Alternated losses and wins until needed a win in R8 and didn't get it.
6507	681	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	173	X	Handshake Ultimate Guard		Needed three wins from 1-4 to advance, eliminated by Chris Ferber in R8.
6582	719	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	174	X	French		Lost the last two from 3-3 to miss D2.
6734	806	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	175	X			3-2, then three straight losses.
5361	85	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	177	X			Opened 2-0 but couldn't reach D2.
7061	968	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	178	X	Italians	Rakdos Sacrifice	Under the gun at 1-3, and couldn't make it out of D1.
7093	983	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	179	X			2-1 in Draft, but only one win in Pioneer.
5317	59	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	181	X			Opened 2-0, but couldn't advance.
6934	902	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	182	X	Worldly Counsel		Fought back from 1-4, but lost the final elimination match in R8.
7034	954	5	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	183	X			2-1 in Draft, just one win in Pioneer.
6690	779	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	184	X			Lost the R8 elimination match.
5335	71	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	185	X	Boston		Couldn't come back from a 1-4 start.
7186	1024	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	186	X	Japan 2		Lost the R8 elimination match to Rob Wagner Krankel.
5444	126	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	187	X			Needed three straight wins to advance, only got two of them.
5357	82	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	188	X			0-2, 3-2, 3-5, no D2.
5985	414	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	189	X			Came back from 0-3 to 3-3, then lost both chances to advance.
6913	896	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	190	X	Scoreboard	Boros Heroic	Fought back from 0-3 in Draft to 3-3, but lost his last two.
6113	481	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	4	0	191	X			Eliminated in R7.
6328	589	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	192	X	Moriyama Japan	Boros Heroic	Yet another 0-3 Draft, and this time it cost him a D2 place.
5515	174	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	193	X		Lotus Field Combo	Needed three straight to make D2. Got two of them, but lost R8.
6733	805	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	194	X			Alternated losses and wins until R8, finished 3-5 and out.
5377	97	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	195	X			Lost the elimination match in R8.
6982	926	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	196	X	Sewer Rats		From 2-2 to 2-5 and out.
6901	890	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	197	X	Worldly Counsel		0-3 in Draft, 3-2 in Pioneer wasn't enough.
6949	909	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	198	X			Lost to Jim Davis in R8 elimination match.
6047	447	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	199	X	Worldly Counsel	Izzet Phoenix	At 1-4, needed three straight wins. Only got two of them.
5312	56	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	200	X			Out at 1-5 before winning the last two.
6636	750	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	201	X			Won three straight, but that was all.
6873	877	5	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	202	X	CFB Ultimate Guard		Out at the earliest opportunity before winning a couple late.
5889	363	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	203	X			0-5, but at least won the last three.
6706	790	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	204	X			Won three of the last four, but from a near-impossible 0-4 hole.
6782	824	5	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	205	X	Canadians		3-2 in Pioneer, but out because of an 0-3 Draft.
5408	109	5	f	f	0	3	0	1	0	1	0	1	2	1	2	2	4	2	2-4-2	2	4	2	0	0	0	0	0	0	f	1	3	0	206	X	Italy	Niv to Light	Couldn't recover from an 0-3 Draft bomb, and two Pioneer draws didn't help his cause. No D2.
6242	540	5	f	f	1	2	0	1	0	1	0	0	1	1	2	2	3	2	2-3-2	2	3	2	0	0	0	0	0	0	f	1	2	0	207	X	Sewer Rats		Two Pioneer draws, and out as a result.
5605	216	5	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	2	0	208	X			One win in each format.
6102	471	5	f	f	1	2	0	1	0	1	0	0	1	2	1	2	4	1	2-4-1	2	4	1	0	0	0	0	0	0	f	1	2	0	209	X			Won R1, but that was the high spot.
6312	580	5	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	210	X	Italians		One win in each format.
6851	864	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	211	X	Coalition Victory		Won R1, and the opening round of Pioneer, but that was all.
6010	428	5	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	212	X		Lotus Field Combo	2-1 in Draft, but couldn't get a single win in Pioneer. No D2.
6348	598	5	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	213	X	French	Azorius Control	2-1 in Draft, but no wins in Pioneer, so no D2.
6762	816	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	214	X	Handshake	Amalia Combo	Only one win in each format, not enough for D2.
6398	626	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	215	X	Sewer Rats		One win in each format.
6882	879	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	216	X			Won R1, but only one more.
5953	398	5	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	217	X	Moriyama Japan	Lotus Field Combo	2-1 coming out of draft, but couldn't buy a win in Pioneer.
6645	757	5	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	218	X	Blesso Bogue Pyka		2-1 in Draft, but no wins in Pioneer.
6319	586	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	219	X			Eliminated in R7.
5283	35	7	f	f	2	0	1	1	1	0	0	0	1	4	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	4	0	151	X			
5285	37	9	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	87	Day 2	Team Bus Stop	Domain Overlords	
5287	38	7	t	f	3	3	0	2	1	1	0	0	2	5	0	5	8	0	5-8-0	4	4	0	1	4	0	0	0	0	f	1	3	0	144	Day 2			
5288	39	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	55	Day 2		Esper Pixie	
5289	39	8	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	3	0	42	Day 2			
7300	39	10	t	f	2	3	1	2	0	1	0	0	7	3	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	4	2	0	76	Day 2		Izzet Prowess	
7518	40	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	294	x		Orzhov Pixie	
6865	874	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	220	X			Eliminated in R7.
6251	548	5	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	221	X	Worldly Counsel		0-3 Draft too much to overcome.
5817	329	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	222	X	Misfits		Out after R7, one win in each format.
6308	576	5	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	223	X	CFB Ultimate Guard		0-3 Draft left too much to do.
5455	134	5	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	224	X			Just one win.
5632	227	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	225	X			Got to 2-2, then lost three straight.
5839	344	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	226	X	Sewer Rats		One win in each format.
5912	376	5	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	227	X			2-0 start, didn't win again.
6731	803	5	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	229	X	Moriyama Japan		2-1 in beloved Draft, but no Pioneer wins.
5404	108	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	230	X			From 2-3 to 2-6.
5764	301	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	231	X	Boston		Out after R7, one win in each format.
5867	354	5	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	232	X			Both wins came in Pioneer.
5318	60	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	233	X			Won R1, fell to 1-4, couldn't advance.
6006	426	5	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	234	X			Still live at 2-4, lost the last two.
6951	911	5	f	f	0	2	1	1	0	1	0	0	1	3	1	1	5	2	1-5-2	1	5	2	0	0	0	0	0	0	f	1	2	0	236	X			Just one win, in Pioneer.
7024	946	5	f	f	0	3	0	1	0	1	0	1	1	2	1	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	3	0	238	X	Sanctum of All		Lone win came in the Pioneer opener.
6632	747	5	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	239	X	Sanctum of All		Already 0-4 when getting a lone win.
6609	732	5	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	240	X	Coalition Victory		1-1 became 1-5.
6313	581	5	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	241	X	Italy		1-1 into 1-5 and out.
5526	177	5	f	f	1	2	0	1	0	1	0	0	0	1	0	1	3	0	1-3-0	1	3	0	0	0	0	0	0	0	f	1	2	0	242	X		Lotus Field Combo	Just a single Draft win, dropping early in Pioneer.
7084	978	5	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	243	X	French		Won R1, but only R1.
5679	250	5	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	244	X			Zero wins in Pioneer, lone win in Draft.
5413	112	5	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	246	X	Italy		1-1, then five straight losses.
6848	861	5	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	247	X	Scoreboard		Didnt' win a game in Draft, lone win in Pioneer.
5365	89	5	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	248	X			Didn't win until R5, out after R6.
5385	100	5	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	249	X	Sanctum of All	Izzet Phoenix	0-3 in Ltd, and only one win in Pioneer, somehow worse than a year earlier, also with Pioneer. Out after R5.
6494	677	5	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	250	X	Sanctum of All		One win in Draft, none in Pioneer, out after R6.
6441	651	5	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	251	X	Misfits		Lone win in Pioneer, R5.
6736	808	5	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	252	X			0-5 and done, with two game wins.
7085	979	5	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	253	X	Guillotine		No match wins, one game win, done at 0-5.
5827	336	5	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	254	X			0-5 and out, with two game wins.
6595	725	5	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	255	X			Out at 0-5, with two game wins.
6067	454	5	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	256	X			No match wins, one game win, out at 0-5.
5562	194	5	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	257	X			Won three games, but abandoned at 0-6.
5958	401	6	t	t	5	1	0	2	2	0	1	0	10	0	0	15	1	0	15-1-0	8	0	0	4	1	0	3	0	0	t	9	1	1	1	Champion	Moriyama Japan	Domain Ramp	One of the greatest single tournaments of all time. 3-0 Draft. 5-0 Standard. A single loss to Javier Dominguez D2 Draft. Three more Standard wins, making T8 with three rounds to spare. QFs Sean Goddard. SFs Arne Huschenbeth. Final Yuta Takahashi. 15-1 overall, Champion.
6926	900	6	t	t	4	2	0	2	2	0	0	0	9	1	2	13	3	2	13-3-2	5	2	1	6	0	1	2	1	0	t	4	2	0	2	Finals	Moriyama Japan	Azorius Control	5-1 was a great start, and, after a R9 loss, he didn't lose again on D2. Beat Rei Zhang and Takumi Matsuura in T8, before losing to Yoshihiko Ikawa in the Finals.
6329	589	6	t	t	5	1	0	2	2	0	1	0	8	3	0	13	4	0	13-4-0	6	2	0	6	1	0	1	1	0	t	9	1	1	3	Semifinals	Moriyama Japan	Boros Convoke	A nine win streak was the centerpiece of his run to T8, and this time Draft didn't get in the way, with an excellent 5-1 Limited record. Edged out Jason Ye in the QFs, but couldn't get past Yuta Takahashi in the Semis.
5942	394	6	t	t	6	0	0	2	2	0	2	0	7	5	0	13	5	0	13-5-0	6	2	0	6	2	0	1	1	0	t	6	2	1	4	Semifinals	CFB Ultimate Guard	Esper Midrange	Paced the field at 6-0, so disappointing to end D1 6-2. Back on track with Draft pod win D2, then fought an absurd slate of opponents in Standard, beating Javier Dominguez in R16 to reach the T8. He beat Lucas Duchow in the QFs, before Yoshihko Ikawa beat him for the second time in the competition, this time in the SFs.
7209	1036	6	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	7	1	0	5	2	0	0	1	0	t	4	1	0	5	Top 8	Sanctum of All	Four-Color Legends	Perfect 3-0 Draft to start, 7-1 overnight, and another positive Draft to start D2 2-1. Three straight wins down the stretch in Standard took him to the T8. There, he lost to Yuta Takahashi in the QFs.
5629	226	6	t	t	4	2	0	2	1	1	1	0	8	3	0	12	5	0	12-5-0	7	1	0	5	3	0	0	1	0	t	7	3	1	6	Top 8	Temple of Malady		Terrific start, opening 7-0. Came back to the field at 7-3, befoe securing T8 with a round to spare. Lost 3-1 to Arne Huschenbeth in the QFs.
7177	1020	6	t	t	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	1	1	5	3	\N	0	1	0	t	4	2	0	7	Top 8	Sanctum of All	Four-Color Legends	3-0 Draft start, 6-1-1 D1, a small Draft wobble D2, before four straight Standard wins to reach T8. Lost the deciding game to Takumi Matsuura in the QFs.
5784	310	6	t	t	4	2	0	2	1	1	1	0	7	2	1	11	4	1	11-4-1	4	3	1	7	0	0	0	1	0	t	9	3	1	8	Top 8	Worldly Counsel	Temur Analyst	At 2-3-1 things looked bleak. He didn't lose again in the Swiss, winning nine on the bounce and reaching the T8. There, Yoshihiko Ikawa edged the deciding game to eliminate him in the QFs.
5611	217	6	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	9	3	1	10	Top 16	Handshake Ultimate Guard	Esper Midrange	Another huge win streak, this time nine rounds in a row. Another agonizing near miss, with Arne Huschenbeth the victor in their final round win-and-in.
6983	927	6	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	1	0	11	Top 16			Won six of seven, and played for a possible T8 slot in the final round, losing to Lucas Duchow.
6423	643	6	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	4	2	0	12	Top 16	Moriyama Japan	Esper Midrange	Won his Draft pod D1, ending at 6-2. 1-2 in Draft on D2 left him on the brink. Once again, a strong finish, winning his last four this time, wasn't enough.
5661	239	6	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	5	2	1	13	Top 16	Coalition Victory	Esper Midrange	Backed up his excellence from last time. Only just in contention at 5-4, won six of his last seven, with Lucas Duchow finally stopping him in R15.
6763	816	6	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	7	2	1	14	Top 16	Handshake	Esper Midrange	Only 4-3, before a seven win streak took him to the verge of T8. Lost his last two to just miss out.
6085	466	6	t	f	3	3	0	2	1	1	0	0	7	0	3	10	3	3	10-3-3	4	2	2	6	1	1	0	0	0	f	4	1	0	15	Top 16			Three costly draws took him out of contention, but winning the last four was more than enough to requalify.
7172	1019	6	t	f	5	1	0	2	2	0	1	0	5	3	2	10	4	2	10-4-2	4	2	2	6	2	0	0	0	0	f	3	2	0	16	Top 16		Azorius Control	Won opening Draft, and had two more three win streaks. Two D1 draws were costly, however.
6376	612	6	t	f	6	0	0	2	2	0	2	0	4	5	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	t	5	2	1	17	Top 32	Scoreboard		Perfection in Draft, but only 4-5-1 in Standard. Still enough to requalify.
5230	8	6	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	f	6	2	1	18	Top 32	Scoreboard	Orzhov Bronco	Lost R1, and, despite a R8 draw, didn't lose again until R11, more than a day later. Sean Goddard and Yuta Takahashi handed him defeats in R14 and 15, so no T8, but a good performance.
5574	200	6	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	t	3	1	0	19	Top 32	Worldly Counsel	Temur Analyst	Just like MKM, 7-4 heading into D2 Standard, again three more wins to 10-4 before a R15 elimination, this time to Sean Goddard.
7008	937	6	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	4	2	0	20	Top 32			Run of four, run of three, run of two, and a singleton made up ten wins. Just not quite enough to be in the T8 mix.
5735	282	6	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	f	4	1	0	21	Top 32	Coalition Victory	Temur Analyst	5-1 in Draft, but not quite even in Standard, so no T8.
6061	451	6	t	f	5	1	0	2	2	0	1	0	5	4	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	t	4	2	0	22	Top 32	Handshake Ultimate Guard	Esper Midrange	Well in contention off the back of 5-1 in Draft, eliminated from contention by Nicole Tipple in R15.
5656	238	6	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	6	2	0	4	3	0	0	0	0	f	3	2	0	24	Top 32	Worldly Counsel	Boros Convoke	Nicely in contention heading back to Standard on D2, but losses to Eli Kassis and Marco Del Pivo ended his run.
5554	189	6	t	f	5	1	0	2	2	0	1	0	5	4	1	10	5	1	10-5-1	4	3	1	6	2	0	0	0	0	f	3	3	0	25	Top 32	CFB Ultimate Guard	Esper Midrange	An opening Draft 3-0 was squandered with just a single Standard win. Had an impressive 6-2 D2, but the damage was done.
5461	137	6	t	f	4	2	0	2	2	0	0	0	6	3	1	10	5	1	10-5-1	5	3	0	5	2	1	0	0	0	f	3	1	0	26	Top 32	Worldly Counsel	Esper Midrange	5-3 D1, and still alive at  9-4, before Nicole Tupple got in the way of back to back T8s.
5973	406	6	t	f	3	3	0	2	1	1	0	0	7	2	1	10	5	1	10-5-1	5	3	0	5	2	1	0	0	0	f	5	2	1	28	Top 32	Moriyama Japan	Boros Convoke	5-3 D1, and five straight to finish D2, but by then was already out of the running.
6188	514	6	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	2	0	29	Top 32	Bus Stop	Esper Midrange	Perfect Draft start, 6-2 overnight, and it was Seth Manfield who took him out of contention again, this time in R13.
6940	903	6	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	30	Top 32	Misfits	Domain Control	4-4 overnight. Won his D2 Draft, still alive at 8-4, before Nicole Tipple handed him the crucial fifth loss.
6597	727	6	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	3	0	31	Top 32			Out of contention returning to Standard on D2, but won four of the last five.
6680	774	6	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	2	0	32	Top 32	Sanctum of All	Four-Color Legends	Four straight wins was the highlight of a solid performance, but 7-3 led to 10-6, so no T8.
6741	811	6	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	33	Day 2	Spain	Azorius Artifacts	Kept winning multiple rounds without ever putting together a sizeable run. 4-1 in Standard on D2 the highlight, but already out of contention by then.
5765	302	6	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	34	Day 2	Italians		Solid across both formats, but out of contention after R9.
7216	1040	6	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	35	Day 2	Sewer Rats		From 1-4 and the brink of elimination, won nine of the next ten, outstanding. Enough to requalify.
6014	430	6	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	36	Day 2	Sanctum of All		Strong 7-3 in Standard, but only parity at 3-3 in Draft.
6044	446	6	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	3	1	37	Day 2		Mono-Red Aggro	1-2, but then winning runs of five and three kept him interested. 2-3 in Standard on D2 saw him fade.
7134	1007	6	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	38	Day 2	Coalition Victory		Excellent 5-1 in Draft, but only 5-5 in Standard.
6657	765	6	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	4	2	0	39	Day 2	Guillotine	Esper Midrange	1-3, but managed to make D2. Won his last four this time to end 10-6, but was never in the running.
5842	346	6	t	f	2	4	0	2	1	1	0	1	8	2	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	4	1	41	Day 2	Handshake Ultimate Guard	Esper Midrange	The deepest of holes at 0-4, knuckled down to make D2, and then 6-2 D2, long after T8 hopes were gone.
6162	502	6	t	f	3	3	0	2	1	1	0	0	6	2	2	9	5	2	9-5-2	5	2	1	4	3	1	0	0	0	f	2	2	0	42	Day 2	Handshake Ultimate Guard	Esper Midrange	2-2 no disgrace, given the losses were to Javier Dominguez and Nathan Steuer. 5-2-1 overnight, before 1-2 Draft D2 took him out of the running.
6880	1119	6	t	f	4	2	0	2	2	0	0	0	5	4	1	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	4	3	0	43	Day 2		Azorius Control	A glimpse of the Stark of Ago, opening 6-2 D1, and still in the mix down the stretch, before Arne Huschenbeth beat him twice on D2 to take him out of contention.
5638	228	6	t	f	4	2	0	2	2	0	0	0	5	4	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	3	3	0	44	Day 2	CFB Ultimate Guard	Golgari Midrange	Strong 6-1-1 D1, but three straight Standard losses ended his contention.
7197	1030	6	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	7	1	0	2	6	0	0	0	0	f	5	4	1	45	Day 2	Worldly Counsel	Temur Analyst	A great 5-0 start into 7-1 D1. D2 was not easy, however, losing his last four to go 2-6 on the day.
5308	52	7	f	f	0	2	1	1	0	1	0	0	2	2	1	2	4	2	2-4-2	2	4	2	0	0	0	0	0	0	f	1	2	0	195	X	Italians		
7441	101	10	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	217	x	Flexslot Diamond	Jund Roots	
6725	798	6	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	46	Day 2	Worldly Counsel		Trophy in Draft on D1, and won four of five in Standard on D2. Not much in between.
6496	678	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	4	0	47	Day 2			Decent 6-2 D1, but 3-5 D2.
6459	661	6	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	3	0	48	Day 2	Moriyama Japan	Temur Analyst	Perfect 3-0 in Draft to start, and still alive at 9-4 before Eli Kassis took him out in R14.
6490	674	6	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	4	0	49	Day 2			Trophy in Draft D1, repeated on D2, tremendous. Unfortunately, 3-7 in Standard.
5343	76	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	2	1	50	Day 2		Boros Prowess	3-1 became 3-3, but then five straight put him in the mix again. A single win back in Standard left him well out of contention.
6178	511	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	51	Day 2			Decent 7-3 in Standard, but a losing record in Draft at 2-4.
6831	851	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	52	Day 2	Channel Fireball		From 2-3 won four straight, but out of contention by the return to Standard on D2.
5954	398	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	53	Day 2	Moriyama Japan	Temur Analyst	5-2 overnight, but already out of contention when he rattled off three wins to finish.
6869	876	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	54	Day 2	CFB Ultimate Guard	Golgari Midrange	5-3 D1, but a trio of losses on D2 took him out of contention.
5901	371	6	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	55	Day 2	Sewer Rats	Mono-Red Aggro	Another 3-0 Draft to start, and two more Draft wins on D2. Functionally out after R13.
6479	669	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	56	Day 2	CFB Ultimate Guard	Azorius Control	Barely into D2 at 4-4, then 5-3 on D2.
5386	100	6	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	2	2	0	57	Day 2	Sanctum of All	Four-Color Legends	4-4 overnight, and out of contention at 5-5. Lost to MOM Semifinal opponent Claire Rianhard again in R15.
5545	188	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	58	Day 2	Misfits	Rakdos Aggro	From 0-2 to 5-3 was a solid D1, but another 1-2 Draft on D2 eliminated him from contention.
6564	710	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	59	Day 2	Sewer Rats		4-4 overnight, then a decent 5-3 on D2.
6304	575	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	6	3	1	60	Day 2	CFB Ultimate Guard	Azorius Control	Turned 0-2 around in a hurry, ending D1 at 6-2. A 1-2 Draft on D2 didn't help, but it took Simon Nielsen in R14 to eliminate him from contention.
6011	428	6	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	7	3	1	61	Day 2	Coalition Victory	Esper Midrange	Went on a necessary tear from 2-4, right up to 9-4, before Greg Michel eliminated him from contention in R14.
5690	257	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	62	Day 2	Italians	Domain Ramp	0-2 again, again made D2. Again three defeats took him out of contention, and again he won three of his last four.
5430	121	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	63	Day 2	Worldly Counsel	Temur Analyst	Four wins to end D1 were needed after a 1-3 start. Never in contention, finishing 9-7.
6031	439	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	64	Day 2	CFB Ultimate Guard	Esper Midrange	Deep trouble at 1-4, so credit for making D2. Also credit for 5-3 D2, but never in the mix.
7145	1010	6	t	f	3	3	0	2	1	1	1	1	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	7	4	1	65	Day 2	Misfits	Temur Analyst	Absolutely on the edge at 0-4, somehow ran off seven straight, including a 3-0 Draft sweep to start D2. Not in the mix soon after, but still a great run.
6955	914	6	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	66	Day 2	Worldly Counsel	Temur Analyst	Won R7 and 8 to reach D2, soon out of the reckoning, but did win his last three.
6247	545	6	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	67	Day 2			Disappointing 2-4 in Draft, much better 7-3 in Standard.
5853	349	6	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	68	Day 2	Moriyama Japan	Esper Midrange	0-3 in Draft, but still scraped into D2, before another sub-par Draft eliminated him.
6000	423	6	t	f	4	2	0	2	2	0	0	0	4	4	2	8	6	2	8-6-2	6	2	0	2	4	2	0	0	0	f	4	3	0	69	Day 2		Dimir Midrange	Streaks of four and three wins kept him in the mix, until two Standard draws on D2 cost him too many points.
6968	920	6	t	f	5	1	0	2	2	0	1	0	3	5	2	8	6	2	8-6-2	4	2	2	4	4	0	0	0	0	f	4	2	0	71	Day 2	Worldly Counsel	Esper Midrange	Draft 3-0 to start, but two Draws weren't good. 4-4 D2 saw him finish mid-pack.
6238	538	6	t	f	3	2	1	2	1	0	0	0	5	4	1	8	6	2	8-6-2	4	3	1	4	3	1	0	0	0	f	4	2	0	72	Day 2			Four straight wins on D2, but matching 4-3-1 results.
7078	975	6	t	f	3	3	0	2	1	1	0	0	5	3	2	8	6	2	8-6-2	4	3	1	4	3	1	0	0	0	f	3	2	0	73	Day 2	CFB Ultimate Guard	Esper Midrange	In ok shape at 4-2 after three straight wins, but nothing developed from there.
6894	885	6	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	3	0	74	Day 2			Solid 4-2 in Draft, 2-1 both times, but underwhelming in Standard.
5284	36	6	t	f	4	2	0	2	2	0	0	0	4	5	1	8	7	1	8-7-1	5	3	0	3	4	1	0	0	0	f	3	3	0	75	Day 2	Temple of Malady		5-3 D1, 3-5 D2. Let down by Standard.
6534	696	6	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	4	4	0	77	Day 2	Scoreboard	Jund Analyst	4-1 and 6-2 fell apart at 6-6, before finishing 8-8.
5893	365	6	t	f	2	4	0	2	0	2	0	0	6	3	0	8	7	0	8-7-0	6	2	0	2	5	0	0	0	0	f	5	2	1	78	Day 2			Five straight wins to end D1 in good shape at 6-2, but a 2-5 reversal on D2.
5244	14	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	5	1	79	Day 2	Sewer Rats	Domain Ramp	The plus? Five straight wins rounds 7-11. The minus? 8-3 turned into 8-8, with Analyst decks accounting for the last three.
7002	935	6	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	3	0	80	Day 2		Mono-Red Aggro	Still alive at 7-4, but only won once back in Standard on D2.
5279	32	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	81	Day 2	Sanctum of All		Draft trophy on D2 the highlight, but 4-6 in Standard.
5968	403	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	4	0	82	Day 2	Handshake Ultimate Guard	Esper Midrange	4-0 start, but only 5-3 by the end of D1. Four losses early on D2 to end any chance.
7062	968	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	3	0	83	Day 2	Italy	Boros Convoke	Perfect 3-0 Draft, then 5-3, but only 1-2 in the second Draft, taking him out of the reckoning.
6666	768	6	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	5	0	84	Day 2			Got to 4-1 but lost five straight on D2.
6817	839	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	85	Day 2	Japan 2		4-4 both days, never better than one match over parity.
5877	358	6	t	f	4	2	0	2	1	1	1	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	86	Day 2		Dimir Control	Perfect 3-0 Draft to start, 5-3 overnight, but only 3-5 on D2.
6204	516	6	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	87	Day 2	Handshake	Esper Midrange	Middle of the pack throught, although 4-2 in Draft was solid.
6048	447	6	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	5	5	1	88	Day 2		Temur Analyst	A swingy 8-8, with runs of five wins and three accounting for all eight, with plenty of famine in between.
5794	312	6	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	4	0	89	Day 2	Temple of Malady	Domain Ramp	5-3 overnight, but another D2 0-3 Draft eliminated him from contention.
5560	192	6	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	4	0	90	Day 2	Italians		Fair 6-4 in Standard, disapppointing 2-4 in Draft, including 0-3 on D2.
6562	709	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	91	Day 2	Sewer Rats	Domain Ramp	A nice 4-2 start, but then 4-4, and a matching 4-4 on D2.
6097	469	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	92	Day 2	Bus Stop	Esper Midrange	A pair of 4-4s, but never in the mix.
5923	384	6	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	6	2	0	2	6	0	0	0	0	f	6	3	1	93	Day 2			Started 0-2 before winning six straight. Same start to D2, before winning two more all day.
6116	484	6	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	94	Day 2			Trophy in Draft D1, 5-1 overall, but 3-7 in Standard.
6151	498	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	5	0	95	Day 2		Gruul Aggro	4-1 was as good as it got, with five straight losses comfortably eliminating him from contention.
6825	846	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	96	Day 2			Even splits both formats, both days.
5399	107	6	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	97	Day 2	Worldly Counsel	Temur Analyst	Scraped into D2 with a R8 victory over Adriano Moscato, and was quickly out of contention.
5298	45	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	98	Day 2	Killers Among Us	Domain Ramp	4-4 again, and no big push materialized.
7132	1005	6	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	2	0	99	Day 2			Never more than one round above parity, ended even.
6134	491	6	t	f	5	1	0	2	2	0	1	0	3	5	2	8	6	2	8-6-2	5	1	2	3	5	0	0	0	0	f	3	5	0	100	Day 2	Iteration	Temur Analyst	Perfect 3-0 Draft to start, two Standard draws didn't help. Strange but excellent 7-1-2 record, before a horrible run of five straight defeats.
6961	918	6	t	f	2	3	1	2	1	1	0	0	5	4	1	7	7	2	7-7-2	5	2	1	2	5	1	0	0	0	f	2	3	0	101	Day 2			Did a lot of not losing in getting to R10, but two were draws at 5-2-2. Went 2-5 from there.
6520	689	6	t	f	3	3	0	2	1	1	1	1	4	5	1	7	8	1	7-8-1	6	1	1	1	7	0	0	0	0	f	3	4	0	102	Day 2			Trophy in Draft D1, reversed on D2.
6321	587	6	t	f	2	3	1	2	0	1	0	0	5	5	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	3	2	0	103	Day 2	Worldly Counsel		Won twice in must-wins to reach D2, 3-5 once there.
5618	218	6	t	f	4	2	0	2	1	1	1	0	3	6	1	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	3	3	0	104	Day 2	Coalition Victory	Esper Midrange	Won his D1 Draft pod, but couldn't kick on. 3-5 on D2.
5591	206	6	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	5	5	1	105	Day 2	Misfits		Won all five in Standard D1, but 2-6 on D2.
7055	964	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	106	Day 2			Advanced to D2 with a round to spare, then 3-5.
6539	697	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	3	0	107	Day 2		Mono-Red Aggro	Got to 3-1 and 5-2 before falling away.
5490	154	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	108	Day 2	Misfits		Through to D2 in R7, 4-4 overnight, then 3-5 D2.
6571	711	6	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	5	0	109	Day 2	CFB Ultimate Guard	Golgari Midrange	5-3 overnight, before an 0-3 Draft D2 ended his interest.
6255	550	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	110	Day 2			Solid 5-3 into 2-6 D2
7123	999	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	4	3	0	111	Day 2	Misfits		Lost R1, then won four straight. Lost plenty from then on.
5260	21	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	112	Day 2			Won twice in R7 and R8 to advance, then 3-5 D2.
6091	468	6	t	f	3	3	0	2	1	1	0	0	4	6	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	4	0	113	Day 2	Worldly Counsel	Esper Midrange	Only 4-4 overnight, 3-5 on D2.
6440	650	6	t	f	2	3	0	2	1	1	0	0	4	6	0	6	9	0	6-9-0	3	4	0	3	5	0	0	0	0	f	5	5	1	114	Day 2	Misfits		Rough start at 1-4, then won five straight, before five losses.
6757	815	6	t	f	2	4	0	2	0	2	0	0	5	5	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	4	3	0	115	Day 2	Portugese+Brazilians		Went from 0-2 to 4-2, but didn't improve from there.
6311	579	6	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	5	3	0	2	6	0	0	0	0	f	3	4	0	116	Day 2			Slow start at 0-2 but 5-3 overnight. Then 2-6 D2.
5590	205	6	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	2	3	0	117	Day 2			Alternated losses and wins all eight rounds D1. 1-5 in Draft was the trouble.
6797	831	6	t	f	2	3	1	2	0	1	0	0	4	6	0	6	9	1	6-9-1	4	3	1	2	6	0	0	0	0	f	2	4	0	118	Day 2	Handshake	Esper Midrange	Had to win twice to reach D2, and might have wished he hadn't, going 2-6.
6608	731	6	t	f	1	5	0	2	0	2	0	1	4	5	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	2	4	0	119	Day 2			Won elimination match to advance R8, but only won once on D2.
6400	628	6	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	120	Day 2			Even in Draft, 3-7 in Standard.
5252	18	6	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	5	0	121	Day 2	Perrini Araujo	Boros Convoke	Had to win R8 to advance, then 2-6 on D2.
6492	676	6	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	122	Day 2			Advanced with a round to spare, but then 2-6 D2.
7105	989	6	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	5	0	123	Day 2	Wu Hayne		Losing record in both formats.
6512	684	6	t	f	2	4	0	2	1	1	0	1	3	6	0	5	10	0	5-10-0	4	4	0	1	6	0	0	0	0	f	3	5	0	124	Day 2	Wu Hayne		From 3-1, it took until R8 to secure D2, and then only won once.
6448	657	6	t	f	2	4	0	2	0	2	0	0	4	6	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	3	3	0	125	Day 2	Japan 2		Did well to reach D2 from 1-4, winning three straight, then went 2-6 D2.
5747	290	6	t	f	1	5	0	2	0	2	0	1	3	6	0	4	11	0	4-11-0	4	4	0	0	7	0	0	0	0	f	2	4	0	126	Day 2			Won twice in must-win spots to reach D2, didn't win a single match D2.
7095	985	6	t	f	3	3	0	2	1	1	1	1	1	4	0	4	7	0	4-7-0	4	4	0	0	3	0	0	0	0	f	3	6	0	128	Day 2			Trophy in Draft 1, but reversed on D2. Abandoned at 4-7.
6488	673	6	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	3	3	0	129	X	CFB Ultimate Guard	Esper Midrange	3-1-1, but lost three straight to miss D2.
6549	701	6	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	130	X	Orange Prost	Azorius Control	2-1 in Draft, but only a single Standard win. No D2.
6987	928	6	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	3	0	131	X	Sanctum of All		Costly draw in Standard meant no D2.
7116	996	6	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	1	0	132	X			Eliminated R7.
5411	110	6	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	1	0	133	X			Lost the elimination match in R8.
6363	604	6	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	3	0	134	X	Worldly Counsel	Esper Midrange	3-1-1 was the highpoint, before three straight defeats meant no D2.
6959	916	6	f	f	0	3	0	1	0	1	0	1	3	1	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	3	0	135	X	Bergelin Eriksson Skorupa Tatian		Lost elimination match R8 to Stefan Schutz.
6084	465	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	136	X			Disappointing, falling from promising 3-2 to elimation at 3-5.
5947	396	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	137	X			Had four bites at reaching D2 from 3-1. Didn't.
6367	605	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	138	X	Portugese+Brazilians		3-1 into 3-5 to miss D2.
6360	603	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	140	X	Sewer Rats	Esper Midrange	2-0, but didn't win again until R8, so no D2.
7158	1014	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	141	X		Boros Convoke	2-0, but only one more win from there, so no D2.
5706	265	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	142	X	Misfits	Rakdos Aggro	Had two chances to make D2, couldn't get it done.
6070	457	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	4	0	143	X			Won three straight to reach 3-1, lost four straight to reach 3-5.
5993	419	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	144	X			3-3 became 3-5, so no D2.
6732	804	6	f	f	1	1	0	1	0	0	0	0	1	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	145	X	Sanctum of All		Got to 3-1, but couldn't find a fourth win to advance.
5863	351	6	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	146	X	Sanctum of All	Four-Color Legends	2-1 in Draft, but only 1-4 in Standard. No D2.
6603	728	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	148	X		Rakdos Midrange	From 3-2 to 3-5, and out on D1.
7117	997	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	149	X	Lim Wijaya		Lost to William Araujo in R8 in elimination match.
5531	182	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	150	X	Sanctum of All		Needed three straight to advance from 1-4, got the first two, but not the last.
5300	46	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	151	X			Couldn't dig out from the 0-4 hole.
6669	769	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	152	X	Temple of Malady		0-3 in Draft was too much to overcome.
5392	103	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	153	X	Sanctum of All		3-2, but then lost three straight rounds to Esper Midrange opponents.
6431	644	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	154	X	Italy	Esper Midrange	Kept alternating wins and losses, until two losses in a row meant 3-5, and no D2.
6719	796	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	155	X	Sewer Rats	Esper Midrange	Turned 0-3 into 3-3, but couldn't find another win to make D2.
6037	440	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	156	X	CFB Ultimate Guard		Bizarrely let down in Draft, going 0-3. 3-2 in Standard not quite enough.
6590	723	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	157	X	Spain	Esper Midrange	3-3, but lost both his last two rounds, so no D2.
7194	1029	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	158	X	Worldly Counsel		Started 0-3 in Draft, couldn't turn it around.
5926	385	6	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	159	X			Didn't win until R7.
5409	109	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	160	X	Italians	Dimir Control	1-2 in draft, and eliminated from D2 by Jacob Nagro in R7.
5750	291	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	161	X		Boros Convoke	From 0-2 to 3-3, but lost his last two, so no D2.
6416	641	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	162	X			Eliminated R7.
6349	599	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	163	X	Guillotine		Eliminated R8 by Devon Straub.
7203	1033	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	164	X	French		Needed three striaght to make D2, could only get two of them.
5771	305	6	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	165	X	Bus Stop		0-3 in Draft, left too much to do.
7047	959	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	166	X		Esper Reanimator	Never at the races, needed three straight to advance, lost his last round to miss D2.
6183	513	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	167	X	Handshake Ultimate Guard	Mono-Red Aggro	Never in the mix, and no D2.
6518	687	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	5	0	168	X			Already out of D2 when winning the last two rounds of D1.
5416	114	6	f	f	2	1	0	1	1	0	0	0	0	3	2	2	4	2	2-4-2	2	4	2	0	0	0	0	0	0	f	2	3	0	169	X			2-1 after Draft, then two unlikely draws back to back, before three defeats.
5440	124	6	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	4	0	170	X		Esper Midrange	Excellent Ltd win over Seth Manfield the only highlight on a miserable D1, with that the only round win until R8.
6751	813	6	f	f	1	2	0	1	0	1	0	0	1	3	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	2	3	0	171	X		Esper Midrange	Opened 2-2, but couldn’t buy a win from there.
6406	632	6	f	f	0	3	0	1	0	1	0	1	2	2	1	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	1	3	0	172	X	Canadians		0-3 in Draft, even 2-2-1 in Standard. No D2.
6890	882	6	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	173	X	Handshake	Esper Midrange	2-0, but that was all she wrote.
6842	858	6	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	174	X			2-1 in Draft, couldn't win a match in Standard.
6996	932	6	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	175	X			Never better than 2-2.
5513	173	6	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	176	X			2-1 in Draft, no wins in Standard.
5269	25	6	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	177	X	CFB Ultimate Guard	Golgari Midrange	1-2 in Draft, 1-3 in Standard, not a good day.
7221	1042	6	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	178	X		Domain Ramp	Solid 2-0 start, but then six defeats.
5753	292	6	f	f	0	2	0	1	0	1	0	0	1	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	179	X			Lone win was R8.
5680	251	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	180	X	Coalition Victory		Got to 2-2, but no more wins.
7127	1001	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	183	X			2-3, but then 2-6.
6775	820	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	184	X	Moriyama Japan		Eliminated R6 at 1-5.
6997	933	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	185	X			Got to 2-2, then 2-6.
5498	161	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	186	X			2-3 to 2-6.
7183	1023	6	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	187	X	Sanctum of All		0-3 Draft, eliminated in R7.
5922	383	6	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	189	X	Coalition Victory		Had to wait until R6 and R7 for wins.
6464	663	6	f	f	1	2	0	1	0	1	0	0	0	0	0	1	2	0	1-2-0	1	2	0	0	0	0	0	0	0	f	1	1	0	190	X			Withdrew after a 1-2 opening Draft.
6137	492	6	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	191	X	Sanctum of All		Eliminated at 1-5.
5896	367	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	192	X			Out at 1-5, eliminated by Jesse Hampton.
7072	974	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	193	X	Misfits		Won R1, and nothing after that.
6333	590	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	194	X	Moriyama Japan		Lone win was in Draft.
6143	495	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	195	X	Sewer Rats	Esper Midrange	Poor Draft, still better than 0-3 in Standard.
5286	38	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	196	X	Misfits		Won the last round of Draft, but that was it.
6528	694	6	f	f	0	3	0	1	0	1	0	1	0	4	0	0	7	0	0-7-0	0	7	0	0	0	0	0	0	0	f	0	7	0	197	X	Japan 2		Played all day for zero wins, and a bye.
6118	485	6	f	f	1	2	0	1	0	1	0	0	0	4	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	6	0	198	X	Iteration		Won R1, then nothing.
5821	331	6	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	199	X			Five of six matches went to a deciding game, but only one match win.
7131	1004	6	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	3	0	200	X			Lone win was first round of Standard.
5484	148	6	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	4	0	201	X	Iteration		One win in Standard, that was all.
6774	819	6	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	202	X	Moriyama Japan	Boros Convoke	Won R1, then nothing. Out after R6.
6850	863	6	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	203	X			Won three games across five rounds, but no matches.
6812	837	6	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	204	X	Misfits	Rakdos Aggro	Kept trying, kept losing, 0-6 and out.
6822	843	6	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	205	X	CFB Ultimate Guard		0-5 drop, three game wins.
6023	435	6	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	206	X	Misfits		0-5 and done, with three game wins.
6503	679	7	t	t	5	1	0	2	2	0	1	0	10	3	0	15	4	0	15-4-0	6	2	0	6	2	0	3	0	0	t	4	1	0	1	Champion	Handshake Ultimate Guard	Bant Nadu	Another Draft pod aced to open, 6-2 overnight, but needed three straight wins to reach T8. Got them, of course. This time he went the distance, edging past Javier Dominguez and Daniel Goetschel before taking down Sam Pardee in the Finals to complete one of the greatest sequences of anyone ever.
6572	711	7	t	t	5	1	0	2	2	0	1	0	9	4	0	14	5	0	14-5-0	5	3	0	7	1	0	2	1	0	t	5	1	1	2	Finals	CFB Ultimate Guard	Bant Nadu	5-3 D1 became 10-3. Beat Brian Boss and Jean-Emmanuel Depraz in the last two rounds to reach T8. Reversed an earlier loss to Jason Ye in the QFs, then won the decider against Eli Kassis in the Semis. Simon Nielsen beat him 3-1 in the Finals.
6062	451	7	t	t	4	2	0	2	2	0	0	0	9	1	0	13	3	0	13-3-0	7	1	0	5	1	0	1	1	0	t	7	1	1	3	Semifinals	Handshake Ultimate Guard	Bant Nadu	Superb seven round win streak, plus three D2 Modern wins took him into T8 with two rounds to spare. Beat Seth Manfield in the QFs, before Sam Pardee took the deciding game in the Semis.
5795	312	7	t	t	4	1	1	2	1	0	1	0	8	4	0	12	5	1	12-5-1	6	2	0	5	2	1	1	1	0	t	5	2	1	4	Semifinals	Temple of Malady	Four-Color Nadu	Still only 1-1-1 in Draft on D2, but this time it didn't matter. 6-2 on D1, and then a 4-1 record in Modern took him into the T8. He edged out Noah Ma in the QFs before losing the deciding game in the Semis against Simon Nielsen.
5557	189	9	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	241	x	CFB Ultimate Guard	Jeskai Oculus	
6273	562	7	t	t	5	1	0	2	2	0	1	0	7	1	0	12	2	0	12-2-0	7	1	0	5	0	0	0	1	0	t	10	1	1	5	Top 8	Channel Fireball		From 1-1, went on a stupendous eleven round win streak, meaning T8 qualification with a ridiculous three rounds to spare. Lost QFs to Daniel Goetschel in a full five game set.
7178	1020	7	t	t	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	7	1	0	5	2	0	0	1	0	t	8	1	1	6	Top 8	Sanctum of All	Bant Nadu	Spectacular again. 0-1 to 8-1, then through to T8 with a round to spare. Lost again in a QF game five, this time against Sam Pardee.
5612	217	7	t	t	4	2	0	2	1	1	1	0	8	2	0	12	4	0	12-4-0	7	1	0	5	2	0	0	1	0	t	6	1	1	7	Top 8	Handshake Ultimate Guard	Jeskai Control	Starting out 6-0 was the core of his run to T8, with four straight Modern wins on D2 sealing the deal. Once again there was a QF defeat, losing the deciding game to Simon Nielsen.
6305	575	7	t	t	6	0	0	2	2	0	2	0	6	5	0	12	5	0	12-5-0	6	2	0	6	2	0	0	1	0	t	3	2	0	8	Top 8	CFB Ultimate Guard	Mono-Black Necro	6-0 in Draft gave him the perfect springboard for another T8. But he was only 6-4 in constructed, and that became 6-5 when Eli Kassis handily won their QF.
6449	657	7	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	8	0	0	3	5	0	0	0	0	t	9	3	1	10	Top 16			D1 Draft trophy, then also perfect in Modern to pace the field at 8-0. Got to 9-0, but went 2-5 from there to miss out on T8.
5585	202	7	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	4	2	0	11	Top 16	French	Bant Nadu	Tremendous 7-1 D1, but losses to Jason Ye and Javier Dominguez brought him back to the pack, and Sam Pardee eliminated him in R15 in the Bant Nadu mirror.
7200	1031	7	t	f	6	0	0	2	2	0	2	0	5	5	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	4	1	0	12	Top 16			Perfect in Draft both days, but couldn't get above parity in Modern.
5344	76	7	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	7	1	0	4	4	0	0	0	0	t	4	1	0	13	Top 16		Gruul Prowess	Tremendous start, winning his Draft, then 7-1 overnight. Got to 11-4, but lost his final round win-and-in against Sam Pardee.
5351	78	7	t	f	4	2	0	2	1	1	1	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	f	5	2	1	14	Top 16	French		Draft trophy D1, advanced to 5-0. Also won last four on D2, but 2-5 in the middle stretch meant no T8.
5828	337	7	t	f	5	1	0	2	2	0	1	0	6	4	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	7	2	1	15	Top 16	Worldly Counsel Heavy Play		From 4-3, grinded into contention with a terrific seven round win streak, before losing to Jason Ye and Seth Manfield in the last two rounds to miss T8.
6712	795	7	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	t	3	2	0	16	Top 16			Twice won three in a row, and more than enough to requalify. Just not quite enough for T8.
5575	200	7	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	6	2	0	5	3	0	0	0	0	t	3	1	0	17	Top 32	Worldly Counsel Heavy Play	Bant Nadu	Three times he had three straight wins, the last of which set up a win and in versus Daniel Goetschel in R16, with Goetschel taking the deciding game, and the T8 slot.
5509	1220	7	t	f	4	2	0	2	2	0	0	0	7	3	0	11	5	0	11-5-0	5	3	0	6	2	0	0	0	0	f	4	1	0	18	Top 32	CFB Ultimate Guard		Winning records in both formats, never lost two in a row, a really solid weekend.
5785	310	7	t	f	5	0	1	2	2	0	1	0	5	4	1	10	4	2	10-4-2	4	3	1	6	1	1	0	0	0	f	3	2	0	19	Top 32	Worldly Counsel Heavy Play	Bant Nadu	After a mediocre 4-3-1 on D1, he markedly improved with 6-1-1 on D2, the draws ultimately costing him a T8 berth.
5803	318	7	t	f	3	3	0	2	1	1	1	1	7	2	1	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	t	4	4	0	20	Top 32	Worldly Counsel Heavy Play		Didn't lose until R8, but an 0-3 Draft D2 left him against the wall. Won the first four back in Modern to play for T8 in R16, lost the deciding game to Matt Sperling.
5475	142	7	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	3	2	0	21	Top 32			Nice to requalify, but perhaps slightly disappointing from 5-1.
7135	1007	7	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	6	1	1	4	4	0	0	0	0	t	3	2	0	22	Top 32			Excellent 6-1-1 D1, but couldn't maintain the pace D2.
6424	643	7	t	f	5	1	0	2	2	0	1	0	5	4	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	t	5	2	1	23	Top 32	Moriyama Japan	Bant Nadu	An excellent 5-1 in Draft, but the damage was done in a 2-3 Modern record on D1. Yet another win streak (R10-14) in vain.
6941	903	7	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	4	2	0	24	Top 32	Misfits	Jeskai Control	5-3 overnight, and another useful four round win streak kept him in it until R14, when Simon Nielsen ended things.
6598	727	7	t	f	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	5	3	0	5	2	0	0	0	0	f	4	1	0	25	Top 32	Coalition Victory		Winning records in both formats, and avoided elimination from contention four times, before losing to Marco Del Pivo in R14.
5691	257	7	t	f	3	2	1	2	1	0	0	0	7	3	0	10	5	1	10-5-1	5	2	1	5	3	0	0	0	0	t	6	2	1	27	Top 32	Italians	Eldrazi Tron	Yet again in trouble, pulled six in a row, won more than he lost, and only briefly in contention.
6874	877	7	t	f	1	5	0	2	0	2	0	1	9	0	1	10	5	1	10-5-1	5	3	0	5	2	1	0	0	0	f	5	3	1	28	Top 32			Horrible 0-3 start, then six on the bounce, before Reid Duke eliminated him in R11. Still went 4-0-1 down the stretch in Modern.
5400	107	7	t	f	4	2	0	2	1	1	1	0	6	3	0	10	5	0	10-5-0	4	4	0	6	1	0	0	0	0	f	5	1	1	29	Top 32	Worldly Counsel Heavy Play	Eldrazi Tron	Five straight wins, including his D2 draft pod, left him live after R12, but Marc Peral gave him loss number five in R13.
6858	870	7	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	t	4	2	0	30	Top 32	Sewer Rats		6-1 the high spot, stayed in contention until R15, beaten by Javier Dominguez.
5834	341	7	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	6	2	1	31	Top 32	Handshake Ultimate Guard		3-0 Draft trophy D1, doubled that to 6-0, but only 4-6 from there. 5-5 in Modern not enough.
5534	184	3	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	260	X			Won the first round of Modern, but that was all.
7284	202	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	5	2	1	60	Day 2		Dimir Midrange	
6591	723	7	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	32	Top 32	Coalition Victory	Bant Nadu	An excellent 5-0 start saw him contend deep into D2, with Tomasz Sodomirski ending his chances in R14.
6460	661	7	t	f	5	1	0	2	2	0	1	0	4	3	2	9	4	2	9-4-2	5	1	2	4	3	0	0	0	0	t	7	3	1	33	Day 2	Moriyama Japan	Jeskai Control	Despite being undefeated on D1 in Modern, that featured two damaging draws. Despite seven straight wins, it was once again Eli Kassis acting as nemesis, defeating him once on each day.
6391	622	7	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	t	4	2	0	34	Day 2	Sewer Rats		Positive results in both formats, and 5-3 both days. Enough to requalify.
6752	813	7	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	35	Day 2	Twins	Four-Color Nadu	Twice had four straight wins, but lost three in a row down the stretch to take him out of contention.
5666	240	7	t	f	2	3	0	2	1	1	0	1	7	3	0	9	6	0	9-6-0	5	2	0	4	4	0	0	0	0	f	4	4	0	36	Day 2	Sanctum of All		0-3 in Draft D2 was the decider, although won the last four in Modern. Enough to requalify.
5321	62	7	t	f	4	2	0	2	1	1	1	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	7	2	1	37	Day 2			Poor start at 1-3, then seven wins in a row. Eliminated R13.
6737	809	7	t	f	4	1	1	2	2	0	0	0	5	3	1	9	4	2	9-4-2	5	2	1	4	2	1	0	0	0	f	2	1	0	38	Day 2	Spain		Won back to back rounds four times, but never added a third.
5619	218	7	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	39	Day 2	Sewer Rats	Jeskai Control	Solid 5-3 both days, but the horse had bolted before Modern on D2.
6437	649	7	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	4	3	0	40	Day 2	Channel Fireball		Came back to Modern at 8-3, but three straight losses took him out of the running.
5546	188	7	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	41	Day 2	Temple of Malady	Eldrazi Tron	Solid four wins on the bounce left him at 7-2, but then eliminated by a combination of Shuhei Nakamura, Nathan Steuer, and Greg Orange.
5639	228	7	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	2	2	0	42	Day 2	CFB Ultimate Guard	Mono-Black Necro	A pair of 5-3s was fine, but never stringing together more than two wins left him well shy of the T8.
7204	1034	7	t	f	2	4	0	2	0	2	0	0	8	2	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	2	1	43	Day 2			Ended D1 with five straight wins, and ended D2 with three straight. 8-2 in Modern terrific, 2-4 in Draft the issue.
5891	364	7	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	4	3	0	44	Day 2	Handshake Ultimate Guard		Nice position at 6-2 after D1, but 4-4 D2.
5997	422	7	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	45	Day 2			Fell from 4-2 to end D1 4-4, but a really nice D2, going 6-2.
6071	457	7	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	2	0	46	Day 2			Had to win R8 to get there, but made the most of D2, going 6-2.
6032	439	7	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	3	3	0	47	Day 2	CFB Ultimate Guard	Bant Nadu	4-4 D1, then a strong D2 highlighted by 4-1 in Modern.
7079	975	7	t	f	5	1	0	2	2	0	1	0	4	5	1	9	6	1	9-6-1	6	1	1	3	5	0	0	0	0	f	4	3	0	48	Day 2	CFB Ultimate Guard	Mono-Black Necro	4-0, then 6-1-1 overnight. In fine shape heading back to Modern, but lost three straight.
5943	394	7	t	f	4	2	0	2	1	1	1	0	5	4	1	9	6	1	9-6-1	6	2	0	3	4	1	0	0	0	f	4	2	0	49	Day 2	CFB Ultimate Guard	Bant Nadu	3-0 Draft to start, but fell away badly on D2, with three losses and a draw a four round stretch he couldn't recover from.
5924	384	7	t	f	4	2	0	2	2	0	0	0	5	4	1	9	6	1	9-6-1	5	3	0	4	3	1	0	0	0	f	2	2	0	50	Day 2			Positive record both days, never better than 4-2.
5843	346	7	t	f	5	1	0	2	2	0	1	0	4	5	1	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	4	2	0	51	Day 2	Handshake Ultimate Guard	Jeskai Control	After a 4-3-1 D1, four wins in a row brought him into the mix, before Daniel Goetschel beat him in R13 to end his chances.
6984	927	7	t	f	3	3	0	2	1	1	0	0	6	3	1	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	2	2	0	52	Day 2	Sanctum of All		Started well, getting to 4-1, and 5-2-1 overnight. Even 4-4 on D2.
5363	87	7	t	f	4	1	1	2	2	0	0	0	5	5	0	9	6	1	9-6-1	5	2	1	4	4	0	0	0	0	f	2	3	0	53	Day 2	Bus Stop		Solid 4-1-1 in Draft, but even 5-5 in Modern.
6286	567	7	t	f	3	2	1	2	1	0	0	0	6	4	0	9	6	1	9-6-1	4	3	1	5	3	0	0	0	0	f	3	2	0	54	Day 2	Misfits	Boros Energy	Needed two wins to advance, got them, and then put together a solid 5-3 on D2 without ever threatening the T8.
7009	937	7	t	f	3	2	1	2	1	1	0	0	6	4	0	9	6	1	9-6-1	4	4	0	5	2	1	0	0	0	f	4	3	0	55	Day 2			From 1-4, didn't lose again until R14.
6350	600	7	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	3	1	56	Day 2	Coalition Victory		6-1 and 8-2 before three straight losses.
6641	754	7	t	f	6	0	0	2	2	0	2	0	3	7	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	57	Day 2			Perfect 6-0 in Draft, poor 3-7 in Modern.
5356	81	7	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	3	0	58	Day 2			Solid 4-2 in Draft, 2-1 both days, only 5-5 in Modern.
5331	69	7	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	4	0	59	Day 2	Tenacious Underdogs		Strong D1 at 6-2, but losing 3-5 record D2.
6001	423	7	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	4	2	0	60	Day 2		Jeskia Dress Down	Comfortably made D2, but 1-2 in Draft ended his chances.
6092	468	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	61	Day 2	Worldly Counsel Heavy Play	Bant Nadu	Strong 6-2 D1, once again found D2 a struggle, going 3-5.
7048	959	7	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	62	Day 2	Italians	Jeskai Control	3-0 Draft the highlight, but 5-2 became 5-5 to end his chances.
6015	430	7	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	63	Day 2	Rampant Growth Heavy Play		Trophy to open D1, and 2-1 in Draft D2. Only 4-6 in Modern, however.
5671	243	7	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	2	2	0	64	Day 2			Winning record in Draft, but even in Modern. Out of contention R13.
5878	358	7	t	f	4	2	0	2	2	0	0	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	65	Day 2	Rampant Growth Heavy Play	Ruby Storm	Just into D2 at 4-4, but R9 loss ended his T8 interest early on D2.
6808	835	7	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	66	Day 2	CFB Ultimate Guard	Ruby Storm	Superb again in Ltd, going 5-1 in Draft, but 7-3 became 7-6, before a couple of late wins once T8 was gone.
6764	816	7	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	3	0	67	Day 2	Handshake Ultimate Guard	Bant Nadu	4-4 became 7-4, before he fell out of contention early in Modern.
6330	589	7	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	68	Day 2	Moriyama Japan	Mardu Energy	4-4 overnight became 7-4 after a Draft pod win on D2, but was soon out of contention once back in Modern.
6452	658	7	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	5	3	1	70	Day 2			Five wins on the bounce D1, but out of contention after R9.
6742	811	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	71	Day 2	Coalition Victory	Mono-Black Necro	2-3 to 5-3 D1, but out of contention before the return to Modern.
5657	238	7	t	f	4	2	0	2	1	1	1	0	5	5	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	3	0	72	Day 2	Worldly Counsel Heavy Play	Mono-Black Necro	Plenty of work to do at 4-4, he opened D2 by winning his Draft pod, but then lost three straight in Modern to end things.
6408	634	7	t	f	1	5	0	2	0	2	0	1	8	2	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	5	4	1	73	Day 2	Coalition Victory		Five in a row in Modern D1, ended 8-2, but 1-5 in Draft nowhere near enough.
6154	499	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	74	Day 2	CFB Ultimate Guard		Won R8 to advance, then creditable 5-3 D2.
6953	913	7	t	f	2	4	0	2	1	1	0	1	7	3	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	3	0	75	Day 2			0-3 Draft on D2 took him out of contention.
5421	118	7	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	76	Day 2			Strong 7-3 in Modern, but 2-4 in Draft.
5431	121	7	t	f	2	4	0	2	0	2	0	0	7	3	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	4	2	0	77	Day 2	Worldly Counsel Heavy Play	Mono-Black Necro	Advanced to D2 as usual, but on the minimum 4-4, and was never in contention, with a four round streak to finish too late.
5974	406	7	t	f	2	3	1	2	0	1	0	0	6	2	2	8	5	3	8-5-3	3	2	3	5	3	0	0	0	0	f	3	2	0	78	Day 2	Moriyama Japan	Jeskai Control	Three draws on D1 cost him, but 8-5-3 was still solid.
5504	166	7	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	79	Day 2			Decent 6-4 in Modern, and 3-3 in Draft for an overall winning record.
6658	765	7	t	f	1	4	0	2	0	1	0	1	7	3	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	3	3	0	81	Day 2	Guillotine	Bant Nadu	Deep 0-3 hole, but fought to reach D2. Never in the mix.
6745	812	7	t	f	0	5	0	2	0	2	0	1	8	2	0	8	7	0	8-7-0	4	4	0	4	3	0	0	0	0	f	4	4	0	82	Day 2	Argentina+Spain		Completed the full 0-4 to 4-4 comeback D1, and got another four wins on D2.
7149	1011	7	t	f	3	3	0	2	1	1	0	0	5	4	1	8	7	1	8-7-1	4	4	0	4	3	1	0	0	0	f	3	2	0	83	Day 2	Scoreboard	Jeskai Chant	R8 win ensured a D2, then 4-3-1 to finish just above even.
6550	701	7	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	88	Day 2		Jeskai Control	In contention heading back to Modern on D2, but lost his last four to fall off badly.
6798	831	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	4	3	0	89	Day 2	Handshake Ultimate Guard	Bant Nadu	A swingy four wins  in a row, and three tough D2 defeats in a row. Ended up even at 8-8.
5462	137	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	2	0	90	Day 2		Jeskai Dress Down	3-3 became 6-3, but two D2 Draft defeats cost him.
5245	14	7	t	f	2	4	0	2	1	1	0	1	6	4	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	5	0	98	Day 2	Sewer Rats	Four-Color Nadu	From an excellent 5-2, five defeats in a row, including 0-3 in draft on D2. Still won three of his last four to finish even at 8-8.
6049	447	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	2	0	99	Day 2	Worldly Counsel Heavy Play	Mono-Black Necro	On the brink at 2-4, won four straight before being out of contention before the return to Modern.
5662	239	7	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	100	Day 2	Rampant Growth Heavy Play	Bant Nadu	Surprising 2-4 in Draft undermined him considerably, finishing 8-8.
5648	235	1	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	216	X			Out at 0-5, having deciding games in four of the five.
5567	199	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	173	X			From 0-2 to 3-2, but couldn't advance.
5584	202	6	t	f	2	3	1	2	1	1	0	0	6	3	1	8	6	2	8-6-2	5	2	1	3	4	1	0	0	0	f	3	3	0	70	Day 2	Guillotine	Esper Midrange	Comfortably into D2, but a single point in Draft on D2 took him out of contention.
5555	189	7	t	f	2	4	0	2	0	2	0	0	6	4	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	104	Day 2	CFB Ultimate Guard	Gruul Eldrazi	Rightly proud of his record of always making D2, he needed three straight wins to maintain that, which he did. Won four in a row on D2 to end even at 8-8.
5647	234	9	t	f	3	3	0	2	1	1	1	1	4	6	0	7	9	0	7-9-0	6	2	0	1	7	0	0	0	0	f	3	5	0	175	Day 2	CFB Ultimate Guard	Dimir Bounce	
7003	935	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	4	0	105	Day 2	Killers Among Us	Boros Burn	3-1 became 4-4, out of contention early D2. Won his last three to finish even at 8-8.
5902	371	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	107	Day 2	Sewer Rats	Four-Color Nadu	Comfortably into D2, but 4-4 D2 couldn't be enough.
6927	900	7	t	f	1	5	0	2	0	2	0	1	7	3	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	3	0	108	Day 2	Moriyama Japan	Dimir Murktide	Somehow survived an 0-3 start to make D2, but quickly out of contention.
5736	282	7	t	f	4	1	1	2	1	0	1	0	3	7	0	7	8	1	7-8-1	4	4	0	3	4	1	0	0	0	f	3	3	0	109	Day 2	Handshake Ultimate Guard	Bant Nadu	3-0 to start in Draft, but only 4-4 overnight, and a costly draw in R9 ended his chances.
6813	837	7	t	f	4	1	1	2	2	0	0	0	3	7	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	2	3	0	110	Day 2	Misfits	Four-Color Nadu	Excellent 4-1-1 across two Drafts, but only 3-7 in Modern.
6720	796	7	t	f	1	4	1	2	0	2	0	0	6	4	0	7	8	1	7-8-1	4	3	1	3	5	0	0	0	0	f	4	2	0	111	Day 2	Sewer Rats	Mono-Black Grief	Fought back from a single draw in Draft D1 to advance, but out of contetion early on D2.
7173	1019	7	t	f	4	2	0	2	2	0	0	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	5	0	119	Day 2		Jeskai Wizards	From 3-1, 4-4 overnight was a disappointment. Soon out of contention.
7063	968	7	t	f	4	2	0	2	1	1	1	0	3	7	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	5	5	1	124	Day 2	Italians	Izzet Wizards	Creditable five round win streak saw him make D2 and get close to contention, before everything fell away in Modern on D2.
7222	1042	7	t	f	2	3	0	2	0	1	0	0	4	5	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	3	3	0	126	Day 2	Killers Among Us	Boros Prowess	Fought back from 1-4 to make D2, but didn't make much progress.
5253	18	7	t	f	2	4	0	2	1	0	0	1	4	3	1	6	7	1	6-7-1	5	2	1	1	5	0	0	0	0	f	3	4	0	129	Day 2		Mono-Black Grief	A strong 5-2-1 D1, but could only add a single win on D2 before dropping after R14.
6198	515	7	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	4	0	2	4	0	0	0	0	f	2	4	0	136	Day 2	Italians	Ruby Storm	4-3 D1, but out of contention early on D2.
6956	914	7	t	f	3	3	0	2	1	1	0	0	3	7	0	6	10	0	6-10-0	4	4	0	2	6	0	0	0	0	f	2	4	0	137	Day 2	Worldly Counsel	Jeskai Control	4-4 overnight, but never in touch with the leaders.
6604	728	7	t	f	1	5	0	2	0	2	0	1	3	3	0	4	8	0	4-8-0	4	4	0	0	4	0	0	0	0	f	1	4	0	145	Day 2	Perrini Araujo	Mono-Black Necro	5-3 overnight, but not a single win on D2 before packing it in after R12.
6563	709	7	t	f	0	1	2	2	0	1	0	0	3	2	0	3	3	2	3-3-2	3	3	2	0	0	0	0	0	0	f	2	1	0	148	Day 2	Sewer Rats	Izzet Murktide	Strangely, two Draft draws started his day, and his 3-2 record in Modern couldn't make up for those lost points in Limited.
6135	491	7	f	f	1	1	1	1	0	0	0	0	2	2	1	3	3	2	3-3-2	3	3	2	0	0	0	0	0	0	f	2	1	0	150	X	Moriyama Japan	Mardu Energy	More draws cost him again, this time leaving him a point short of making D2.
5959	401	7	f	f	2	1	0	1	1	0	0	0	1	3	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	152	X	Moriyama Japan	Jeskai Control	2-1 in Draft, but only a single Modern win. No D2.
6535	696	7	f	f	1	2	0	1	0	1	0	0	2	2	1	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	1	2	0	155	X	Scoreboard	Ruby Storm	3 wins and a draw left him just short of D2.
6838	854	7	f	f	3	0	0	1	1	0	1	0	0	5	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	5	0	164	X	Worldly Counsel	Eldrazi Tron	Perfect 3-0 Draft, then disaster, no win in Modern, no D2.
6189	514	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	165	X	Bus Stop	Jeskai Wizards	3-3 into 3-5, so no D2.
5516	174	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	2	0	166	X	Bus Stop	Four-Color Nadu	Turned 1-3 into 3-3, but then lost his last two to mean no D2.
5864	351	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	172	X	Rampant Growth Heavy Play	Bant Nadu	Never two consecutive wins, lost his win-and-advance in R8.
6098	469	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	176	X	Bus Stop	Ruby Storm	Played R8 to advance, lost, so out D1.
6480	669	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	4	0	181	X	CFB Ultimate Guard	Mono-Black Necro	2-1 in Draft, but didn’t win again until the final round of the day.
5441	124	7	f	f	1	1	1	1	0	0	0	0	1	3	1	2	4	2	2-4-2	2	4	2	0	0	0	0	0	0	f	1	2	0	194	X	Worldly Counsel Heavy Play	Eldrazi Tron	Two draws didn't help, but nor did only two wins. No D2.
6365	604	7	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	202	X	Worldly Counsel	Bant Nadu	One win in each format, not close to D2.
5410	109	7	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	204	X	Italians	Gruul Eldrazi	0-3 in Ltd again, same result, no D2.
5231	8	7	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	209	X		Jeskai Chant	No joy, with just a single win in each format.
7198	1030	7	f	f	1	2	0	1	0	1	0	0	0	3	2	1	5	2	1-5-2	1	5	2	0	0	0	0	0	0	f	1	2	0	219	X	Worldly Counsel	Mono-Black Necro	Had two Modern draws, but only a single Draft win across eight D1 rounds.
6152	498	7	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	4	0	231	X		Bant Nadu	1-2 in Draft was unfortunately the highlight, with 0 from 3 Constructed wins before he dropped.
7159	1014	7	f	f	0	2	1	1	0	1	0	0	0	3	0	0	5	1	0-5-1	0	5	1	0	0	0	0	0	0	f	0	4	0	237	X		Esper Goryo's	No wins, one draw, no D2.
7146	1010	7	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	238	X	Misfits	Jeskai Control	Five rounds, no wins, no D2.
5854	349	7	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	239	X	Moriyama Japan	Mardu Energy	Arrived with no wins, left with no wins, at 0-5, eliminated at the earliest opportunity.
5751	291	7	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	241	X		Ruby Storm	Awful. Five rounds, no wins, the end.
5613	217	8	t	t	5	1	0	2	2	0	1	0	8	2	0	13	3	0	13-3-0	5	2	0	5	1	0	3	0	0	t	6	1	1	1	Champion	Handshake Ultimate Guard	Dimir Demons	After three QF defeats, this time there was no mercy. From 2-2 he only lost once more. On Sunday, Ha Pham and Seth Manfield fell to him, before he swept aside Marcio Carvalho in the Final to become only the second two-time World Champion,
5432	121	8	t	t	5	1	0	2	2	0	1	0	7	3	0	12	4	0	12-4-0	6	1	0	4	2	0	2	1	0	t	5	2	1	2	Finals	Worldly Counsel Heavy Play	Golgari Midrange	6-1 overnight, and made the Top 8 with a round to spare, cementing his place with a win over Kai Budde. Edged past Yoshihiko Ikawa in the QFs, then another 5 game set over Quinn Tonole in the semis. A one-sided Final saw him lose 3-0 to Javier Dominguez, making this his third Finals appearance at the World Championship.
6306	575	8	t	t	5	1	0	2	2	0	1	0	6	1	0	11	2	0	11-2-0	6	1	0	4	0	0	1	1	0	t	9	1	1	3	Semifinals	CFB Ultimate Guard	Golgari Ramp	From 1-1, won nine in a row, frankly astonishing at a World Championship, qualifying for T8 with three rounds to spare. In an absurdly talented T8, he fought past Kai Budde in the QFs before Javier Dominguez won their deciding game, thus claiming the Player of the Year title.
7004	935	8	t	t	4	2	0	2	2	0	0	0	9	1	0	13	3	0	13-3-0	6	1	0	6	1	0	1	1	0	t	6	1	1	4	Semifinals	Milkshake	Mono-Red Aggro	From 2-1, was perfect 4-0 with Mono-Red. Another 2-1 in Draft kept him interested, and then two more constructed wins took him to T8. He swept Max Rappaport in the QFs, before narrowly losing to Marcio Carvalho in the Semis.
5960	401	8	t	t	4	2	0	2	2	0	0	0	6	3	0	10	5	0	10-5-0	4	3	0	6	1	0	0	1	0	t	4	1	0	6	Top 8	Moriyama Japan	Gruul Prowess	4-3 on D1, but a trememdous 6-1 on D2 took him into the T8. Lost the deciding game of the QFs to Marcio Carvalho.
5855	349	8	t	f	4	2	0	2	2	0	0	0	6	2	0	10	4	0	10-4-0	4	3	0	6	1	0	0	0	0	t	4	2	0	10	Top 16	Moriyama Japan	Dimir Midrange	Saved his best performance of the season for the Big One. The minimum 4-3 overnight, he went 6-1 on D2, only losing to Kai Budde (no shame). Finished 10th, just outside the knockout rounds.
6063	451	8	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	t	3	2	0	13	Top 16	Handshake Ultimate Guard	Azorius Oculus	Solid 4-2 in Draft, once again in contention down the stretch at 5-1 in Standard. Losses to Javier Dominguez and Yoshihiko Ikawa in the last two rounds kept him out of the T8.
5586	202	8	t	f	3	3	0	2	1	1	1	1	6	2	0	9	5	0	9-5-0	7	0	0	2	5	0	0	0	0	t	7	3	1	14	Top 16	French	Gruul Prowess	A perfect D1 to lead the field in defence of his title, but 0-3 in Draft D2 was damaging. Still played for T8 in the final round, but the legendary Kai Budde advanced.
7174	1019	8	t	f	4	2	0	2	1	1	1	0	5	3	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	t	7	2	1	15	Top 16		Azorius Oculus	In trouble at 1-2, didn't lose for a day, reaching 8-2 heading back to Standard. Losses to Seth Manfield and Kai Budde left him on the edge, and a final round loss to Lucas Duchow meant no T8.
5658	238	8	t	f	3	3	0	2	1	1	0	0	6	2	0	9	5	0	9-5-0	5	2	0	4	3	0	0	0	0	f	3	3	0	16	Top 16	Worldly Counsel Heavy Play	Jeskai Convoke	A solid 5-2 D1, but three defeats in a row on D2 were too much, despite winning his last three of the day.
6799	831	8	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	t	4	2	0	17	Top 32	Handshake Ultimate Guard	Domain Ramp	4-3 D1, improved to 5-2 D2, but not quite enough.
5547	188	8	t	f	4	2	0	2	2	0	0	0	5	3	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	f	4	2	0	19	Top 32	Rampant Growth Heavy Play	Gruul Prowess	4-3 became 6-3, live for Top 8. Alex Friedrichsen ended his contention in R12, leaving Davis to win his last two, ending a strong 9-5.
5903	371	8	t	f	4	2	0	2	1	1	1	0	5	3	0	9	5	0	9-5-0	4	3	0	5	2	0	0	0	0	t	6	1	1	20	Top 32	Bus Stop + Sewer Rats	Boros Enchantments	From 2-3, won six straight, and was in the mix to the end, losing to Kenta Harane in the final round.
5345	76	8	t	f	2	4	0	2	0	2	0	0	6	1	0	8	5	0	8-5-0	4	3	0	4	2	0	0	0	0	f	4	3	0	24	Top 32		Gruul Prowess	Did well to make D2 from an 0-2 start. Lost his first two again on D2, eliminating him from contention, but still put together a second streak of four wins, excellent at this level.
6504	679	8	t	f	6	0	0	2	2	0	2	0	2	6	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	t	4	4	0	25	Top 32	Handshake Ultimate Guard	Dimir Demons	Somehow 6-0 in Draft wasn't enough momentum, with a 2-2 on D1 in Standard becoming a nightmare 0-4 on D2.
5879	358	8	t	f	5	1	0	2	2	0	1	0	3	5	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	t	3	3	0	26	Top 32	Wu Hayne	Golgari Midrange	Yet another 3-0 Draft start, and 2-1 Draft to start D2 kept him in the mix at 7-3. Unfortunately lost his last three.
6957	914	8	t	f	4	2	0	2	1	1	1	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	t	5	3	1	29	Top 32	Handshake Ultimate Guard	Dimir Demons	A 5-0 start was a platform that kept him in the mix deep. He lasted until the penultimate round, when Yoshihiko Ikawa took him down.
5737	282	8	t	f	4	2	0	2	2	0	0	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	t	2	2	0	30	Top 32	Handshake Ultimate Guard	Azorius Oculus	5-2 D1, and live all the way to R13, where he lost to Shota Yasooka to end his chances.
6461	661	8	t	f	4	2	0	2	1	1	1	0	4	4	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	3	2	0	31	Top 32	Moriyama Japan	Dimir Midrange	Another Draft pod win to start, and a solid 5-2 overnight. Couldn't repeat on D2, going 3-4 to finish a respectable 8-6.
5640	228	8	t	f	3	3	0	2	1	1	0	0	5	3	0	8	6	0	8-6-0	5	2	0	3	4	0	0	0	0	f	2	2	0	32	Top 32	CFB Ultimate Guard	Dimir Midrange	5-2 overnight, but couldn't get things going during a 3-4 D2.
5463	137	8	t	f	2	4	0	2	1	1	0	1	5	2	0	7	6	0	7-6-0	4	3	0	3	3	0	0	0	0	f	3	3	0	35	Day 2		Azorius Oculus	A 4-3 D1 alternated wins and defeats, and winning his last three on D2 wasn't enough.
6331	589	8	t	f	4	2	0	2	2	0	0	0	3	4	1	7	6	1	7-6-1	4	3	0	3	3	1	0	0	0	f	3	3	0	38	Day 2	Moriyama Japan	Gruul Prowess	Won his last two on D1 to advance, but couldn't get things going D2.
5620	218	8	t	f	2	4	0	2	0	2	0	0	5	2	1	7	6	1	7-6-1	4	3	0	3	3	1	0	0	0	f	2	2	0	39	Day 2	Argentina+Spain	Azorius Oculus	Won his eliminator to reach D2, and cobbled together a 7-6-1 record overall.
5246	14	8	t	f	4	2	0	2	2	0	0	0	3	5	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	3	0	40	Day 2	Bus Stop + Sewer Rats	Boros Enchantments	Still alive at 6-4 with four rounds to go, three consecutive defeats, including Reid Duke, took him out of contention.
5576	200	8	t	f	2	3	0	2	0	1	0	0	4	4	0	6	7	0	6-7-0	4	3	0	2	4	0	0	0	0	f	3	4	0	44	Day 2	Worldly Counsel Heavy Play	Golgari Midrange	4-3 became 6-3, before Borja Yanez Carvajal beat him in both formats in the space of three rounds to end things.
6743	811	8	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	2	0	45	Day 2		Azorius Oculus	Alternated wins and losses throughout D1, could only add 3-4 on D2.
6551	701	8	t	f	3	3	0	2	1	1	0	0	4	4	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	2	2	0	46	Day 2	Rampant Growth Heavy Play	Domain Ramp	Had to win R7 to keep playing, then 3-4 D2.
7211	1036	8	t	f	2	4	0	2	1	1	0	1	5	3	0	7	7	0	7-7-0	4	3	0	3	4	0	0	0	0	f	3	3	0	48	Day 2	Sanctum of All	Temur Prowess	3-1 was good, and won three of the last four, but there were plenty of defeats in between, finishing 7-7.
6605	728	8	t	f	2	4	0	2	1	1	0	1	3	3	1	5	7	1	5-7-1	4	2	1	1	5	0	0	0	0	f	2	5	0	50	Day 2	Temple of Malady	Azorius Oculus	4-2-1 on D1, but had to wait until R14 for another match win.
7199	1030	8	t	f	4	2	0	2	1	1	1	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	3	0	51	Day 2	Rampant Growth Heavy Play	Domain Ramp	3-0 in Draft, but 1-3 in Std D1. Things didn't get much better D2.
5556	189	8	t	f	4	2	0	2	1	1	1	0	2	6	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	4	5	0	53	Day 2	CFB Ultimate Guard	Golgari Ramp	Perfect 3-0 start in draft, but 1-3 in Standard on D1, and only two further wins on D2.
7179	1020	8	t	f	3	3	0	2	1	1	0	0	3	5	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	4	0	54	Day 2	Sanctum of All	Temur Prowess	In a 1-3 hole, made D2. Kept fighting at 6-4, but soon out of the running down the stretch.
6136	491	8	t	f	2	4	0	2	0	2	0	0	4	4	0	6	8	0	6-8-0	4	3	0	2	5	0	0	0	0	f	3	2	0	55	Day 2	Moriyama Japan	Gruul Prowess	Reasonable 4-3 D1, but only a single win on D2.
6942	903	8	f	f	1	2	0	1	0	1	0	0	2	1	1	3	3	1	3-3-1	3	3	1	0	0	0	0	0	0	f	1	2	0	60	X	Milkshake	Domain Ramp	A frustrating D1, always up against it, and not quite advancing.
5844	346	8	f	f	3	0	0	1	1	0	1	0	0	4	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	4	0	61	X	Handshake Ultimate Guard	Dimir Demons	A day of two halves. Perfect in Draft, 3-0. Nothing in Standard, 0-4, no D2.
5401	107	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	3	0	63	X	Worldly Counsel Heavy Play	Jeskai Convoke	At 3-1, things looked good for D2, but his R4 win over Javier Dominguez was his last of D1, so no D2 appearance for the second WC running.
5786	310	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	66	X	Worldly Counsel Heavy Play	Jeskai Convoke	A tough D1, eliminated in R6.
6033	439	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	4	0	67	X	CFB Ultimate Guard	Dimir Midrange	After 2-1 in Draft, just one win in Standard, so no D2.
7103	988	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	70	X		Golgari Demons	2-0 and 3-2, but lost his last two to miss D2.
5796	312	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	71	X	Rampant Growth Heavy Play	Gruul Prowess	Stood at 3-3, before mini-nemesis Derrick Davis eliminated him from D2.
6425	643	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	72	X	Moriyama Japan	Gruul Prowess	Always struggling, had a R7 match to try to advance, but missed out.
5744	287	2	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	190	X			Lost R7 and R8 to finish one short.
5665	240	6	t	f	3	3	0	2	1	1	0	0	8	1	1	11	4	1	11-4-1	4	3	1	7	1	0	0	0	0	f	3	1	0	9	Top 16	Sanctum of All		Consistently won two and three matches at a time, but starting out 1-2 in Draft didn't help, and 8-1-1 in Standard wasn't quite enough.
6871	876	8	f	f	2	1	0	1	1	0	0	0	1	3	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	1	2	0	73	X	CFB Ultimate Guard	Golgari Ramp	Alternated wins and losses until R7, when a fourth loss kept him out of D2.
6659	765	8	f	f	1	2	0	1	0	1	0	0	2	2	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	2	2	0	75	X	French	Gruul Prowess	3-2, but lost his last two to miss out on D2.
5517	174	8	f	f	0	3	0	1	0	1	0	1	3	1	0	3	4	0	3-4-0	3	4	0	0	0	0	0	0	0	f	3	4	0	80	X	Bus Stop + Sewer Rats	Domain Ramp	Showed some fight, winning his last three, but he was already out after an 0-4 start.
6682	774	8	f	f	1	2	0	1	0	1	0	0	1	1	1	2	3	1	2-3-1	2	4	1	0	\N	0	0	0	0	f	1	2	0	85	X	Sanctum of All	Temur Prowess	One win in each format, not enough to come back for D2.
6190	514	8	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	2	3	0	86	X	Bus Stop + Sewer Rats	Gruul Prowess	2-1 Draft, but 0-3 Standard meant no D2.
6970	920	8	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	4	0	89	X	Worldly Counsel Heavy Play	Jeskai Convoke	From 2-1 in Draft, didn't win once in Standard, so no D2.
6206	516	8	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	91	X	Handshake Ultimate Guard	Dimir Demons	Only one win in each format, not enough for D2.
6093	468	8	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	92	X	Worldly Counsel Heavy Play	Gruul Prowess	One win in each format, eliminated in R6.
6002	423	8	f	f	0	3	0	1	0	1	0	1	1	2	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	3	0	95	X		Dimir Midrange	Couldn't recover from the worst possible 0-3 Draft start, with just a single win.
6185	513	8	f	f	1	2	0	1	0	1	0	0	1	2	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	1	2	0	96	X	Handshake Ultimate Guard	Dimir Demons	One win from each format, not close to D2.
5692	257	8	f	f	1	2	0	1	0	1	0	0	1	2	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	1	2	0	100	X		Domain Ramp	Never got going, out after R6.
6573	711	8	f	f	1	2	0	1	0	1	0	0	0	2	0	1	4	0	1-4-0	1	4	0	0	0	0	0	0	0	f	1	3	0	104	X	CFB Ultimate Guard	Golgari Ramp	Not a D1 to remember, with a single Draft win the only highlight.
7150	1011	8	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	111	X	Scoreboard	Domain Ramp	The perfect imperfect, 0-4 and out without a win.
7080	975	8	f	f	0	3	0	1	0	1	0	1	0	1	0	0	4	0	0-4-0	0	4	0	0	0	0	0	0	0	f	0	4	0	112	X	CFB Ultimate Guard	Golgari Ramp	For the second year running, didn't win a WC match.
5708	266	2	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	5	0	208	X			Began 2-0, but no more wins.
7270	310	10	t	f	3	3	0	2	1	1	0	0	7	3	0	10	6	0	10-6-0	6	2	0	4	4	0	0	0	0	f	5	3	1	46	Day 2	Cosmos Heavy Play	Azorius Omniscience	
5804	319	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	162	X			
5880	358	9	f	f	2	1	0	1	1	0	0	0	0	5	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	6	0	291	x	Cosmos Heavy Play	Golgari Obliterator	
5882	360	7	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	183	X			
5979	409	5	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	180	X			Lost the last two from 3-3, so no D2.
6013	429	2	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	168	X			2-1 in Draft, and then 3-2, but lost all three from there.
6079	462	3	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	4	4	0	103	Day 2			Very much a tournament of runs: a loss, four wins, three losses, three wins, four losses, and a win. All adding up to 8-8.
6168	505	1	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	6	2	0	3	5	0	0	0	0	f	3	2	0	61	Day 2			3-1 and 6-2 overnight, so a disappointing 3-5 on D2.
6180	512	1	t	f	1	5	0	2	0	2	0	1	6	4	0	7	9	0	7-9-0	4	4	0	3	5	0	0	0	0	f	3	3	0	120	Day 2			Did well to reach D2 after an 0-3 start in Draft. Positive takeaway was the 6-4 result in Pioneer.
6252	549	6	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	181	X			0-3 in Draft left too much to do.
6254	549	9	t	f	5	1	0	2	2	0	1	0	5	5	0	10	6	0	10-6-0	4	4	0	6	2	0	0	0	0	f	6	2	1	51	Day 2		Azorius Bunnicorn	
6526	693	2	t	f	5	1	0	2	2	0	1	0	4	6	0	9	7	0	9-7-0	4	4	0	5	3	0	0	0	0	f	3	2	0	72	Day 2			Twice won three in a row, including trophy in D2 Draft.
6630	745	5	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	235	X	Hatchel Poulosky Zilles		One win in each format.
6565	710	8	f	f	2	1	0	1	1	0	0	0	0	3	0	2	4	0	2-4-0	2	4	0	0	0	0	0	0	0	f	2	3	0	88	X	Scoreboard		
6576	713	1	t	f	4	1	1	2	1	0	1	0	4	5	1	8	6	2	8-6-2	4	3	1	4	3	1	0	0	0	f	3	2	0	78	Day 2			Solid 4-1-1 in Draft, but a losing record in Pioneer.
6587	723	2	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	216	X		Abzan Legends	Only one win in each format, so no D2.
6667	768	7	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	167	X	Temple of Malady		
6668	768	9	t	f	4	2	0	2	2	0	0	0	6	4	0	10	6	0	10-6-0	5	3	0	5	3	0	0	0	0	f	3	2	0	59	Day 2		Gruul Mice	
6622	739	1	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	5	0	196	X			Won two of last three, but was already 0-5 by then.
6695	783	3	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	204	X			Lost to Kim Berle in R8 elimination match.
6729	801	4	t	f	3	3	0	2	1	1	0	0	3	4	1	6	7	1	6-7-1	4	3	0	2	4	1	0	0	0	f	2	3	0	43	Day 2			From 4-2 to 4-5 and out of contention.
6800	831	9	t	f	3	3	0	2	1	1	0	0	6	4	0	9	7	0	9-7-0	5	3	0	4	4	0	0	0	0	f	3	2	0	95	Day 2		Jeskai Convoke	
6837	854	6	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	182	X	Worldly Counsel	Temur Analyst	1-4 was deep, deep trouble, and 2-5 was out.
6767	817	7	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	2	4	0	91	Day 2	Handshake Ultimate Guard		
6908	894	6	t	f	5	1	0	2	2	0	1	0	3	7	0	8	8	0	8-8-0	5	3	0	3	5	0	0	0	0	f	3	4	0	76	Day 2	Chen Chen Ji Sun		Trophy D1 Draft, and another 2-1 on D2, but a poor 3-7 in Standard.
7235	903	10	t	f	4	2	0	2	2	0	0	0	8	2	0	12	4	0	12-4-0	5	3	0	7	1	0	0	0	0	t	5	2	1	11	Top 16		Azorius Control	
7006	936	6	t	f	0	6	0	2	0	2	0	2	5	5	0	5	11	0	5-11-0	4	4	0	1	7	0	0	0	0	f	2	3	0	127	Day 2	Wu Hayne		Parity in Standard at 5-5, but a horrible 0-6 in Draft.
7081	976	3	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	177	X	CFB Ultimate Guard		Got to 3-3, then lost twice.
7189	1026	5	t	f	3	3	0	2	1	1	0	0	5	3	2	8	6	2	8-6-2	5	3	0	3	3	2	0	0	0	f	3	1	0	89	Day 2	Japan 2		3-1 was the highlight, then a steady mix of wins and losses, and a couple of late draws.
7347	1083	10	t	f	3	3	0	2	1	1	1	1	5	5	0	8	8	0	8-8-0	7	1	0	1	7	0	0	0	0	f	6	4	1	123	Day 2		Azorius Omniscience	
7487	1163	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	3	3	0	263	x		Izzet Prowess	
7549	1210	10	f	f	0	3	0	1	0	1	0	1	1	3	0	1	6	0	1-6-0	1	6	0	0	0	0	0	0	0	f	1	5	0	325	x	Flexslot Diamond	Jund Roots	
7552	1211	10	f	f	0	3	0	1	0	1	0	1	0	4	1	0	7	1	0-7-1	0	7	1	0	0	0	0	0	0	f	0	4	0	328	x		Azorius Omniscience	
7553	1212	10	f	f	0	3	0	1	0	1	0	1	0	3	0	0	6	0	0-6-0	0	6	0	0	0	0	0	0	0	f	0	6	0	329	x		Izzet Prowess	
7554	1213	10	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	330	x		Bant Omniscience	
7492	1166	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	268	x		Domain Overlords	
7494	1167	10	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	270	x	Italian Team	Azorius Omniscience	
7496	1168	10	f	f	0	3	0	1	0	1	0	1	3	2	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	272	x	Italian Team	Dimir Midrange	
7499	1169	10	f	f	1	1	1	1	0	0	0	0	1	4	0	2	5	1	2-5-1	2	5	1	0	0	0	0	0	0	f	2	4	0	275	x		Azorius Omniscience	
7500	1170	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	276	x		Orzhov Sacrifice	
7501	1171	10	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	277	x		Golgari Midrange	
7502	1172	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	278	x		Boros Mice	
7503	1173	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	279	x		Izzet Prowess	
7505	1175	10	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	2	0	281	x		Azorius Omniscience	
7506	1176	10	f	f	2	1	0	1	1	0	0	0	0	4	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	4	0	282	x		Orzhov Sacrifice	
7507	1177	10	f	f	1	2	0	1	0	1	0	0	1	3	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	1	3	0	283	x	Italian Team	Izzet Prowess	
7508	1178	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	4	0	284	x		Azorius Omniscience	
7510	1179	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	286	x	Moriyama Japan	Izzet Prowess	
5225	5	1	t	f	3	3	0	2	1	1	0	0	5	5	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	2	3	0	102	Day 2			Got to 3-1, then needed a R8 win to advance to D2. 4-4 again.
5223	3	1	f	f	2	1	0	1	1	0	0	0	1	4	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	2	3	0	149	X	Japan 2		2-1 in Draft, then 3-3 before two defeats to mean elimination D1.
5224	4	3	f	f	0	3	0	1	0	1	0	1	0	2	0	0	5	0	0-5-0	0	5	0	0	0	0	0	0	0	f	0	5	0	264	X	Alexander Johnson		Dropped at 0-5.
5221	1	7	f	f	1	2	0	1	0	1	0	0	0	3	1	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	3	0	222	X			Won R1, but no surprise to not make D2, given a run of Arne Huschenbeth, Shuhei Nakamura, and Kamiel Cornelissen.
5222	2	9	t	f	4	2	0	2	2	0	0	0	4	6	0	8	8	0	8-8-0	4	4	0	4	4	0	0	0	0	f	3	2	0	167	Day 2		Domain Overlords	Promising start at 3-1, so disappointing to advance to D2 at 4-4. A winning draft (2-1) again, but 4-6 in Standard meant an even finish.
5578	201	1	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	3	0	174	X			1-4 was too much to come back from, eliminated by Seth Manfield in R7
6606	729	1	f	f	1	1	1	1	0	0	0	0	2	3	0	3	4	1	3-4-1	3	4	1	0	0	0	0	0	0	f	2	2	0	137	X			Lost elimination match against Eliott Boussaud.
7069	972	6	f	f	1	2	0	1	0	1	0	0	2	3	0	3	5	0	3-5-0	3	5	0	0	0	0	0	0	0	f	1	2	0	147	X			Eliminated R7.
7521	1186	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	297	x		Izzet Prowess	
7522	1187	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	2	0	298	x		Izzet Cauldron	
7524	1188	10	f	f	0	3	0	1	0	1	0	1	2	2	0	2	5	0	2-5-0	2	5	0	0	0	0	0	0	0	f	2	3	0	300	x		Domain Overlords	
7525	1189	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	301	x		Azorius Omniscience	
7526	1190	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	302	x	Italian Team	Domain Overlords	
7527	1191	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	3	0	303	x		Gruul Delirium	
7528	1192	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	3	0	304	x	Rampant Growth Heavy Play	Azorius Omniscience	
7529	1193	10	f	f	0	3	0	1	0	1	0	1	2	3	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	2	5	0	305	x		Izzet Prowess	
7530	1194	10	f	f	1	2	0	1	0	1	0	0	1	4	0	2	6	0	2-6-0	2	6	0	0	0	0	0	0	0	f	1	4	0	306	x		Izzet Prowess	
7531	1195	10	f	f	1	1	1	1	0	0	0	0	0	3	0	1	4	1	1-4-1	1	4	1	0	0	0	0	0	0	f	1	3	0	307	x		Orzhov Pixie	
7533	1196	10	f	f	1	1	1	1	0	0	0	0	0	4	0	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	4	0	309	x	Rampant Growth Heavy Play	Izzet Prowess	
7534	1197	10	f	f	0	2	1	1	0	1	0	0	1	3	0	1	5	1	1-5-1	1	5	1	0	0	0	0	0	0	f	1	2	0	310	x		Jeskai Artifacts	
7535	1198	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	311	x		Dimir Midrange	
7536	1199	10	f	f	1	2	0	1	0	1	0	0	0	3	0	1	5	0	1-5-0	1	5	0	0	0	0	0	0	0	f	1	5	0	312	x		Izzet Prowess	
\.


--
-- Name: notable_qualifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notable_qualifications_id_seq', 833, true);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_id_seq', 1653, true);


--
-- Name: results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.results_id_seq', 11243, true);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: notable_qualifications notable_qualifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notable_qualifications
    ADD CONSTRAINT notable_qualifications_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: results results_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT results_pkey PRIMARY KEY (id);


--
-- Name: players uk_players_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT uk_players_name UNIQUE (first_name, last_name);


--
-- Name: results uk_results_player_event; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT uk_results_player_event UNIQUE (player_id, event_id);


--
-- Name: notable_qualifications uq_player_event_qualification; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notable_qualifications
    ADD CONSTRAINT uq_player_event_qualification UNIQUE (player_id, event_id);


--
-- Name: idx_notable_qual_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notable_qual_event_id ON public.notable_qualifications USING btree (event_id);


--
-- Name: idx_notable_qual_player_event; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notable_qual_player_event ON public.notable_qualifications USING btree (player_id, event_id);


--
-- Name: idx_notable_qual_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notable_qual_player_id ON public.notable_qualifications USING btree (player_id);


--
-- Name: idx_results_event_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_results_event_id ON public.results USING btree (event_id);


--
-- Name: idx_results_player_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_results_player_id ON public.results USING btree (player_id);


--
-- Name: notable_qualifications fk_notable_qual_event; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notable_qualifications
    ADD CONSTRAINT fk_notable_qual_event FOREIGN KEY (event_id) REFERENCES public.events(id) ON DELETE CASCADE;


--
-- Name: notable_qualifications fk_notable_qual_player; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notable_qualifications
    ADD CONSTRAINT fk_notable_qual_player FOREIGN KEY (player_id) REFERENCES public.players(id) ON DELETE CASCADE;


--
-- Name: results fk_results_event; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_results_event FOREIGN KEY (event_id) REFERENCES public.events(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: results fk_results_player; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.results
    ADD CONSTRAINT fk_results_player FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- PostgreSQL database dump complete
--

\unrestrict tXxCu5tWXIT1mAAzAdx4jYeEuXmvmhQycW3uNSIS6oSBIQdFsjrh2ERIDcdMYcL

