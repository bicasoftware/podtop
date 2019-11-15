import 'package:podtop/src/models/podcast_dto.dart';
import 'package:podtop/src/extensions/http_ext.dart';
import 'package:http/http.dart' as http;

void main() {
  ServiceSearch.searchByTerm("mupoca").then((r) {
    print("count: ${r.resultCount}");
    r.results.forEach((d) => print(d.artistName));
  });

  ServiceSearch.testFeedUpdate().then((_) => print("finalizado"));
}

class ServiceSearch {
  static Future<PodcastSearch> searchByTerm(String term) async {
    final url = "https://itunes.apple.com/search?media=podcast&term=$term";
    final r = await http.get(url);

    if (r.statusCode == 200) {
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

  static Future testFeedUpdate() async {
    final url = "https://www.xorume.com.br/feed/podcast/";
    final isModifiedHeader = "If-Modified-Since";
    final lastModifiedHeader = "Mon, 11 Nov 2019 02:59:49 GMT";
    final r = await http.get(url, headers: {isModifiedHeader: lastModifiedHeader});

    if (r.statusCode == 200) {
      print("wasModified");
    } else if (r.statusCode == 304) {
      print("wasnModified");
    } else if (r.statusCode == 400 || r.statusCode == 401) {
      print("Falha ao conectar");
    }
  }
}
