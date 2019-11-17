import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/models/episode.dart';
import 'package:xml/xml.dart';

part 'podcast.g.dart';

@immutable
@JsonSerializable(nullable: false)
class Podcast {
  final int id;
  final String title, subtitle, summary, description, rssLink, podcastImg, author, lastBuildDate;
  final List<String> categories;
  final List<Episode> episodes;

  Podcast({
    @required this.title, //<channel><title>
    @required this.subtitle, //<channel><itunes:subtitle>
    @required this.summary, ////<channel><itunes:summary>
    @required this.description, //<channel><description>
    @required this.author, //<channel><title>
    @required this.rssLink, //<channel><atom:link> href
    @required this.podcastImg, //<channel><image><url>
    @required this.lastBuildDate, //<channel><lastBuildDate>
    this.categories, //<channel><itunes:category>[]
    this.episodes, //<channel><item>[]
    this.id,
  });

  factory Podcast.empty() {
    return Podcast(
      id: null,
      title: "",
      subtitle: "",
      summary: "",
      description: "",
      author: "",
      rssLink: "",
      podcastImg: "",
      lastBuildDate: "",
      categories: [],
      episodes: [],
    );
  }

  factory Podcast.fromJson(Map<String, dynamic> json) => _$PodcastFromJson(json);

  factory Podcast.fromXML(XmlElement channel) {
    final Iterable<String> categories = channel.findElements('itunes:category').map((XmlElement c) {
      return c.getAttribute('text');
    }).toList();

    final List<Episode> episodes = channel.findElements('item').map((item) {
      return Episode.fromXML(item);
    }).toList();

    return Podcast(
      title: channel.findElements('title').first.text,
      subtitle: channel.findElements('itunes:subtitle').first.text,
      summary: channel.findElements('itunes:summary').first.text,
      description: channel.findElements('description').first.text,
      author: channel.findElements('itunes:author').first.text,
      rssLink: channel.findElements('atom:link').first.getAttribute("href").toString(),
      podcastImg: channel.findElements('image').first.findElements('url').first.text,
      lastBuildDate: channel.findElements('lastBuildDate').first.text,
      categories: categories,
      episodes: episodes,
    );
  }

  factory Podcast.fromTableData(TablePodcast table) {
    return Podcast(
      id: table.id,
      title: table.title,
      subtitle: table.subtitle,
      summary: table.summary,
      description: table.description,
      author: table.author,
      rssLink: table.rssLink,
      podcastImg: table.podcastImg,
      lastBuildDate: table.lastBuildDate,
    );
  }

  Podcast copyWith({
    int id,
    String title,
    String subtitle,
    String summary,
    String author,
    String description,
    String rssLink,
    String podcastImg,
    String lastBuildDate,
    List<String> categories,
    List<Episode> episodes,
  }) {
    return Podcast(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      summary: summary ?? this.summary,
      description: description ?? this.description,
      author: author ?? this.author,
      rssLink: rssLink ?? this.rssLink,
      podcastImg: podcastImg ?? this.podcastImg,
      lastBuildDate: lastBuildDate ?? this.lastBuildDate,
      categories: categories ?? this.categories,
      episodes: episodes ?? this.episodes,
    );
  }

  Map<String, dynamic> toJson() => _$PodcastToJson(this);

  TablePodcast asTableEntry() {
    return TablePodcast(
      id: null,
      title: this.title,
      subtitle: this.subtitle,
      summary: this.summary,
      description: this.description,
      author: this.author,
      rssLink: this.rssLink,
      podcastImg: this.podcastImg,
      lastBuildDate: this.lastBuildDate,
      categories: this.categories.join(';'),
    );
  }
}
