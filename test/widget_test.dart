import 'package:flutter_test/flutter_test.dart';
import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/parsers/b9feed.dart';
import 'package:podtop/src/parsers/parser_podcast_feed.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {});

  group('parsing feeds', () {
    test('parse braincast', () {
      final podcast = ParserPodcastFeed.parseXMLFeed(b9feed);
      assert(podcast != null && podcast != Podcast.empty());
    });
  });
}
