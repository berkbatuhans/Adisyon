import 'package:adisyon/models/table.dart';

class RestaurantArea {
  final int id;
  final String name;
  final List<Tables> tables;

  const RestaurantArea({this.id, this.name, this.tables});
}
