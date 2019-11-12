import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/parsers/b9feed.dart';
import 'package:podtop/src/parsers/xorumefeed.dart';
import 'package:xml/xml.dart' as xml;

void main() {
  ParserPodcastFeed.parseXMLFeed(xorumeXml);
  ParserPodcastFeed.parseXMLFeed(b9feed);
}

class ParserPodcastFeed {
  /* static void readB9() {
    try {
      final feed = xml.parse(b9feed);
      print(feed != null);
      final channel = feed.findElements('rss').first.findElements("channel").first;
      print(channel.findElements('title').first.text);
      print(channel.findElements('description').first.text);
      print(channel.findElements('lastBuildDate').first.text);
      print(channel.findElements('atom:link').first.getAttribute("href").toString());
      // final items = channel.findElements('item');
      // print(items != null);
      // items.forEach((item) => print(item.findElements('title').single.text));
    } catch (e) {
      if (e is xml.XmlParentException) {
        print(e.message);
      } else {
        print(e);
      }
    }
  } */

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
