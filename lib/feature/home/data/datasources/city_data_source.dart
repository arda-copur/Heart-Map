import 'package:google_maps_flutter/google_maps_flutter.dart';

class CityDataSource {
  Map<String, Map<String, Map<String, List<LatLng>>>> getAllCitiesData() {
    final Map<String, Map<String, Map<String, List<LatLng>>>> data = {};

    // Türkiye 
    data["Türkiye"] = _getTurkeyData();

    // Almanya 
    data["Almanya"] = {
      "Kuzey Almanya": {
        "Hamburg": [
          const LatLng(53.5511, 9.9937),
          const LatLng(53.5530, 9.9950),
          const LatLng(53.5550, 9.9970),
        ],
        "Berlin": [
          const LatLng(52.5200, 13.4050),
          const LatLng(52.5220, 13.4070),
          const LatLng(52.5240, 13.4090),
        ],
        "Bremen": [
          const LatLng(53.0793, 8.8017),
          const LatLng(53.0810, 8.8030),
          const LatLng(53.0830, 8.8050),
        ],
        "Hannover": [
          const LatLng(52.3759, 9.7320),
          const LatLng(52.3780, 9.7340),
          const LatLng(52.3800, 9.7360),
        ],
        "Kiel": [
          const LatLng(54.3233, 10.1394),
          const LatLng(54.3250, 10.1410),
          const LatLng(54.3270, 10.1430),
        ],
        "Rostock": [
          const LatLng(54.0924, 12.0991),
          const LatLng(54.0940, 12.1010),
          const LatLng(54.0960, 12.1030),
        ],
      },
      "Batı Almanya": {
        "Düsseldorf": [
          const LatLng(51.2277, 6.7735),
          const LatLng(51.2300, 6.7760),
          const LatLng(51.2320, 6.7780),
        ],
        "Köln": [
          const LatLng(50.9375, 6.9603),
          const LatLng(50.9400, 6.9620),
          const LatLng(50.9420, 6.9640),
        ],
        "Dortmund": [
          const LatLng(51.5136, 7.4653),
          const LatLng(51.5160, 7.4670),
          const LatLng(51.5180, 7.4690),
        ],
        "Essen": [
          const LatLng(51.4556, 7.0116),
          const LatLng(51.4580, 7.0140),
          const LatLng(51.4600, 7.0160),
        ],
        "Bonn": [
          const LatLng(50.7374, 7.0982),
          const LatLng(50.7390, 7.1000),
          const LatLng(50.7410, 7.1020),
        ],
      },
      "Güney Almanya": {
        "Münih": [
          const LatLng(48.1351, 11.5820),
          const LatLng(48.1370, 11.5840),
          const LatLng(48.1390, 11.5860),
        ],
        "Stuttgart": [
          const LatLng(48.7758, 9.1829),
          const LatLng(48.7780, 9.1850),
          const LatLng(48.7800, 9.1870),
        ],
        "Nürnberg": [
          const LatLng(49.4521, 11.0767),
          const LatLng(49.4540, 11.0790),
          const LatLng(49.4560, 11.0810),
        ],
        "Karlsruhe": [
          const LatLng(49.0069, 8.4037),
          const LatLng(49.0090, 8.4060),
          const LatLng(49.0110, 8.4080),
        ],
        "Augsburg": [
          const LatLng(48.3705, 10.8978),
          const LatLng(48.3730, 10.9000),
          const LatLng(48.3750, 10.9020),
        ],
      },
      "Doğu Almanya": {
        "Dresden": [
          const LatLng(51.0504, 13.7373),
          const LatLng(51.0520, 13.7390),
          const LatLng(51.0540, 13.7410),
        ],
        "Leipzig": [
          const LatLng(51.3397, 12.3731),
          const LatLng(51.3420, 12.3750),
          const LatLng(51.3440, 12.3770),
        ],
        "Magdeburg": [
          const LatLng(52.1205, 11.6276),
          const LatLng(52.1230, 11.6300),
          const LatLng(52.1250, 11.6320),
        ],
        "Erfurt": [
          const LatLng(50.9847, 11.0299),
          const LatLng(50.9870, 11.0320),
          const LatLng(50.9890, 11.0340),
        ],
        "Chemnitz": [
          const LatLng(50.8322, 12.9252),
          const LatLng(50.8340, 12.9270),
          const LatLng(50.8360, 12.9290),
        ],
      },
    };

    // Fransa verileri
    data["Fransa"] = {
      "Kuzey Fransa": {
        "Paris": [
          const LatLng(48.8566, 2.3522),
          const LatLng(48.8580, 2.3540),
          const LatLng(48.8600, 2.3560),
        ],
        "Lille": [
          const LatLng(50.6292, 3.0573),
          const LatLng(50.6310, 3.0590),
          const LatLng(50.6330, 3.0610),
        ],
        "Reims": [
          const LatLng(49.2577, 4.0317),
          const LatLng(49.2590, 4.0330),
          const LatLng(49.2610, 4.0350),
        ],
        "Rouen": [
          const LatLng(49.4431, 1.0993),
          const LatLng(49.4450, 1.1010),
          const LatLng(49.4470, 1.1030),
        ],
        "Amiens": [
          const LatLng(49.8941, 2.2957),
          const LatLng(49.8960, 2.2980),
          const LatLng(49.8980, 2.3000),
        ],
      },
      "Batı Fransa": {
        "Nantes": [
          const LatLng(47.2184, -1.5536),
          const LatLng(47.2200, -1.5550),
          const LatLng(47.2220, -1.5570),
        ],
        "Rennes": [
          const LatLng(48.1173, -1.6778),
          const LatLng(48.1190, -1.6800),
          const LatLng(48.1210, -1.6820),
        ],
        "Bordeaux": [
          const LatLng(44.8378, -0.5792),
          const LatLng(44.8400, -0.5810),
          const LatLng(44.8420, -0.5830),
        ],
        "La Rochelle": [
          const LatLng(46.1591, -1.1520),
          const LatLng(46.1610, -1.1540),
          const LatLng(46.1630, -1.1560),
        ],
        "Brest": [
          const LatLng(48.3904, -4.4860),
          const LatLng(48.3920, -4.4880),
          const LatLng(48.3940, -4.4900),
        ],
      },
      "Güney Fransa": {
        "Marsilya": [
          const LatLng(43.2965, 5.3698),
          const LatLng(43.2980, 5.3720),
          const LatLng(43.3000, 5.3740),
        ],
        "Nice": [
          const LatLng(43.7102, 7.2620),
          const LatLng(43.7120, 7.2640),
          const LatLng(43.7140, 7.2660),
        ],
        "Toulouse": [
          const LatLng(43.6047, 1.4442),
          const LatLng(43.6070, 1.4460),
          const LatLng(43.6090, 1.4480),
        ],
        "Montpellier": [
          const LatLng(43.6108, 3.8767),
          const LatLng(43.6130, 3.8790),
          const LatLng(43.6150, 3.8810),
        ],
        "Cannes": [
          const LatLng(43.5528, 7.0174),
          const LatLng(43.5550, 7.0190),
          const LatLng(43.5570, 7.0210),
        ],
      },
      "Doğu Fransa": {
        "Strasbourg": [
          const LatLng(48.5734, 7.7521),
          const LatLng(48.5750, 7.7540),
          const LatLng(48.5770, 7.7560),
        ],
        "Lyon": [
          const LatLng(45.7640, 4.8357),
          const LatLng(45.7660, 4.8380),
          const LatLng(45.7680, 4.8400),
        ],
        "Dijon": [
          const LatLng(47.3220, 5.0415),
          const LatLng(47.3240, 5.0430),
          const LatLng(47.3260, 5.0450),
        ],
        "Metz": [
          const LatLng(49.1193, 6.1757),
          const LatLng(49.1210, 6.1780),
          const LatLng(49.1230, 6.1800),
        ],
        "Grenoble": [
          const LatLng(45.1885, 5.7245),
          const LatLng(45.1900, 5.7270),
          const LatLng(45.1920, 5.7290),
        ],
      },
    };

    // İtalya verileri
    data["İtalya"] = {
      "Kuzey İtalya": {
        "Milano": [
          const LatLng(45.4642, 9.1900),
          const LatLng(45.4660, 9.1920),
          const LatLng(45.4680, 9.1940),
        ],
        "Venedik": [
          const LatLng(45.4408, 12.3155),
          const LatLng(45.4420, 12.3170),
          const LatLng(45.4440, 12.3190),
        ],
        "Torino": [
          const LatLng(45.0703, 7.6869),
          const LatLng(45.0720, 7.6890),
          const LatLng(45.0740, 7.6910),
        ],
        "Bolonya": [
          const LatLng(44.4949, 11.3426),
          const LatLng(44.4970, 11.3450),
          const LatLng(44.4990, 11.3470),
        ],
        "Verona": [
          const LatLng(45.4384, 10.9916),
          const LatLng(45.4400, 10.9940),
          const LatLng(45.4420, 10.9960),
        ],
      },
      "Orta İtalya": {
        "Roma": [
          const LatLng(41.9028, 12.4964),
          const LatLng(41.9050, 12.4980),
          const LatLng(41.9070, 12.5000),
        ],
        "Floransa": [
          const LatLng(43.7696, 11.2558),
          const LatLng(43.7710, 11.2580),
          const LatLng(43.7730, 11.2600),
        ],
        "Pisa": [
          const LatLng(43.7228, 10.4017),
          const LatLng(43.7250, 10.4040),
          const LatLng(43.7270, 10.4060),
        ],
        "Perugia": [
          const LatLng(43.1107, 12.3897),
          const LatLng(43.1130, 12.3920),
          const LatLng(43.1150, 12.3940),
        ],
        "Ancona": [
          const LatLng(43.6158, 13.5189),
          const LatLng(43.6180, 13.5210),
          const LatLng(43.6200, 13.5230),
        ],
      },
      "Güney İtalya": {
        "Napoli": [
          const LatLng(40.8518, 14.2681),
          const LatLng(40.8530, 14.2700),
          const LatLng(40.8550, 14.2720),
        ],
        "Palermo": [
          const LatLng(38.1157, 13.3615),
          const LatLng(38.1170, 13.3630),
          const LatLng(38.1190, 13.3650),
        ],
        "Bari": [
          const LatLng(41.1171, 16.8719),
          const LatLng(41.1190, 16.8740),
          const LatLng(41.1210, 16.8760),
        ],
        "Catania": [
          const LatLng(37.5079, 15.0830),
          const LatLng(37.5100, 15.0850),
          const LatLng(37.5120, 15.0870),
        ],
        "Reggio Calabria": [
          const LatLng(38.1196, 15.6451),
          const LatLng(38.1220, 15.6470),
          const LatLng(38.1240, 15.6490),
        ],
      },
    };

    // İspanya verileri
    data["İspanya"] = {
      "Kuzey İspanya": {
        "Barselona": [
          const LatLng(41.3851, 2.1734),
          const LatLng(41.3870, 2.1750),
          const LatLng(41.3890, 2.1770),
        ],
        "Bilbao": [
          const LatLng(43.2630, -2.9350),
          const LatLng(43.2650, -2.9370),
          const LatLng(43.2670, -2.9390),
        ],
        "Santander": [
          const LatLng(43.4623, -3.8099),
          const LatLng(43.4640, -3.8120),
          const LatLng(43.4660, -3.8140),
        ],
        "Oviedo": [
          const LatLng(43.3614, -5.8593),
          const LatLng(43.3630, -5.8610),
          const LatLng(43.3650, -5.8630),
        ],
        "A Coruña": [
          const LatLng(43.3623, -8.4115),
          const LatLng(43.3640, -8.4130),
          const LatLng(43.3660, -8.4150),
        ],
      },
      "Orta İspanya": {
        "Madrid": [
          const LatLng(40.4168, -3.7038),
          const LatLng(40.4180, -3.7050),
          const LatLng(40.4200, -3.7070),
        ],
        "Valladolid": [
          const LatLng(41.6523, -4.7245),
          const LatLng(41.6540, -4.7260),
          const LatLng(41.6560, -4.7280),
        ],
        "Zaragoza": [
          const LatLng(41.6560, -0.8773),
          const LatLng(41.6580, -0.8790),
          const LatLng(41.6600, -0.8810),
        ],
        "Toledo": [
          const LatLng(39.8628, -4.0273),
          const LatLng(39.8650, -4.0290),
          const LatLng(39.8670, -4.0310),
        ],
        "Salamanca": [
          const LatLng(40.9701, -5.6635),
          const LatLng(40.9720, -5.6650),
          const LatLng(40.9740, -5.6670),
        ],
      },
      "Güney İspanya": {
        "Sevilla": [
          const LatLng(37.3891, -5.9845),
          const LatLng(37.3910, -5.9860),
          const LatLng(37.3930, -5.9880),
        ],
        "Malaga": [
          const LatLng(36.7212, -4.4217),
          const LatLng(36.7230, -4.4230),
          const LatLng(36.7250, -4.4250),
        ],
        "Granada": [
          const LatLng(37.1773, -3.5986),
          const LatLng(37.1790, -3.6000),
          const LatLng(37.1810, -3.6020),
        ],
        "Valencia": [
          const LatLng(39.4699, -0.3763),
          const LatLng(39.4720, -0.3780),
          const LatLng(39.4740, -0.3800),
        ],
        "Murcia": [
          const LatLng(37.9922, -1.1307),
          const LatLng(37.9940, -1.1320),
          const LatLng(37.9960, -1.1340),
        ],
      },
      "Ada İspanya": {
        "Palma de Mallorca": [
          const LatLng(39.5696, 2.6502),
          const LatLng(39.5720, 2.6520),
          const LatLng(39.5740, 2.6540),
        ],
        "Las Palmas": [
          const LatLng(28.1235, -15.4366),
          const LatLng(28.1250, -15.4380),
          const LatLng(28.1270, -15.4400),
        ],
        "Santa Cruz de Tenerife": [
          const LatLng(28.4683, -16.2546),
          const LatLng(28.4700, -16.2560),
          const LatLng(28.4720, -16.2580),
        ],
        "Ibiza": [
          const LatLng(38.9087, 1.4328),
          const LatLng(38.9100, 1.4350),
          const LatLng(38.9120, 1.4370),
        ],
      },
    };

    return data;
  }

  Map<String, Map<String, List<LatLng>>> _getTurkeyData() {
    return {
      "Marmara": {
        "İstanbul": [
          const LatLng(41.0082, 28.9784),
          const LatLng(41.0136, 28.9550),
          const LatLng(41.0053, 28.9761),
          const LatLng(41.0100, 28.9700),
          const LatLng(41.0200, 28.9600),
        ],
        "Bursa": [
          const LatLng(40.1828, 29.0666),
          const LatLng(40.1900, 29.0500),
          const LatLng(40.1972, 29.0334),
        ],
        "Kocaeli": [
          const LatLng(40.7654, 29.9408),
          const LatLng(40.7700, 29.9500),
          const LatLng(40.7750, 29.9550),
        ],
        "Tekirdağ": [
          const LatLng(40.9833, 27.5167),
          const LatLng(40.9850, 27.5200),
          const LatLng(40.9870, 27.5230),
        ],
        "Edirne": [
          const LatLng(41.6771, 26.5557),
          const LatLng(41.6800, 26.5600),
          const LatLng(41.6830, 26.5630),
        ],
        "Çanakkale": [
          const LatLng(40.1553, 26.4142),
          const LatLng(40.1580, 26.4170),
          const LatLng(40.1600, 26.4200),
        ],
        "Balıkesir": [
          const LatLng(39.6533, 27.8903),
          const LatLng(39.6550, 27.8950),
          const LatLng(39.6580, 27.9000),
        ],
        "Sakarya": [
          const LatLng(40.7731, 30.3943),
          const LatLng(40.7750, 30.4000),
          const LatLng(40.7780, 30.4050),
        ],
        "Yalova": [
          const LatLng(40.6550, 29.2760),
          const LatLng(40.6580, 29.2800),
          const LatLng(40.6600, 29.2850),
        ],
        "Kırklareli": [
          const LatLng(41.7333, 27.2167),
          const LatLng(41.7360, 27.2200),
          const LatLng(41.7380, 27.2250),
        ],
        "Bilecik": [
          const LatLng(40.1506, 29.9833),
          const LatLng(40.1530, 29.9860),
          const LatLng(40.1550, 29.9900),
        ],
      },
      "İç Anadolu": {
        "Ankara": [
          const LatLng(39.9208, 32.8541),
          const LatLng(39.9220, 32.8600),
          const LatLng(39.9243, 32.8555),
        ],
        "Eskişehir": [
          const LatLng(39.7767, 30.5206),
          const LatLng(39.7830, 30.5040),
          const LatLng(39.7893, 30.4874),
        ],
        "Konya": [
          const LatLng(37.8716, 32.4849),
          const LatLng(37.8800, 32.4700),
          const LatLng(37.8884, 32.4551),
        ],
        "Kayseri": [
          const LatLng(38.7225, 35.4875),
          const LatLng(38.7300, 35.4700),
          const LatLng(38.7375, 35.4525),
        ],
        "Sivas": [
          const LatLng(39.7477, 37.0179),
          const LatLng(39.7500, 37.0200),
          const LatLng(39.7525, 37.0230),
        ],
        "Yozgat": [
          const LatLng(39.8181, 34.8147),
          const LatLng(39.8200, 34.8170),
          const LatLng(39.8225, 34.8200),
        ],
        "Aksaray": [
          const LatLng(38.3687, 34.0370),
          const LatLng(38.3710, 34.0400),
          const LatLng(38.3735, 34.0425),
        ],
        "Kırıkkale": [
          const LatLng(39.8469, 33.5153),
          const LatLng(39.8490, 33.5180),
          const LatLng(39.8510, 33.5200),
        ],
        "Kırşehir": [
          const LatLng(39.1425, 34.1709),
          const LatLng(39.1450, 34.1730),
          const LatLng(39.1475, 34.1760),
        ],
        "Nevşehir": [
          const LatLng(38.6939, 34.6857),
          const LatLng(38.6960, 34.6880),
          const LatLng(38.6980, 34.6900),
        ],
        "Niğde": [
          const LatLng(37.9667, 34.6833),
          const LatLng(37.9690, 34.6860),
          const LatLng(37.9710, 34.6880),
        ],
        "Karaman": [
          const LatLng(37.1759, 33.2287),
          const LatLng(37.1780, 33.2310),
          const LatLng(37.1800, 33.2330),
        ],
      },
      "Ege": {
        "İzmir": [
          const LatLng(38.4192, 27.1287),
          const LatLng(38.4237, 27.1303),
          const LatLng(38.4155, 27.1279),
        ],
        "Aydın": [
          const LatLng(37.8560, 27.8416),
          const LatLng(37.8580, 27.8440),
          const LatLng(37.8600, 27.8470),
        ],
        "Muğla": [
          const LatLng(37.2153, 28.3636),
          const LatLng(37.2180, 28.3670),
          const LatLng(37.2200, 28.3700),
        ],
        "Denizli": [
          const LatLng(37.7765, 29.0864),
          const LatLng(37.7790, 29.0890),
          const LatLng(37.7810, 29.0920),
        ],
        "Manisa": [
          const LatLng(38.6191, 27.4289),
          const LatLng(38.6220, 27.4320),
          const LatLng(38.6240, 27.4350),
        ],
        "Afyonkarahisar": [
          const LatLng(38.7507, 30.5567),
          const LatLng(38.7530, 30.5600),
          const LatLng(38.7550, 30.5630),
        ],
        "Kütahya": [
          const LatLng(39.4167, 29.9833),
          const LatLng(39.4190, 29.9860),
          const LatLng(39.4210, 29.9890),
        ],
        "Uşak": [
          const LatLng(38.6823, 29.4082),
          const LatLng(38.6850, 29.4110),
          const LatLng(38.6870, 29.4140),
        ],
      },
      "Akdeniz": {
        "Antalya": [
          const LatLng(36.8969, 30.7133),
          const LatLng(36.9025, 30.6986),
          const LatLng(36.9081, 30.6839),
        ],
        "Adana": [
          const LatLng(37.0000, 35.3213),
          const LatLng(37.0085, 35.3387),
          const LatLng(37.0176, 35.3292),
        ],
        "Mersin": [
          const LatLng(36.8, 34.6333),
          const LatLng(36.8030, 34.6360),
          const LatLng(36.8060, 34.6390),
        ],
        "Hatay": [
          const LatLng(36.4018, 36.3498),
          const LatLng(36.4050, 36.3530),
          const LatLng(36.4080, 36.3560),
        ],
        "Kahramanmaraş": [
          const LatLng(37.5753, 36.9228),
          const LatLng(37.5780, 36.9260),
          const LatLng(37.5810, 36.9290),
        ],
        "Osmaniye": [
          const LatLng(37.0742, 36.2463),
          const LatLng(37.0770, 36.2490),
          const LatLng(37.0800, 36.2510),
        ],
        "Burdur": [
          const LatLng(37.7167, 30.2833),
          const LatLng(37.7190, 30.2860),
          const LatLng(37.7220, 30.2890),
        ],
        "Isparta": [
          const LatLng(37.7667, 30.5667),
          const LatLng(37.7690, 30.5690),
          const LatLng(37.7720, 30.5720),
        ],
      },
      "Karadeniz": {
        "Trabzon": [
          const LatLng(41.0027, 39.7168),
          const LatLng(41.0050, 39.7200),
          const LatLng(41.0070, 39.7220),
        ],
        "Rize": [
          const LatLng(41.0255, 40.5177),
          const LatLng(41.0270, 40.5200),
          const LatLng(41.0290, 40.5220),
        ],
        "Ordu": [
          const LatLng(40.9862, 37.8797),
          const LatLng(40.9880, 37.8820),
          const LatLng(40.9900, 37.8840),
        ],
        "Zonguldak": [
          const LatLng(41.4535, 31.7894),
          const LatLng(41.4550, 31.7920),
          const LatLng(41.4570, 31.7940),
        ],
        "Samsun": [
          const LatLng(41.2867, 36.3300),
          const LatLng(41.2890, 36.3330),
          const LatLng(41.2920, 36.3360),
        ],
        "Sinop": [
          const LatLng(42.0231, 35.1531),
          const LatLng(42.0250, 35.1560),
          const LatLng(42.0270, 35.1590),
        ],
        "Kastamonu": [
          const LatLng(41.3887, 33.7827),
          const LatLng(41.3910, 33.7850),
          const LatLng(41.3930, 33.7880),
        ],
        "Bartın": [
          const LatLng(41.6358, 32.3375),
          const LatLng(41.6380, 32.3400),
          const LatLng(41.6400, 32.3420),
        ],
        "Karabük": [
          const LatLng(41.2061, 32.6204),
          const LatLng(41.2080, 32.6230),
          const LatLng(41.2100, 32.6250),
        ],
        "Düzce": [
          const LatLng(40.8417, 31.1583),
          const LatLng(40.8440, 31.1610),
          const LatLng(40.8460, 31.1630),
        ],
        "Bolu": [
          const LatLng(40.7372, 31.6082),
          const LatLng(40.7390, 31.6110),
          const LatLng(40.7410, 31.6130),
        ],
        "Çorum": [
          const LatLng(40.5489, 34.9533),
          const LatLng(40.5510, 34.9560),
          const LatLng(40.5530, 34.9580),
        ],
        "Amasya": [
          const LatLng(40.6499, 35.8353),
          const LatLng(40.6520, 35.8380),
          const LatLng(40.6540, 35.8400),
        ],
        "Giresun": [
          const LatLng(40.9128, 38.3895),
          const LatLng(40.9150, 38.3920),
          const LatLng(40.9170, 38.3940),
        ],
        "Gümüşhane": [
          const LatLng(40.4603, 39.4817),
          const LatLng(40.4620, 39.4840),
          const LatLng(40.4640, 39.4860),
        ],
        "Bayburt": [
          const LatLng(40.2552, 40.2249),
          const LatLng(40.2570, 40.2270),
          const LatLng(40.2590, 40.2290),
        ],
        "Artvin": [
          const LatLng(41.1827, 41.8187),
          const LatLng(41.1850, 41.8210),
          const LatLng(41.1870, 41.8230),
        ],
      },
      "Doğu Anadolu": {
        "Erzurum": [
          const LatLng(39.9004, 41.2700),
          const LatLng(39.9030, 41.2730),
          const LatLng(39.9050, 41.2750),
        ],
        "Kars": [
          const LatLng(40.6013, 43.0975),
          const LatLng(40.6040, 43.1000),
          const LatLng(40.6060, 43.1020),
        ],
        "Ağrı": [
          const LatLng(39.7191, 43.0503),
          const LatLng(39.7220, 43.0530),
          const LatLng(39.7240, 43.0550),
        ],
        "Van": [
          const LatLng(38.4891, 43.4089),
          const LatLng(38.4920, 43.4120),
          const LatLng(38.4940, 43.4140),
        ],
        "Malatya": [
          const LatLng(38.3552, 38.3095),
          const LatLng(38.3580, 38.3120),
          const LatLng(38.3600, 38.3140),
        ],
        "Elazığ": [
          const LatLng(38.6748, 39.2271),
          const LatLng(38.6770, 39.2300),
          const LatLng(38.6790, 39.2320),
        ],
        "Bingöl": [
          const LatLng(38.8853, 40.4980),
          const LatLng(38.8880, 40.5000),
          const LatLng(38.8900, 40.5020),
        ],
        "Muş": [
          const LatLng(38.7452, 41.4817),
          const LatLng(38.7480, 41.4840),
          const LatLng(38.7500, 41.4860),
        ],
        "Bitlis": [
          const LatLng(38.4006, 42.1095),
          const LatLng(38.4030, 42.1120),
          const LatLng(38.4050, 42.1140),
        ],
        "Hakkari": [
          const LatLng(37.5742, 43.7408),
          const LatLng(37.5770, 43.7430),
          const LatLng(37.5790, 43.7450),
        ],
        "Iğdır": [
          const LatLng(39.9200, 44.0450),
          const LatLng(39.9230, 44.0480),
          const LatLng(39.9250, 44.0500),
        ],
        "Ardahan": [
          const LatLng(41.1105, 42.7022),
          const LatLng(41.1130, 42.7050),
          const LatLng(41.1150, 42.7070),
        ],
        "Tunceli": [
          const LatLng(39.1062, 39.5413),
          const LatLng(39.1090, 39.5440),
          const LatLng(39.1110, 39.5460),
        ],
        "Erzincan": [
          const LatLng(39.7414, 39.4911),
          const LatLng(39.7440, 39.4940),
          const LatLng(39.7460, 39.4960),
        ],
      },
      "Güneydoğu Anadolu": {
        "Gaziantep": [
          const LatLng(37.0662, 37.3833),
          const LatLng(37.0734, 37.3667),
          const LatLng(37.0806, 37.3501),
        ],
        "Şanlıurfa": [
          const LatLng(37.1591, 38.7969),
          const LatLng(37.1620, 38.8000),
          const LatLng(37.1640, 38.8020),
        ],
        "Diyarbakır": [
          const LatLng(37.9144, 40.2306),
          const LatLng(37.9170, 40.2330),
          const LatLng(37.9190, 40.2350),
        ],
        "Mardin": [
          const LatLng(37.3212, 40.7245),
          const LatLng(37.3240, 40.7270),
          const LatLng(37.3260, 40.7290),
        ],
        "Batman": [
          const LatLng(37.8812, 41.1363),
          const LatLng(37.8840, 41.1390),
          const LatLng(37.8860, 41.1410),
        ],
        "Siirt": [
          const LatLng(37.9333, 41.9500),
          const LatLng(37.9360, 41.9530),
          const LatLng(37.9380, 41.9550),
        ],
        "Şırnak": [
          const LatLng(37.5131, 42.4542),
          const LatLng(37.5160, 42.4570),
          const LatLng(37.5180, 42.4590),
        ],
        "Adıyaman": [
          const LatLng(37.7636, 38.2773),
          const LatLng(37.7660, 38.2800),
          const LatLng(37.7680, 38.2820),
        ],
        "Kilis": [
          const LatLng(36.7184, 37.1212),
          const LatLng(36.7210, 37.1240),
          const LatLng(36.7230, 37.1260),
        ],
      },
    };
  }

  
  Map<String, List<LatLng>> getCityCoordinates() {
    final allData = getAllCitiesData();
    Map<String, List<LatLng>> result = {};

    allData.forEach((country, regions) {
      regions.forEach((region, cities) {
        cities.forEach((city, coordinates) {
          result[city] = coordinates;
        });
      });
    });

    return result;
  }

  // Ülke isimlerini getiren yardımcı metod
  List<String> getCountries() {
    return getAllCitiesData().keys.toList();
  }

  // Bir ülke içindeki bölgeleri getiren yardımcı metod
  List<String> getRegions(String country) {
    return getAllCitiesData()[country]?.keys.toList() ?? [];
  }

  // Bir bölge içindeki şehirleri getiren yardımcı metod
  List<String> getCitiesInRegion(String country, String region) {
    return getAllCitiesData()[country]?[region]?.keys.toList() ?? [];
  }

  // Bir ülke içindeki tüm şehirleri getiren yardımcı metod
  List<String> getCitiesInCountry(String country) {
    List<String> cities = [];
    getAllCitiesData()[country]?.forEach((region, regionCities) {
      cities.addAll(regionCities.keys);
    });
    return cities;
  }
}
