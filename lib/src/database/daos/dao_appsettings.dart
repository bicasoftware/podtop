import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/database/tables/table_settings.dart';

part 'dao_appsettings.g.dart';

@UseDao(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<PodTopDB> with _$AppSettingsDaoMixin {
  AppSettingsDao(PodTopDB db) : super(db);

  Future<List<AppSetting>> get listAllSettings => select(appSettings).get();

  Future gettoggleIsLight(bool isLight) {
    return db.update(appSettings).replace(AppSetting(id: null, isLight: isLight));
  }
}
