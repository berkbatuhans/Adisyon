import 'dart:ui';

import 'package:adisyon/models/category.dart';

class Product {
  final int id;
  final String name;
  final int taxRate;
  final Category categoryId;
  final Color color;
  final bool isProductSalable;
  final int productUnits;
  Product(
      {this.id,
      this.name,
      this.taxRate,
      this.categoryId,
      this.color,
      this.isProductSalable,
      this.productUnits});
}
