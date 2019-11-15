import 'package:moor_flutter/moor_flutter.dart';

class TableEpisodes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idPodcast => integer()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get summary => text()();
  TextColumn get author => text()();
  TextColumn get duration => text()();
  TextColumn get mp3Link => text()();
  BoolColumn get listened => boolean()();
  TextColumn get stopTime => text()();
}
