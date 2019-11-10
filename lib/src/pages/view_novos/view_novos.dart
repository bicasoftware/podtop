import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/translates.dart';
import 'package:provider/provider.dart';

class ViewNovos extends StatelessWidget {
  const ViewNovos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.novos),
        actions: <Widget>[
          IconButton(
            icon: StreamObserver<Brightness>(
              stream: b.outBrightness,
              onSuccess: (_, Brightness brightness) {
                return Icon(
                  brightness == Brightness.light ? Icons.brightness_4 : Icons.brightness_5,
                );
              },
            ),
            onPressed: b.toggleBrightness,
          )
        ],
      ),
      body: Container(
        color: Colors.pink,
        child: Text("Novos Podcasts"),
      ),
    );
  }
}
