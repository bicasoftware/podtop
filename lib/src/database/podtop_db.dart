import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/daos/dao_appsettings.dart';
import 'package:podtop/src/database/tables/table_episode.dart';
import 'package:podtop/src/database/tables/table_podcast.dart';
import 'package:podtop/src/database/tables/table_settings.dart';

import './daos/dao_episodes.dart';

part 'podtop_db.g.dart';

@UseMoor(tables: [
  AppSettings,
  TablePodcasts,
  TableEpisodes,
], daos: [
  AppSettingsDao,
  EpisodesDao,
])
class PodTopDB extends _$PodTopDB {
  PodTopDB() : super(FlutterQueryExecutor.inDatabaseFolder(path: 'db.sqlite'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAllTables();
      },
      beforeOpen: (OpeningDetails details) async {
        if (details.wasCreated) {
          await into(appSettings).insert(AppSetting(id: null, isLight: true));
        }
      },
    );
  }
}