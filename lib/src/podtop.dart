import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/database/app_settings.dart';
import 'package:podtop/src/design/styles.dart';
import 'package:podtop/src/pages/home/home.dart';
import 'package:podtop/src/splash_screen.dart';
import 'package:provider/provider.dart';

class PodTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureObserver<List<AppSetting>>(
      onAwaiting: (_) => SplashScreen(),
      future: PodTopDB().appSettingsDao.listAllSettings,
      onSuccess: (_, List<AppSetting> settings) {
        bool isLight = settings[0]?.isLight ?? true;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: isLight ? AppThemes.lightTheme : AppThemes.darkTheme,
          home: Provider<BlocMain>(
            builder: (_) => BlocMain(isLight: settings[0].isLight ?? true),
            dispose: (_, BlocMain b) => b.dispose(),
            child: Home(),
          ),
        );
      },
    );
  }
}
