import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/parsers/b9feed.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  // ParserPodcastFeed.parseXMLFeed(xorumeXml);
  ParserPodcastFeed.parseXMLFeed(b9feed);
  // ParserPodcastFeed.parseXMLFeed(mamilosFeed);
}

class ParserPodcastFeed {
  static Podcast parseXMLFeed(String xmlFeed) {
    try {
      final feed = xml.parse(xmlFeed);
      if (feed != null) {
        final channel = feed.findElements('rss').first.findElements("channel").first;
        if (channel != null) {
          return Podcast.fromXML(channel);
        }
      }
    } catch (e) {
      if (e is xml.XmlParentException) {
        print(e.message);
      } else {
        print(e);
      }
    }

    return Podcast.empty();
  }
}
