import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:xml/xml.dart';

part 'episode.g.dart';

@immutable
@JsonSerializable(nullable: false)
class Episode {
  final int id, idPodcast;
  final String title, subtitle, summary, author, duration, mp3Link;

  Episode({
    @required this.title, //<item><title>
    @required this.subtitle, //<item><itunes:subtitle>
    @required this.summary, //<item><itunes:summary>
    @required this.author, //<item><author>
    @required this.duration, //<item><itunes:duration>
    @required this.mp3Link, //<item><enclosure url="">
    this.id,
    this.idPodcast,
  });

  Episode copyWith({
    int id,
    int idPodcast,
    String title,
    String subtitle,
    String summary,
    String author,
    String duration,
    String mp3Link,
  }) {
    return Episode(
      id: id ?? this.id,
      idPodcast: idPodcast ?? this.idPodcast,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      summary: summary ?? this.summary,
      author: author ?? this.author,
      duration: duration ?? this.duration,
      mp3Link: mp3Link ?? this.mp3Link,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

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

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  TableEpisode asTableEntry(int idPodcast) {
    return TableEpisode(
      id: null,
      idPodcast: idPodcast,
      title: this.title,
      subtitle: this.subtitle,
      summary: this.summary,
      author: this.author,
      duration: this.duration,
      mp3Link: this.mp3Link,
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
