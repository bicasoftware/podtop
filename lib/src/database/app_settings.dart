import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/daos/dao_appsettings.dart';

part 'app_settings.g.dart';

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get isLight => boolean()();
}

@UseMoor(tables: [AppSettings], daos: [AppSettingsDao])
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
