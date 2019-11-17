import 'package:flutter/material.dart';
import 'package:lib_observer/stream_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/translates.dart';
import 'package:provider/provider.dart';

class ViewListaPodcasts extends StatelessWidget {
  const ViewListaPodcasts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final b = Provider.of<BlocMain>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.meusPodcasts),
      ),
      body: Container(
        color: Colors.teal,
        child: Column(
          children: <Widget>[
            Text("Lista de podcasts"),
            StreamObserver(
              stream: b.outPodcasts,
              onSuccess: (_, List<Podcast> podcasts) {
                return Text("total de podcasts: ${podcasts.length}");
              },
            )
          ],
        ),
      ),
    );
  }
}
