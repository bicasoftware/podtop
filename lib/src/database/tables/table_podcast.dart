import 'package:moor_flutter/moor_flutter.dart';

class TbPodcasts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get subtitle => text()();
  TextColumn get summary => text()();
  TextColumn get description => text()();
  TextColumn get author => text()();
  TextColumn get rssLink => text()();
  TextColumn get podcastImg => text()();
  TextColumn get lastBuildDate => text()();
  TextColumn get categories => text()();
}