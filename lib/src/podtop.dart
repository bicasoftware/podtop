import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/design/styles.dart';
import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/pages/home/home.dart';
import 'package:podtop/src/splash_screen.dart';
import 'package:provider/provider.dart';

class PodTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureObserver<List>(
      future: Future.wait([
        PodTopDB().appSettingsDao.listAllSettings,
        PodTopDB().podcastsDao.listAllPodcasts,
      ]),
      onAwaiting: (_) => SplashScreen(),
      onSuccess: (_, dados) {
        List<AppSetting> settings = dados[0] as List<AppSetting>;
        List<Podcast> podcasts = dados[1] as List<Podcast>;
        bool isLight = settings[0]?.isLight ?? true;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: isLight ? AppThemes.lightTheme : AppThemes.darkTheme,
          home: Provider<BlocMain>(
            builder: (_) => BlocMain(
              isLight: settings[0].isLight ?? true,
              podcasts: podcasts,
            ),
            dispose: (_, BlocMain b) => b.dispose(),
            child: Home(),
          ),
        );
      },
    );

    /* return FutureObserver<List<AppSetting>>(
      future: PodTopDB().appSettingsDao.listAllSettings,
      onAwaiting: (_) => SplashScreen(),
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
    ); */
  }
}
