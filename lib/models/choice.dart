import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Notlar', icon: Icons.directions_bus),
  const Choice(title: 'Masayı Değiştir', icon: Icons.directions_railway),
  const Choice(title: 'Masayı Kapat', icon: Icons.directions_walk),
  const Choice(title: 'Siparişi İptal Et', icon: Icons.directions_walk),
  const Choice(title: 'Çıkış Yap', icon: Icons.directions_walk),
];


