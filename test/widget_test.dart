import 'package:flutter_test/flutter_test.dart';
import 'package:podtop/src/models/podcast_dto.dart';
import 'package:podtop/src/models/podcast_search_result.dart';
import 'package:podtop/src/services/service_search.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});

  group('chamadas', () {
    test('search itunes', () async {
      await searchByTerm("braincast").then((PodcastSearch p) {
        print(p?.resultCount);
        p?.results?.forEach((Result r) => print(r.artistName));
      });
    });
  });
}
