import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:xml/xml.dart';
import 'package:podtop/src/extensions/xml_ext.dart';

part 'episode.g.dart';

@immutable
@JsonSerializable(nullable: false)
class Episode {
  final int id, idPodcast;
  final String title, subtitle, summary, author, duration, mp3Link, stopTime;
  final bool listened;

  Episode({
    @required this.title, //<item><title>
    @required this.subtitle, //<item><itunes:subtitle>
    @required this.summary, //<item><itunes:summary>
    @required this.author, //<item><author>
    @required this.duration, //<item><itunes:duration>
    @required this.mp3Link, //<item><enclosure url="">
    this.stopTime = "00:00",
    this.listened = false,
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
    bool listened,
    String stopTime,
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
      listened: listened ?? this.listened,
      stopTime: stopTime ?? this.stopTime,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  factory Episode.fromXML(XmlElement xml) {
    try {
      return Episode(
        title: xml.findSafeElement('title')?.text ?? "",
        subtitle: xml.findSafeElement('itunes:subtitle')?.text ?? "",
        summary: xml.findSafeElement('itunes:summary')?.text ?? "",
        author: xml.findSafeElement('itunes:author')?.text ?? "",
        duration: xml.findSafeElement('itunes:duration')?.text ?? "--:--:--",
        mp3Link: xml.findSafeElement('enclosure').getAttribute('url'),
      );
    } catch (e) {
      print("falha ao carregar episodio ${xml.findSafeElement('title').text}");
      return Episode.empty();
    }
  }

  factory Episode.empty() {
    return Episode(
      id: -1,
      idPodcast: -1,
      title: "",
      subtitle: "",
      summary: "",
      author: "",
      duration: "",
      mp3Link: "",
      listened: false,
      stopTime: "",
    );
  }

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  factory Episode.fromTableData(TbEpisode episode) {
    return Episode(
      id: episode.id,
      idPodcast: episode.idPodcast,
      title: episode.title,
      subtitle: episode.subtitle,
      summary: episode.summary,
      author: episode.author,
      duration: episode.duration,
      mp3Link: episode.mp3Link,
      listened: episode.listened,
      stopTime: episode.stopTime,
    );
  }

  TbEpisode asTableEntry(int idPodcast) {
    return TbEpisode(
      id: null,
      idPodcast: idPodcast,
      title: this.title,
      subtitle: this.subtitle,
      summary: this.summary,
      author: this.author,
      duration: this.duration,
      mp3Link: this.mp3Link,
      listened: this.listened,
      stopTime: this.stopTime,
    );
  }
}
