import 'package:flutter/material.dart';
import 'package:lib_observer/stream_observer.dart';
import 'package:podtop/src/bloc/bloc_main.dart';
import 'package:podtop/src/models/episode.dart';
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
      body: StreamObserver(
        stream: b.outPodcasts,
        onSuccess: (_, List<Podcast> podcasts) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: podcasts.length,
            itemBuilder: (_, int i) {
              final p = podcasts[i];
              return Dismissible(
                key: ObjectKey(p),
                confirmDismiss: (DismissDirection d) async {
                  return showConfirmationDialog(
                      context: context, title: "Cancelar", message: "Deseja cancelar a inscrição?");
                },
                onDismissed: (DismissDirection d) {
                  print(p.id);
                  b.unsubscribeOnPodcast(p.id);
                },
                child: ExpansionTile(
                  title: Text(p.title),
                  leading: Text((p.episodes?.length ?? 0).toString()),
                  children: <Widget>[
                    if (p.episodes != null && p.episodes.length > 0)
                      for (Episode e in p.episodes)
                        ListTile(
                          leading: Icon(Icons.audiotrack),
                          title: Text(e.title),
                          subtitle: Text(e.duration ?? "--:00"),
                        )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  static Future<bool> showRemoveDialog({
    @required BuildContext context,
    @required String title,
  }) async {
    return await showDialog(
      context: context,
      builder: (BuildContext c) {
        return SimpleDialog(
          title: Text(title),
          children: <Widget>[
            SimpleDialogOption(
              child: const Text("Cancelar assinatura"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<bool> showConfirmationDialog({
    @required BuildContext context,
    @required String message,
    String title,
    String yesButtonText,
    String noButtonText,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ""),
          actions: <Widget>[
            FlatButton(
              child: Text(noButtonText ?? "Não"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text(yesButtonText ?? "Sim"),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
          content: Container(
            child: Text(message),
          ),
        );
      },
    );
  }
}
