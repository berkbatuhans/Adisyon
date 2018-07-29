import 'package:flutter/material.dart';

class Category {
    
  const Category({this.id, this.name, this.color, this.isSalable, this.isBeverage, this.order});
  final int id;
  final String name;
  final Color color;
  final bool isSalable;
  final bool isBeverage;
  final int order;
}

