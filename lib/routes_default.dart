import 'package:adisyon/auth.dart';
import 'package:adisyon/root_page.dart';
import 'package:adisyon/screens/Adisyon/Adisyon.dart';
import 'package:adisyon/screens/Login/Login.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (BuildContext context) => new Login(),
  '/adisyon': (BuildContext context) => new Adisyon(),
  '/': (BuildContext context) => new RootPage(auth: new Auth()),
};
