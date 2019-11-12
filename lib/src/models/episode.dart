import 'package:meta/meta.dart';
import 'package:xml/xml.dart';

@immutable
class Episode {
  final String title, subtitle, summary, author, duration, mp3Link;

  Episode({
    this.title, //<item><title>
    this.subtitle, //<item><itunes:subtitle>
    this.summary, //<item><itunes:summary>
    this.author, //<item><author>
    this.duration, //<item><itunes:duration>
    this.mp3Link, //<item><enclosure url="">
  });

  Episode copyWith({
    String title,
    String subtitle,
    String summary,
    String author,
    String duration,
    String mp3Link,
  }) {
    return Episode(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      summary: summary ?? this.summary,
      author: author ?? this.author,
      duration: duration ?? this.duration,
      mp3Link: mp3Link ?? this.mp3Link,
    );
  }

  factory Episode.fromXML(XmlElement xml) {
    return Episode(
      title: xml.findElements('title').first.text,
      subtitle: xml.findElements('itunes:subtitle').first.text,
      summary: xml.findElements('itunes:summary').first.text,
      author: xml.findElements('itunes:author').first.text,
      duration: xml.findSafeElement('itunes:duration')?.text ?? "--:--:--",
      mp3Link: xml.findElements('enclosure').first.getAttribute('url'),
    );
  }
}

extension XmlExtension on XmlElement {
  XmlElement findSafeElement(String tagName) {
    if (this.findElements(tagName).length > 0) {
      return this.findElements(tagName).first;
    } else {
      return null;
    }
  }
}
