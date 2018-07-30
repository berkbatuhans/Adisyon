import 'dart:async';
import 'package:adisyon/utils/enums/Enum.dart';
import 'package:adisyon/models/category.dart';
import 'package:adisyon/models/table.dart';

class Constants {
  // Değe
  Future<List<Category>> category() async => _categoryConstants.toList();

  List<Category> categoryList() => _categoryConstants.toList();

  List<Tables> allTableGenerate() {
    return List<Tables>.generate(
        100,
        (index) => Tables(
            name: "Masa ${index + 1}",
            empty: (index % 4 == 0 ? isEmty.Full : isEmty.Empty),
            ready: (index % 4 == 0 ? isReady.Ready : isReady.NotReady)));
  }

  List<Tables> allTablesManual() {
    List<Tables> tables = [];
    tables.add(
        Tables(name: "Masa 1", empty: isEmty.Empty, ready: isReady.NotReady));
    tables
        .add(Tables(name: "Masa 2", empty: isEmty.Full, ready: isReady.Ready));
    tables
        .add(Tables(name: "Masa 3", empty: isEmty.Empty, ready: isReady.Ready));
    tables
        .add(Tables(name: "Masa 4", empty: isEmty.Full, ready: isReady.Ready));
    tables
        .add(Tables(name: "Masa 5", empty: isEmty.Full, ready: isReady.Ready));
    tables
        .add(Tables(name: "Masa 6", empty: isEmty.Empty, ready: isReady.Ready));

    return tables;
  }

  List<String> mutfaklar() => _mutfaklar.toList();
}

List<String> _mutfaklar = <String>[
  'Balık & Deniz Ürünleri',
  'Börek',
  'Burger',
  'Cafe',
  'Çiğ Köfte',
  'Çin Mutfağı',
  'Dondurma',
  'Döner',
  'Dünya Mutfağı',
  'Ev Yemekleri',
  'Fast Food & Sandwich',
  'Japon Mutfağı',
  'Kahvaltı',
  'Kahve',
  'Kebap & Türk Mutfağı',
  'Köfte',
  'Kokoreç',
  'Kumpir',
  'Pasta & Tatlı',
  'Pide',
  'Pizza & İtalyan',
  'Tavuk'
];

const List<Category> _categoryConstants = const <Category>[
  const Category(name: "İÇECEKLER",),
  const Category(name: "SICAK İÇECEKLER",),
  const Category(name: "KAHVELER",),
  const Category(name: "SANDVİÇLER"),
  const Category(name: "SABAH SICAKLARI"),
  const Category(name: "DONDURMALAR"),
  const Category(name: "BÖREKLER"),
  const Category(name: "ÇİKOLATA"),
  const Category(name: "SÜTLÜ"),
];
