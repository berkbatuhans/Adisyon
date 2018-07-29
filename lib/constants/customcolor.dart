import 'dart:ui';

class ColorCode {
  static const color1 = Color.fromRGBO(123, 209, 72, 1.0);
  static const color2 = Color.fromRGBO(84, 132, 237, 1.0);
  static const color3 = Color.fromRGBO(164, 189, 252, 1.0);
  static const color4 = Color.fromRGBO(70, 214, 219, 1.0);
  static const color5 = Color.fromRGBO(122, 231, 191, 1.0);
  static const color6 = Color.fromRGBO(81, 183, 73, 1.0);
  static const color7 = Color.fromRGBO(251, 215, 91, 1.0);
  static const color8 = Color.fromRGBO(255, 184, 120, 1.0);
  static const color9 = Color.fromRGBO(255, 136, 124, 1.0);
  static const color10 = Color.fromRGBO(220, 33, 39, 1.0);
  static const color11 = Color.fromRGBO(219, 173, 255, 1.0);
  static const color12 = Color.fromRGBO(225, 225, 225, 1.0);
  static const color13 = Color.fromRGBO(0, 150, 136, 1.0);
  static List<Color> list = [];

  ColorCode(){
    list.add(ColorCode.color1);
    list.add(ColorCode.color12);
    list.add(ColorCode.color3);
    list.add(ColorCode.color4);
    list.add(ColorCode.color5);
    list.add(ColorCode.color6);
    list.add(ColorCode.color7);
  }
}

class CustomColor {
  final Color color;

  CustomColor({this.color});

  List<CustomColor> customColorList(){
    List<CustomColor> _list;
    _list.add(new CustomColor(color: Color.fromRGBO(123, 209, 72, 1.0)));
    return _list;
  }
}