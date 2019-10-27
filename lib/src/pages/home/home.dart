import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/translates.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Scaffold(
      appBar: AppBar(
        title: StreamObserver<String>(
          stream: b.outNome,
          onSuccess: (_, String nome) => Text(Strings.app_name),
        ),
      ),
      body: Container(
        child: Card(
          elevation: 2,
          child: ListTile(
            title: Text("Ubuntu"),
          ),
        ),
      ),
    );
  }
}
