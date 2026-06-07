-- ============================================================
-- SQL-скрипт для создания базы данных автосервиса
-- Источники данных:
--   product_a_import.csv      — товары (продукция)
--   manufacturer_a_import.txt — производители
-- ============================================================

-- Создание базы данных
CREATE DATABASE IF NOT EXISTS autoservice_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE autoservice_db;

-- ============================================================
-- Таблица производителей
-- ============================================================
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS manufacturer;

CREATE TABLE manufacturer (
    id_manufacturer  INT           AUTO_INCREMENT PRIMARY KEY,
    name             VARCHAR(150)  NOT NULL UNIQUE,
    start_date       DATE          NOT NULL
) ENGINE=InnoDB;

-- ============================================================
-- Таблица товаров (продукции)
-- ============================================================
CREATE TABLE product (
    id_product       INT           PRIMARY KEY,
    name             VARCHAR(500)  NOT NULL,
    main_image       VARCHAR(500),
    id_manufacturer  INT           NOT NULL,
    active           TINYINT(1)    NOT NULL DEFAULT 1,
    price            DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_product_manufacturer
        FOREIGN KEY (id_manufacturer)
        REFERENCES manufacturer(id_manufacturer)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
-- Вставка данных в таблицу manufacturer
-- Даты приведены к формату YYYY-MM-DD
-- ============================================================
INSERT INTO manufacturer (name, start_date) VALUES
    ('Profix',          '2017-10-02'),
    ('Pierburg',        '2017-01-10'),
    ('Honda',           '2016-06-12'),
    ('Benson',          '2015-04-09'),
    ('Mazda',           '2018-01-23'),
    ('Zekkert',         '2018-03-08'),
    ('Ferodo',          '2015-08-11'),
    ('Lemforder',       '2016-11-15'),
    ('Toyota',          '2016-06-03'),
    ('Automega',        '2016-07-01'),
    ('Magneti Marelli', '2017-05-27'),
    ('Nissan',          '2015-01-21'),
    ('Airline',         '2016-03-26'),
    ('BILSTEIN',        '2018-03-06'),
    ('Petro-Canada',    '2017-03-22'),
    ('Bendix',          '2015-04-25'),
    ('Mercedes',        '2016-03-16'),
    ('Mitsubishi',      '2017-04-23'),
    ('Motul',           '2018-01-07'),
    ('Shell',           '2016-11-14'),
    ('Liqui Moly',      '2015-03-24'),
    ('Mando',           '2015-03-24'),
    ('LUK',             '2015-12-02'),
    ('76',              '2017-02-03'),
    ('Kayaba',          '2016-02-08'),
    ('Total',           '2015-03-05'),
    ('ASHIKA',          '2018-06-13'),
    ('VAG',             '2018-05-16'),
    ('King Bearings',   '2016-09-12'),
    ('Castrol',         '2015-04-16'),
    ('Hyundai/Kia',     '2016-01-07'),
    ('Opel',            '2015-03-04'),
    ('Idemitsu',        '2018-01-21'),
    ('Stels',           '2017-05-16'),
    ('BOGE',            '2016-01-18'),
    ('Glaser',          '2015-12-29'),
    ('Goodyear',        '2015-12-05'),
    ('Suzuki',          '2017-05-18'),
    ('ZIMMERMANN',      '2017-12-14'),
    ('Mobil',           '2016-10-24'),
    ('OPTIMAL',         '2016-08-19'),
    ('ZIC',             '2015-02-07'),
    ('Ford',            '2016-10-12'),
    ('General Motors',  '2016-10-05'),
    ('KASHIYAMA',       '2015-10-16'),
    ('ALCA',            '2016-10-01'),
    ('Airtex',          '2015-10-21'),
    ('Elf',             '2016-10-16'),
    ('BOSCH',           '2017-06-21'),
    ('Lukoil',          '2017-12-19');

-- ============================================================
-- Вставка данных в таблицу product
-- id_manufacturer определяется по названию производителя
--   через подзапрос (SELECT id_manufacturer FROM manufacturer WHERE name = ...)
-- ============================================================
INSERT INTO product (id_product, name, main_image, id_manufacturer, active, price) VALUES
    (1,  'Моторное масло Motor Oil KE900-90042-R',                         'Товары автосервиса\\8FE07916.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Nissan'),         1, 2060.00),
    (2,  'Моторное масло Helix Ultra 550046361',                            'Товары автосервиса\\F310E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Shell'),           1, 2120.00),
    (3,  'Моторное масло Super 3000 X1 152566',                             'Товары автосервиса\\6CA0BE73.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           0, 1820.00),
    (4,  'Моторное масло Turbo SYN Gasoline 05100-00441',                   'Товары автосервиса\\2B009062.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Hyundai/Kia'),     1, 1870.00),
    (5,  'Моторное масло Dexos 2 95599405',                                 'Товары автосервиса\\AD00B713.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'General Motors'),  1, 1410.00),
    (6,  'Моторное масло Molygen New Generation 9054',                      'Товары автосервиса\\0DF0A8A4.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 2670.00),
    (7,  'Моторное масло Top Tec 4600 8033',                                'Товары автосервиса\\B790A6AA.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      0, 2580.00),
    (8,  'Моторное масло ENGINE OIL 08880-80375-GO',                        'Товары автосервиса\\CC40C869.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          0, 2710.00),
    (9,  'Моторное масло Mobil 1 ESP 154285',                               'Товары автосервиса\\F490E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 2890.00),
    (10, 'Моторное масло Dexos 2 93165557',                                 'Товары автосервиса\\45908C52.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'General Motors'),  1, 1500.00),
    (11, 'Моторное масло Super 3000 X1 Diesel 152572',                      'Товары автосервиса\\B0A0C186.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 1870.00),
    (12, 'Моторное масло ENGINE OIL MZ 320754',                             'Товары автосервиса\\3B70C57C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mitsubishi'),      1, 2140.00),
    (13, 'Моторное масло Genesis Armortech 3148675',                        'Товары автосервиса\\C9C0F036.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Lukoil'),          0, 1660.00),
    (14, 'Моторное масло Optimal Synth 3926',                               'Товары автосервиса\\EFC05011.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 1880.00),
    (15, 'Моторное масло Optimal Synth 2293',                               'Товары автосервиса\\C310B9F3.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 2520.00),
    (16, 'Моторное масло Evolution 900 SXR 194878',                         'Товары автосервиса\\E320BB7C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Elf'),             1, 2010.00),
    (17, 'Моторное масло Special C G 055 167 M4',                           'Товары автосервиса\\6730A31C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'VAG'),             1, 4720.00),
    (18, 'Моторное масло Longlife III G 052 195 M2',                        'Товары автосервиса\\E5507A37.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'VAG'),             1, 1910.00),
    (19, 'Моторное масло Special Tec LL 8055',                              'Товары автосервиса\\B590AA7B.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      0, 2420.00),
    (20, 'Моторное масло Dexos 2 19 42 002',                                'Товары автосервиса\\23F0848B.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Opel'),            1, 1300.00),
    (21, 'Моторное масло Gasoline Fully-Synthetic 30021326-746',            'Товары автосервиса\\27B0C883.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 1650.00),
    (22, 'Моторное масло Formula F 15595E',                                 'Товары автосервиса\\5250C855.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Ford'),            0, 1750.00),
    (23, 'Моторное масло Zepro Euro Spec SN/CF 1849-004',                   'Товары автосервиса\\90D0B807.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 2400.00),
    (24, 'Моторное масло SN 08880-10705',                                   'Товары автосервиса\\43909176.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          1, 2200.00),
    (25, 'Моторное масло Motor Oil KE900-90042',                            'Товары автосервиса\\90505D31.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Nissan'),          1, 2020.00),
    (26, 'Моторное масло Evolution 900 SXR 194839',                         'Товары автосервиса\\F8E0B138.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Elf'),             0, 2340.00),
    (27, 'Моторное масло SN/GF-5 SN5W30C',                                  'Товары автосервиса\\5A30A7EE.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Profix'),          1, 1550.00),
    (28, 'Моторное масло Evolution 900 SXR 194877',                         'Товары автосервиса\\E3A0B18A.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Elf'),             1, 2470.00),
    (29, 'Трос буксировочный 12 тонн 54384',                                'Товары автосервиса\\9750DA76.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Stels'),           1, 410.00),
    (30, 'Моторное масло Molygen New Generation 9042',                      'Товары автосервиса\\0D60A8A4.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 2510.00),
    (31, 'Моторное масло QUARTZ INEO ECS 166252',                           'Товары автосервиса\\D0D08F32.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 1600.00),
    (32, 'Моторное масло Motor Oil KE900-90032-R',                          'Товары автосервиса\\54B0795D.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Nissan'),          1, 1450.00),
    (33, 'Моторное масло Original oil Ultra 8300-77-992',                   'Товары автосервиса\\EF80D790.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mazda'),           0, 2770.00),
    (34, 'Моторное масло Longlife III G 052 195 M4',                        'Товары автосервиса\\D9605006.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'VAG'),             1, 4100.00),
    (35, 'Моторное масло 8100 X-CESS 102870',                               'Товары автосервиса\\E9308929.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Motul'),           1, 3190.00),
    (36, 'Моторное масло Magnatec A5 15583D',                               'Товары автосервиса\\9380C1E7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Castrol'),         1, 2220.00),
    (37, 'Щетка для снега со съемным скребком GY000202',                    'Товары автосервиса\\3760D73F.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Goodyear'),        1, 350.00),
    (38, 'Моторное масло Magnatec A3/B4 156E9E',                            'Товары автосервиса\\92C0C1E7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Castrol'),         1, 2130.00),
    (39, 'Моторное масло Dexos 2 19 42 000',                                'Товары автосервиса\\2390848B.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Opel'),            1, 1410.00),
    (40, 'Моторное масло QUARTZ 9000 FUTURE NFC 171839',                    'Товары автосервиса\\D2508F32.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 1560.00),
    (41, 'Моторное масло Premium DPF Diesel 05200-00120',                   'Товары автосервиса\\2D709062.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Hyundai/Kia'),     1, 1460.00),
    (42, 'Моторное масло Special G G 052 502 M2',                           'Товары автосервиса\\E0D0E079.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'VAG'),             1, 1820.00),
    (43, 'Моторное масло Ecstar F9000 99M00-22R02-004',                     'Товары автосервиса\\21B0E533.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Suzuki'),          1, 2330.00),
    (44, 'Моторное масло Genesis Armortech 1539424',                        'Товары автосервиса\\B0F0CB59.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Lukoil'),          1, 1710.00),
    (45, 'Моторное масло Helix Ultra 550046387',                            'Товары автосервиса\\F2B0E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Shell'),           0, 2160.00),
    (46, 'Моторное масло Super 3000 X1 152567',                             'Товары автосервиса\\F200BC2F.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 1550.00),
    (47, 'Моторное масло ENGINE OIL MZ 320753',                             'Товары автосервиса\\5BB0C351.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mitsubishi'),      0, 1590.00),
    (48, 'Моторное масло Mobil 1 ESP Formula 152621',                       'Товары автосервиса\\DC70BEC3.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           0, 2920.00),
    (49, 'Моторное масло Genuine A000989790211BIFR',                        'Товары автосервиса\\2E30E06C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mercedes'),        0, 1530.00),
    (50, 'Моторное масло ULTRA 152624',                                     'Товары автосервиса\\BA30C186.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 1940.00),
    (51, 'Моторное масло Super 3000 X1 Formula FE 152564',                  'Товары автосервиса\\59B0BE73.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 1890.00),
    (52, 'Моторное масло Zepro Euro Spec SN/CF 1849-001',                   'Товары автосервиса\\90A0B807.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 1730.00),
    (53, 'Моторное масло Helix Ultra 550046367',                            'Товары автосервиса\\F2E0E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Shell'),           0, 1650.00),
    (54, 'Моторное масло QUARTZ 9000 FUTURE NFC 183199',                    'Товары автосервиса\\6CE0A012.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 2040.00),
    (55, 'Моторное масло Dexos 2 93165554',                                 'Товары автосервиса\\45008C52.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'General Motors'),  1, 1380.00),
    (56, 'Моторное масло Formula F Fuel Economy HC 155D4B',                 'Товары автосервиса\\39A0C188.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Ford'),            1, 1450.00),
    (57, 'Моторное масло 76 08880-803ENGINE OIL-GO',                        'Товары автосервиса\\0070C563.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          1, 1630.00),
    (58, 'Моторное масло QUARTZ 9000 FUTURE NFC 183450',                    'Товары автосервиса\\FA90B138.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 1660.00),
    (59, 'Моторное масло Top Tec 4100 7501',                                'Товары автосервиса\\022096CB.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 2580.00),
    (60, 'Моторное масло Mobil 1 ESP 154279',                               'Товары автосервиса\\F460E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 1860.00),
    (61, 'Моторное масло Super 3000 X1 152061',                             'Товары автосервиса\\40409946.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 2010.00),
    (62, 'Моторное масло Super Extra Gasoline 05100-00410',                 'Товары автосервиса\\2A109062.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Hyundai/Kia'),     1, 1230.00),
    (63, 'Моторное масло Dexos 2 93165556',                                 'Товары автосервиса\\43E08C52.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'General Motors'),  1, 1340.00),
    (64, 'Моторное масло Leichtlauf Special AA 7516',                       'Товары автосервиса\\47E07CB5.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 2360.00),
    (65, 'Моторное масло Helix HX8 A5/B5 550046777',                        'Товары автосервиса\\F160E078.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Shell'),           1, 1530.00),
    (66, 'Моторное масло Fuel Economy 08880-80845',                          'Товары автосервиса\\23106A35.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          1, 2560.00),
    (67, 'Моторное масло 76 Top Tec 420061',                                'Товары автосервиса\\03D096CB.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Liqui Moly'),      1, 3440.00),
    (68, 'Моторное масло X9 162613',                                        'Товары автосервиса\\30E0C751.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'ZIC'),             1, 1530.00),
    (69, 'Моторное масло EDGE Professional LL III Titanium FST 157AD6',     'Товары автосервиса\\96E0C1E7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Castrol'),         1, 1760.00),
    (70, 'Моторное масло Magnatec A3/B4 156E9D',                            'Товары автосервиса\\9290C1E7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Castrol'),         1, 1610.00),
    (71, 'Моторное масло Genuine A000989790213BIFR',                        'Товары автосервиса\\2E60E06C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mercedes'),        1, 2390.00),
    (72, 'Моторное масло Supreme Synthetic MOSYN53C16',                     'Товары автосервиса\\69C0CD62.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Petro-Canada'),    1, 1910.00),
    (73, 'Моторное масло Helix Ultra Pro AM-L 550046353',                   'Товары автосервиса\\3DF0E4BC.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Shell'),           1, 2110.00),
    (74, 'Моторное масло QUARTZ INEO ECS 151510',                           'Товары автосервиса\\8F609ED7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 1920.00),
    (75, 'Моторное масло Original oil Ultra 0530-05-TFE',                   'Товары автосервиса\\85C04040.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mazda'),           1, 2930.00),
    (76, 'Моторное масло QUARTZ 9000 ENERGY HKS 175393',                    'Товары автосервиса\\6DD0A012.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           1, 2830.00),
    (77, 'Моторное масло Ultra LEO-SN 08217-99974',                         'Товары автосервиса\\97809225.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Honda'),           1, 2980.00),
    (78, 'Моторное масло Special G G 052 502 M4',                           'Товары автосервиса\\E0A0E079.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'VAG'),             1, 3090.00),
    (79, 'Моторное масло Люкс 207465',                                      'Товары автосервиса\\8E20A863.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Lukoil'),          1, 1090.00),
    (80, 'Жилет светоотражающий взрослый ARW-AV-02',                        'Товары автосервиса\\D4D0CE67.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Airline'),         1, 150.00),
    (81, 'Моторное масло Premium LF Gasoline 05100-00451',                  'Товары автосервиса\\2B609062.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Hyundai/Kia'),     1, 1620.00),
    (82, 'Моторное масло Evolution 900 SXR 10160501',                       'Товары автосервиса\\BD80E8D5.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Elf'),             1, 1750.00),
    (83, 'Моторное масло Zepro Touring 1845-004',                           'Товары автосервиса\\5180B90E.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 2380.00),
    (84, 'Моторное масло 76 A000989PKW Motorenol0213BLER',                  'Товары автосервиса\\2E00E06C.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mercedes'),        1, 2510.00),
    (85, 'Моторное масло QUARTZ 9000 ENERGY HKS 175392',                    'Товары автосервиса\\6DA0A012.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           0, 1530.00),
    (86, 'Моторное масло Formula F 155D3A',                                 'Товары автосервиса\\39D0C188.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Ford'),            1, 1830.00),
    (87, 'Моторное масло Mobil 1 FS 153692',                                'Товары автосервиса\\6080DCD5.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mobil'),           1, 3020.00),
    (88, 'Моторное масло Zepro Eco Medalist 3583-004',                      'Товары автосервиса\\3DA0B713.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 2520.00),
    (89, 'Моторное масло SN 08880-10706',                                   'Товары автосервиса\\43C09176.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          1, 1640.00),
    (90, 'Моторное масло Dexos 2 19 42 003',                                'Товары автосервиса\\8430842A.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Opel'),            1, 1490.00),
    (91, 'Моторное масло ENGINE OIL 08880-80365-GO',                        'Товары автосервиса\\CC10C869.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Toyota'),          1, 3580.00),
    (92, 'Моторное масло EDGE LL Titanium FST 15669A',                      'Товары автосервиса\\8BC0C1A9.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Castrol'),         1, 3000.00),
    (93, 'Моторное масло QUARTZ 9000 148597',                               'Товары автосервиса\\8F909ED7.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           0, 1700.00),
    (94, 'Моторное масло ENGINE OIL MZ 320756',                             'Товары автосервиса\\5BE0C351.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mitsubishi'),      0, 1600.00),
    (95, 'Кредитница Кожа B6 6 95 1349',                                    'Товары автосервиса\\63C09E91.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mercedes'),        1, 6770.00),
    (96, 'Моторное масло Zepro Touring 1845-001',                           'Товары автосервиса\\7B70B9C6.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 1720.00),
    (97, 'Моторное масло ENGINE OIL MZ 320757',                             'Товары автосервиса\\0D30C4EE.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Mitsubishi'),      1, 2210.00),
    (98, 'Моторное масло Zepro Eco Medalist 3583-001',                      'Товары автосервиса\\6800BB8A.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Idemitsu'),        1, 1770.00),
    (99, 'Моторное масло Premium DPF Diesel 05200-00620',                   'Товары автосервиса\\9B3075EB.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Hyundai/Kia'),     1, 2470.00),
    (100, 'Моторное масло QUARTZ 9000 FUTURE NFC 10230501',                 'Товары автосервиса\\3970E753.jpg',  (SELECT id_manufacturer FROM manufacturer WHERE name = 'Total'),           0, 1650.00);

-- ============================================================
-- Индексы для ускорения запросов
-- ============================================================
CREATE INDEX idx_product_manufacturer ON product(id_manufacturer);
CREATE INDEX idx_product_active       ON product(active);
CREATE INDEX idx_product_price        ON product(price);
CREATE INDEX idx_manufacturer_name    ON manufacturer(name);
