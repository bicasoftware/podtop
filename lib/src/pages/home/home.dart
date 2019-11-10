import 'package:flutter/material.dart';
import 'package:lib_observer/lib_observer.dart';
import 'package:morpheus/widgets/morpheus_tab_view.dart';
import 'package:podtop/src/pages/view_lista_podcasts/view_lista_podcasts.dart';
import 'package:podtop/src/pages/view_novos/view_novos.dart';
import 'package:podtop/src/pages/view_search/view_search.dart';
import 'package:podtop/src/translates.dart';
import 'package:rxdart/rxdart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  BehaviorSubject<int> _bhsPos = BehaviorSubject<int>();
  Stream<int> get outPos => _bhsPos.stream;
  Sink<int> get inPos => _bhsPos.sink;

  static const pages = [
    const ViewNovos(),
    const ViewListaPodcasts(),
    const ViewSearch(),
  ];

  TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(
      vsync: this,
      length: 3,
      initialIndex: 0,
    );
    inPos.add(0);
  }

  @override
  void dispose() {
    _bhsPos.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamObserver(
          stream: outPos,
          onSuccess: (_, int pos) {
            return MorpheusTabView(
              child: pages[pos],
            );
          },
        ),
        bottomNavigationBar: StreamObserver(
          stream: outPos,
          onSuccess: (_, int pos) {
            return BottomNavigationBar(
              currentIndex: pos,
              onTap: (int pos) => inPos.add(pos),
              elevation: 4,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.fiber_new),
                  title: Text(Strings.novos),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.view_list),
                  title: Text(Strings.meusPodcasts),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.find_in_page),
                  title: Text(Strings.procurar),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
