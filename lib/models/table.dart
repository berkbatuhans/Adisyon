import 'package:adisyon/utils/enums/Enum.dart';
import 'package:meta/meta.dart';

class Tables {
  Tables({
    this.id,
    @required this.name,
    @required this.ready,
    @required this.empty
  });
  final int id;
  final String name;
  final isReady ready;
  final isEmty empty;
  
}