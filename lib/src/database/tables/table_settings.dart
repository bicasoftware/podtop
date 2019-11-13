import 'package:moor_flutter/moor_flutter.dart';

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isLight => boolean()();
}

