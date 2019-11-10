import 'package:flutter/material.dart';
import 'package:podtop/src/models/podcast_dto.dart';
import 'package:podtop/src/models/podcast_search_result.dart';
import 'package:podtop/src/services/service_search.dart';
import 'package:podtop/src/translates.dart';

class ViewSearch extends StatefulWidget {
  const ViewSearch({Key key}) : super(key: key);

  @override
  _ViewSearchState createState() => _ViewSearchState();
}

class _ViewSearchState extends State<ViewSearch> {
  PodcastSearch search;
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    search = PodcastSearch.empty();
    controller = TextEditingController(text: "");
  }

  doSearch() async {
    if (controller.text.isEmpty) {
      search = PodcastSearch.empty();
    } else {
      final result = await searchByTerm(controller.text);
      setState(() => search = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.app_name),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: doSearch),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 2,
              child: TextFormField(
                controller: controller,
                onFieldSubmitted: (s) => doSearch(),
                decoration: InputDecoration(
                  labelText: "Pesquisar no ITunes",
                  hintText: "Nerdcast",
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: search.resultCount,
                separatorBuilder: (_, i) => Divider(),
                itemBuilder: (_, int i) {
                  Result result = search.results[i];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(result.artworkUrl60),
                    ),
                    trailing: Checkbox(
                      value: false,
                      tristate: false,
                      onChanged: (bool s) {},
                    ),
                    title: Text(result.artistName ?? ""),
                    subtitle: Text(result.artistViewUrl ?? ""),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
