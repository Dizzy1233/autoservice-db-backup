-- ============================================================
-- SQL-скрипт для создания базы данных автосервиса
-- СУБД: Microsoft SQL Server (T-SQL)
-- Источники данных:
--   product_a_import.csv      — товары (продукция)
--   manufacturer_a_import.txt — производители
-- ============================================================

-- Создание базы данных (если не существует)
IF DB_ID(N'autoservice_db') IS NULL
    CREATE DATABASE autoservice_db;
GO

USE autoservice_db;
GO

-- ============================================================
-- Удаление существующих таблиц (в порядке зависимостей)
-- ============================================================
IF OBJECT_ID(N'product', N'U') IS NOT NULL
    DROP TABLE product;
GO

IF OBJECT_ID(N'manufacturer', N'U') IS NOT NULL
    DROP TABLE manufacturer;
GO

-- ============================================================
-- Таблица производителей
-- ============================================================
CREATE TABLE manufacturer (
    id_manufacturer  INT           IDENTITY(1,1) PRIMARY KEY,
    name             NVARCHAR(150) NOT NULL UNIQUE,
    start_date       DATE          NOT NULL
);
GO

-- ============================================================
-- Таблица товаров (продукции)
-- ============================================================
CREATE TABLE product (
    id_product       INT            PRIMARY KEY,
    name             NVARCHAR(500)  NOT NULL,
    main_image       NVARCHAR(500)  NULL,
    id_manufacturer  INT            NOT NULL,
    active           BIT            NOT NULL DEFAULT 1,
    price            DECIMAL(10,2)  NOT NULL,
    CONSTRAINT fk_product_manufacturer
        FOREIGN KEY (id_manufacturer)
        REFERENCES manufacturer(id_manufacturer)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
GO

-- ============================================================
-- Вставка данных в таблицу manufacturer
-- Даты приведены к формату YYYY-MM-DD
-- ============================================================
INSERT INTO manufacturer (name, start_date) VALUES
    (N'Profix',          '2017-10-02'),
    (N'Pierburg',        '2017-01-10'),
    (N'Honda',           '2016-06-12'),
    (N'Benson',          '2015-04-09'),
    (N'Mazda',           '2018-01-23'),
    (N'Zekkert',         '2018-03-08'),
    (N'Ferodo',          '2015-08-11'),
    (N'Lemforder',       '2016-11-15'),
    (N'Toyota',          '2016-06-03'),
    (N'Automega',        '2016-07-01'),
    (N'Magneti Marelli', '2017-05-27'),
    (N'Nissan',          '2015-01-21'),
    (N'Airline',         '2016-03-26'),
    (N'BILSTEIN',        '2018-03-06'),
    (N'Petro-Canada',    '2017-03-22'),
    (N'Bendix',          '2015-04-25'),
    (N'Mercedes',        '2016-03-16'),
    (N'Mitsubishi',      '2017-04-23'),
    (N'Motul',           '2018-01-07'),
    (N'Shell',           '2016-11-14'),
    (N'Liqui Moly',      '2015-03-24'),
    (N'Mando',           '2015-03-24'),
    (N'LUK',             '2015-12-02'),
    (N'76',              '2017-02-03'),
    (N'Kayaba',          '2016-02-08'),
    (N'Total',           '2015-03-05'),
    (N'ASHIKA',          '2018-06-13'),
    (N'VAG',             '2018-05-16'),
    (N'King Bearings',   '2016-09-12'),
    (N'Castrol',         '2015-04-16'),
    (N'Hyundai/Kia',     '2016-01-07'),
    (N'Opel',            '2015-03-04'),
    (N'Idemitsu',        '2018-01-21'),
    (N'Stels',           '2017-05-16'),
    (N'BOGE',            '2016-01-18'),
    (N'Glaser',          '2015-12-29'),
    (N'Goodyear',        '2015-12-05'),
    (N'Suzuki',          '2017-05-18'),
    (N'ZIMMERMANN',      '2017-12-14'),
    (N'Mobil',           '2016-10-24'),
    (N'OPTIMAL',         '2016-08-19'),
    (N'ZIC',             '2015-02-07'),
    (N'Ford',            '2016-10-12'),
    (N'General Motors',  '2016-10-05'),
    (N'KASHIYAMA',       '2015-10-16'),
    (N'ALCA',            '2016-10-01'),
    (N'Airtex',          '2015-10-21'),
    (N'Elf',             '2016-10-16'),
    (N'BOSCH',           '2017-06-21'),
    (N'Lukoil',          '2017-12-19');
GO

-- ============================================================
-- Вставка данных в таблицу product
-- id_manufacturer определяется через JOIN с таблицей manufacturer
-- Используется INSERT...SELECT, т.к. T-SQL не поддерживает
--   подзапросы внутри INSERT...VALUES
-- ============================================================

-- Вспомогательная таблица для временного хранения данных товара
CREATE TABLE #product_staging (
    id_product  INT,
    name        NVARCHAR(500),
    main_image  NVARCHAR(500),
    mfr_name    NVARCHAR(150),
    active      BIT,
    price       DECIMAL(10,2)
);
GO

INSERT INTO #product_staging (id_product, name, main_image, mfr_name, active, price) VALUES
    (1,   N'Моторное масло Motor Oil KE900-90042-R',                     N'Товары автосервиса\8FE07916.jpg',  N'Nissan',         1, 2060.00),
    (2,   N'Моторное масло Helix Ultra 550046361',                        N'Товары автосервиса\F310E078.jpg',  N'Shell',           1, 2120.00),
    (3,   N'Моторное масло Super 3000 X1 152566',                         N'Товары автосервиса\6CA0BE73.jpg',  N'Mobil',           0, 1820.00),
    (4,   N'Моторное масло Turbo SYN Gasoline 05100-00441',               N'Товары автосервиса\2B009062.jpg',  N'Hyundai/Kia',     1, 1870.00),
    (5,   N'Моторное масло Dexos 2 95599405',                             N'Товары автосервиса\AD00B713.jpg',  N'General Motors',  1, 1410.00),
    (6,   N'Моторное масло Molygen New Generation 9054',                  N'Товары автосервиса\0DF0A8A4.jpg',  N'Liqui Moly',      1, 2670.00),
    (7,   N'Моторное масло Top Tec 4600 8033',                            N'Товары автосервиса\B790A6AA.jpg',  N'Liqui Moly',      0, 2580.00),
    (8,   N'Моторное масло ENGINE OIL 08880-80375-GO',                    N'Товары автосервиса\CC40C869.jpg',  N'Toyota',          0, 2710.00),
    (9,   N'Моторное масло Mobil 1 ESP 154285',                           N'Товары автосервиса\F490E078.jpg',  N'Mobil',           1, 2890.00),
    (10,  N'Моторное масло Dexos 2 93165557',                             N'Товары автосервиса\45908C52.jpg',  N'General Motors',  1, 1500.00),
    (11,  N'Моторное масло Super 3000 X1 Diesel 152572',                  N'Товары автосервиса\B0A0C186.jpg',  N'Mobil',           1, 1870.00),
    (12,  N'Моторное масло ENGINE OIL MZ 320754',                         N'Товары автосервиса\3B70C57C.jpg',  N'Mitsubishi',      1, 2140.00),
    (13,  N'Моторное масло Genesis Armortech 3148675',                    N'Товары автосервиса\C9C0F036.jpg',  N'Lukoil',          0, 1660.00),
    (14,  N'Моторное масло Optimal Synth 3926',                           N'Товары автосервиса\EFC05011.jpg',  N'Liqui Moly',      1, 1880.00),
    (15,  N'Моторное масло Optimal Synth 2293',                           N'Товары автосервиса\C310B9F3.jpg',  N'Liqui Moly',      1, 2520.00),
    (16,  N'Моторное масло Evolution 900 SXR 194878',                     N'Товары автосервиса\E320BB7C.jpg',  N'Elf',             1, 2010.00),
    (17,  N'Моторное масло Special C G 055 167 M4',                       N'Товары автосервиса\6730A31C.jpg',  N'VAG',             1, 4720.00),
    (18,  N'Моторное масло Longlife III G 052 195 M2',                    N'Товары автосервиса\E5507A37.jpg',  N'VAG',             1, 1910.00),
    (19,  N'Моторное масло Special Tec LL 8055',                          N'Товары автосервиса\B590AA7B.jpg',  N'Liqui Moly',      0, 2420.00),
    (20,  N'Моторное масло Dexos 2 19 42 002',                            N'Товары автосервиса\23F0848B.jpg',  N'Opel',            1, 1300.00),
    (21,  N'Моторное масло Gasoline Fully-Synthetic 30021326-746',        N'Товары автосервиса\27B0C883.jpg',  N'Idemitsu',        1, 1650.00),
    (22,  N'Моторное масло Formula F 15595E',                             N'Товары автосервиса\5250C855.jpg',  N'Ford',            0, 1750.00),
    (23,  N'Моторное масло Zepro Euro Spec SN/CF 1849-004',               N'Товары автосервиса\90D0B807.jpg',  N'Idemitsu',        1, 2400.00),
    (24,  N'Моторное масло SN 08880-10705',                               N'Товары автосервиса\43909176.jpg',  N'Toyota',          1, 2200.00),
    (25,  N'Моторное масло Motor Oil KE900-90042',                        N'Товары автосервиса\90505D31.jpg',  N'Nissan',          1, 2020.00),
    (26,  N'Моторное масло Evolution 900 SXR 194839',                     N'Товары автосервиса\F8E0B138.jpg',  N'Elf',             0, 2340.00),
    (27,  N'Моторное масло SN/GF-5 SN5W30C',                              N'Товары автосервиса\5A30A7EE.jpg',  N'Profix',          1, 1550.00),
    (28,  N'Моторное масло Evolution 900 SXR 194877',                     N'Товары автосервиса\E3A0B18A.jpg',  N'Elf',             1, 2470.00),
    (29,  N'Трос буксировочный 12 тонн 54384',                            N'Товары автосервиса\9750DA76.jpg',  N'Stels',           1, 410.00),
    (30,  N'Моторное масло Molygen New Generation 9042',                  N'Товары автосервиса\0D60A8A4.jpg',  N'Liqui Moly',      1, 2510.00),
    (31,  N'Моторное масло QUARTZ INEO ECS 166252',                       N'Товары автосервиса\D0D08F32.jpg',  N'Total',           1, 1600.00),
    (32,  N'Моторное масло Motor Oil KE900-90032-R',                      N'Товары автосервиса\54B0795D.jpg',  N'Nissan',          1, 1450.00),
    (33,  N'Моторное масло Original oil Ultra 8300-77-992',               N'Товары автосервиса\EF80D790.jpg',  N'Mazda',           0, 2770.00),
    (34,  N'Моторное масло Longlife III G 052 195 M4',                    N'Товары автосервиса\D9605006.jpg',  N'VAG',             1, 4100.00),
    (35,  N'Моторное масло 8100 X-CESS 102870',                           N'Товары автосервиса\E9308929.jpg',  N'Motul',           1, 3190.00),
    (36,  N'Моторное масло Magnatec A5 15583D',                           N'Товары автосервиса\9380C1E7.jpg',  N'Castrol',         1, 2220.00),
    (37,  N'Щетка для снега со съемным скребком GY000202',                N'Товары автосервиса\3760D73F.jpg',  N'Goodyear',        1, 350.00),
    (38,  N'Моторное масло Magnatec A3/B4 156E9E',                        N'Товары автосервиса\92C0C1E7.jpg',  N'Castrol',         1, 2130.00),
    (39,  N'Моторное масло Dexos 2 19 42 000',                            N'Товары автосервиса\2390848B.jpg',  N'Opel',            1, 1410.00),
    (40,  N'Моторное масло QUARTZ 9000 FUTURE NFC 171839',                N'Товары автосервиса\D2508F32.jpg',  N'Total',           1, 1560.00),
    (41,  N'Моторное масло Premium DPF Diesel 05200-00120',               N'Товары автосервиса\2D709062.jpg',  N'Hyundai/Kia',     1, 1460.00),
    (42,  N'Моторное масло Special G G 052 502 M2',                       N'Товары автосервиса\E0D0E079.jpg',  N'VAG',             1, 1820.00),
    (43,  N'Моторное масло Ecstar F9000 99M00-22R02-004',                 N'Товары автосервиса\21B0E533.jpg',  N'Suzuki',          1, 2330.00),
    (44,  N'Моторное масло Genesis Armortech 1539424',                    N'Товары автосервиса\B0F0CB59.jpg',  N'Lukoil',          1, 1710.00),
    (45,  N'Моторное масло Helix Ultra 550046387',                        N'Товары автосервиса\F2B0E078.jpg',  N'Shell',           0, 2160.00),
    (46,  N'Моторное масло Super 3000 X1 152567',                         N'Товары автосервиса\F200BC2F.jpg',  N'Mobil',           1, 1550.00),
    (47,  N'Моторное масло ENGINE OIL MZ 320753',                         N'Товары автосервиса\5BB0C351.jpg',  N'Mitsubishi',      0, 1590.00),
    (48,  N'Моторное масло Mobil 1 ESP Formula 152621',                   N'Товары автосервиса\DC70BEC3.jpg',  N'Mobil',           0, 2920.00),
    (49,  N'Моторное масло Genuine A000989790211BIFR',                    N'Товары автосервиса\2E30E06C.jpg',  N'Mercedes',        0, 1530.00),
    (50,  N'Моторное масло ULTRA 152624',                                 N'Товары автосервиса\BA30C186.jpg',  N'Mobil',           1, 1940.00),
    (51,  N'Моторное масло Super 3000 X1 Formula FE 152564',              N'Товары автосервиса\59B0BE73.jpg',  N'Mobil',           1, 1890.00),
    (52,  N'Моторное масло Zepro Euro Spec SN/CF 1849-001',               N'Товары автосервиса\90A0B807.jpg',  N'Idemitsu',        1, 1730.00),
    (53,  N'Моторное масло Helix Ultra 550046367',                        N'Товары автосервиса\F2E0E078.jpg',  N'Shell',           0, 1650.00),
    (54,  N'Моторное масло QUARTZ 9000 FUTURE NFC 183199',                N'Товары автосервиса\6CE0A012.jpg',  N'Total',           1, 2040.00),
    (55,  N'Моторное масло Dexos 2 93165554',                             N'Товары автосервиса\45008C52.jpg',  N'General Motors',  1, 1380.00),
    (56,  N'Моторное масло Formula F Fuel Economy HC 155D4B',             N'Товары автосервиса\39A0C188.jpg',  N'Ford',            1, 1450.00),
    (57,  N'Моторное масло 76 08880-803ENGINE OIL-GO',                    N'Товары автосервиса\0070C563.jpg',  N'Toyota',          1, 1630.00),
    (58,  N'Моторное масло QUARTZ 9000 FUTURE NFC 183450',                N'Товары автосервиса\FA90B138.jpg',  N'Total',           1, 1660.00),
    (59,  N'Моторное масло Top Tec 4100 7501',                            N'Товары автосервиса\022096CB.jpg',  N'Liqui Moly',      1, 2580.00),
    (60,  N'Моторное масло Mobil 1 ESP 154279',                           N'Товары автосервиса\F460E078.jpg',  N'Mobil',           1, 1860.00),
    (61,  N'Моторное масло Super 3000 X1 152061',                         N'Товары автосервиса\40409946.jpg',  N'Mobil',           1, 2010.00),
    (62,  N'Моторное масло Super Extra Gasoline 05100-00410',             N'Товары автосервиса\2A109062.jpg',  N'Hyundai/Kia',     1, 1230.00),
    (63,  N'Моторное масло Dexos 2 93165556',                             N'Товары автосервиса\43E08C52.jpg',  N'General Motors',  1, 1340.00),
    (64,  N'Моторное масло Leichtlauf Special AA 7516',                   N'Товары автосервиса\47E07CB5.jpg',  N'Liqui Moly',      1, 2360.00),
    (65,  N'Моторное масло Helix HX8 A5/B5 550046777',                    N'Товары автосервиса\F160E078.jpg',  N'Shell',           1, 1530.00),
    (66,  N'Моторное масло Fuel Economy 08880-80845',                      N'Товары автосервиса\23106A35.jpg',  N'Toyota',          1, 2560.00),
    (67,  N'Моторное масло 76 Top Tec 420061',                            N'Товары автосервиса\03D096CB.jpg',  N'Liqui Moly',      1, 3440.00),
    (68,  N'Моторное масло X9 162613',                                    N'Товары автосервиса\30E0C751.jpg',  N'ZIC',             1, 1530.00),
    (69,  N'Моторное масло EDGE Professional LL III Titanium FST 157AD6', N'Товары автосервиса\96E0C1E7.jpg',  N'Castrol',         1, 1760.00),
    (70,  N'Моторное масло Magnatec A3/B4 156E9D',                        N'Товары автосервиса\9290C1E7.jpg',  N'Castrol',         1, 1610.00),
    (71,  N'Моторное масло Genuine A000989790213BIFR',                    N'Товары автосервиса\2E60E06C.jpg',  N'Mercedes',        1, 2390.00),
    (72,  N'Моторное масло Supreme Synthetic MOSYN53C16',                 N'Товары автосервиса\69C0CD62.jpg',  N'Petro-Canada',    1, 1910.00),
    (73,  N'Моторное масло Helix Ultra Pro AM-L 550046353',               N'Товары автосервиса\3DF0E4BC.jpg',  N'Shell',           1, 2110.00),
    (74,  N'Моторное масло QUARTZ INEO ECS 151510',                       N'Товары автосервиса\8F609ED7.jpg',  N'Total',           1, 1920.00),
    (75,  N'Моторное масло Original oil Ultra 0530-05-TFE',               N'Товары автосервиса\85C04040.jpg',  N'Mazda',           1, 2930.00),
    (76,  N'Моторное масло QUARTZ 9000 ENERGY HKS 175393',                N'Товары автосервиса\6DD0A012.jpg',  N'Total',           1, 2830.00),
    (77,  N'Моторное масло Ultra LEO-SN 08217-99974',                     N'Товары автосервиса\97809225.jpg',  N'Honda',           1, 2980.00),
    (78,  N'Моторное масло Special G G 052 502 M4',                       N'Товары автосервиса\E0A0E079.jpg',  N'VAG',             1, 3090.00),
    (79,  N'Моторное масло Люкс 207465',                                  N'Товары автосервиса\8E20A863.jpg',  N'Lukoil',          1, 1090.00),
    (80,  N'Жилет светоотражающий взрослый ARW-AV-02',                    N'Товары автосервиса\D4D0CE67.jpg',  N'Airline',         1, 150.00),
    (81,  N'Моторное масло Premium LF Gasoline 05100-00451',              N'Товары автосервиса\2B609062.jpg',  N'Hyundai/Kia',     1, 1620.00),
    (82,  N'Моторное масло Evolution 900 SXR 10160501',                   N'Товары автосервиса\BD80E8D5.jpg',  N'Elf',             1, 1750.00),
    (83,  N'Моторное масло Zepro Touring 1845-004',                       N'Товары автосервиса\5180B90E.jpg',  N'Idemitsu',        1, 2380.00),
    (84,  N'Моторное масло 76 A000989PKW Motorenol0213BLER',              N'Товары автосервиса\2E00E06C.jpg',  N'Mercedes',        1, 2510.00),
    (85,  N'Моторное масло QUARTZ 9000 ENERGY HKS 175392',                N'Товары автосервиса\6DA0A012.jpg',  N'Total',           0, 1530.00),
    (86,  N'Моторное масло Formula F 155D3A',                             N'Товары автосервиса\39D0C188.jpg',  N'Ford',            1, 1830.00),
    (87,  N'Моторное масло Mobil 1 FS 153692',                            N'Товары автосервиса\6080DCD5.jpg',  N'Mobil',           1, 3020.00),
    (88,  N'Моторное масло Zepro Eco Medalist 3583-004',                  N'Товары автосервиса\3DA0B713.jpg',  N'Idemitsu',        1, 2520.00),
    (89,  N'Моторное масло SN 08880-10706',                               N'Товары автосервиса\43C09176.jpg',  N'Toyota',          1, 1640.00),
    (90,  N'Моторное масло Dexos 2 19 42 003',                            N'Товары автосервиса\8430842A.jpg',  N'Opel',            1, 1490.00),
    (91,  N'Моторное масло ENGINE OIL 08880-80365-GO',                    N'Товары автосервиса\CC10C869.jpg',  N'Toyota',          1, 3580.00),
    (92,  N'Моторное масло EDGE LL Titanium FST 15669A',                  N'Товары автосервиса\8BC0C1A9.jpg',  N'Castrol',         1, 3000.00),
    (93,  N'Моторное масло QUARTZ 9000 148597',                           N'Товары автосервиса\8F909ED7.jpg',  N'Total',           0, 1700.00),
    (94,  N'Моторное масло ENGINE OIL MZ 320756',                         N'Товары автосервиса\5BE0C351.jpg',  N'Mitsubishi',      0, 1600.00),
    (95,  N'Кредитница Кожа B6 6 95 1349',                                N'Товары автосервиса\63C09E91.jpg',  N'Mercedes',        1, 6770.00),
    (96,  N'Моторное масло Zepro Touring 1845-001',                       N'Товары автосервиса\7B70B9C6.jpg',  N'Idemitsu',        1, 1720.00),
    (97,  N'Моторное масло ENGINE OIL MZ 320757',                         N'Товары автосервиса\0D30C4EE.jpg',  N'Mitsubishi',      1, 2210.00),
    (98,  N'Моторное масло Zepro Eco Medalist 3583-001',                  N'Товары автосервиса\6800BB8A.jpg',  N'Idemitsu',        1, 1770.00),
    (99,  N'Моторное масло Premium DPF Diesel 05200-00620',               N'Товары автосервиса\9B3075EB.jpg',  N'Hyundai/Kia',     1, 2470.00),
    (100, N'Моторное масло QUARTZ 9000 FUTURE NFC 10230501',             N'Товары автосервиса\3970E753.jpg',  N'Total',           0, 1650.00);
GO

-- Перенос из временной таблицы в product с разрешением id_manufacturer через JOIN
INSERT INTO product (id_product, name, main_image, id_manufacturer, active, price)
SELECT
    s.id_product,
    s.name,
    s.main_image,
    m.id_manufacturer,
    s.active,
    s.price
FROM #product_staging s
INNER JOIN manufacturer m ON s.mfr_name = m.name;
GO

-- Удаление временной таблицы
DROP TABLE #product_staging;
GO

-- ============================================================
-- Индексы для ускорения запросов
-- ============================================================
CREATE NONCLUSTERED INDEX idx_product_manufacturer ON product(id_manufacturer);
CREATE NONCLUSTERED INDEX idx_product_active       ON product(active);
CREATE NONCLUSTERED INDEX idx_product_price        ON product(price);
CREATE NONCLUSTERED INDEX idx_manufacturer_name    ON manufacturer(name);
GO

-- ============================================================
-- Проверка: количество записей в таблицах
-- ============================================================
SELECT 'manufacturer' AS [Таблица], COUNT(*) AS [Записей] FROM manufacturer
UNION ALL
SELECT 'product', COUNT(*) FROM product;
GO
