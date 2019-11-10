import 'package:flutter/material.dart';
import 'package:podtop/src/design/styles.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: FlutterLogo(size: 300),
          ),
        ),
      ),
    );
  }
}
