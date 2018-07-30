import 'dart:async';
import 'package:adisyon/models/restaurantarea.dart';
import 'package:adisyon/models/table.dart';
import 'package:adisyon/utils/enums/Enum.dart';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class AdisyonApi {

  static Future<AdisyonApi> adisyonApi() async {
    return new AdisyonApi();
  }

  Future<List<Tables>> allTablesRandom() async {
    return List<Tables>.generate(50,(i){
      new Tables(name: "Masa $i",empty: isEmty.Full, ready: isReady.Ready);
    }).toList();
  }

  

  Future<List<RestaurantArea>> getRestaurantArea() async {
    return (await Firestore.instance.collection('RestaurantArea').getDocuments())
    .documents
    .map((snapshots) => _convertSnapShotRestaurantArea(snapshots)).toList();
  }

  RestaurantArea _convertSnapShotRestaurantArea(DocumentSnapshot snapshot){
    final data = snapshot.data;
    return new RestaurantArea(
      id: data['id'],
      name: data['name'],
    );
  }

  final _random = new Random();
  isEmty emp() {
    int min = 0;
    int max = 5;
    isEmty sonuc;
    sonuc = _random.nextInt(max - min) + 1 == 0 ? isEmty.Empty : isEmty.Full;
    return sonuc;
  }
}
