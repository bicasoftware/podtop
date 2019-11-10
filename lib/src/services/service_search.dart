import 'package:podtop/src/models/podcast_dto.dart';
import 'package:podtop/src/extensions/http_ext.dart';
import 'package:http/http.dart' as http;

void main() {
  searchByTerm("mupoca").then((r) {
    print("count: ${r.resultCount}");
    r.results.forEach((d) => print(d.artistName));
  });
}

Future<PodcastSearch> searchByTerm(String term) async {
  final url = "https://itunes.apple.com/search?media=podcast&term=$term";
  final r = await http.get(url);

  if (r.statusCode == 200) {
    print(r);
    try {
      return PodcastSearch.fromJson(r.getAsJson());
    } catch (e) {
      return e;
    }
  } else if (r.statusCode == 400 || r.statusCode == 401) {
    print(r.body);
  }

  return PodcastSearch.empty();

}
