import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/bloc/state_main.dart';
import 'package:podtop/src/design/styles.dart';
import 'package:podtop/src/pages/home/home.dart';
import 'package:podtop/src/splash_screen.dart';
import 'package:provider/provider.dart';

class PodTop extends StatelessWidget {
  const PodTop({
    @required this.state,
    Key key,
  }) : super(key: key);

  final StateMain state;

  @override
  Widget build(BuildContext context) {
    return FutureObserver<StateMain>(
      future: StateMain().build(),
      onAwaiting: (_) => SplashScreen(),
      onSuccess: (_, StateMain state) {
        return MaterialApp(
          title: 'PodTop',
          theme: state.isLight ? AppThemes.lightTheme : AppThemes.darkTheme,
          home: Provider<BlocMain>(
            builder: (_) => BlocMain(state: state),
            dispose: (_, BlocMain b) => b.dispose(),
            child: Home(),
          ),
        );
      },
    );
  }
}
