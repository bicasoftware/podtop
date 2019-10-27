import 'package:flutter/material.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/design/styles.dart';
import 'package:podtop/src/pages/home/home.dart';
import 'package:podtop/src/translates.dart';
import 'package:provider/provider.dart';

class PodTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme(),
      home: Provider<BlocMain>(
        builder: (_) => BlocMain(nome: Strings.app_name),
        dispose: (_, BlocMain b) => b.dispose(),
        child: Home(),
      ),
    );
  }
}
