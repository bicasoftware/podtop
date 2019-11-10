import 'package:flutter/material.dart';
import 'package:podtop/src/translates.dart';

class ViewListaPodcasts extends StatelessWidget {
  const ViewListaPodcasts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.meusPodcasts),
      ),
      body: Container(
        color: Colors.teal,
        child: Text("Lista de podcasts"),
      ),
    );
  }
}
