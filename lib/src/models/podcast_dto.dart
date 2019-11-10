import 'package:json_annotation/json_annotation.dart';
import 'package:podtop/src/models/podcast_search_result.dart';

part 'podcast_dto.g.dart';

@JsonSerializable(nullable: true)
class PodcastSearch {
  int resultCount;
  List<Result> results;

  PodcastSearch({
    this.resultCount,
    this.results,
  });

  factory PodcastSearch.empty() {
    return PodcastSearch(
      resultCount: 0,
      results: [],
    );
  }

  factory PodcastSearch.fromJson(Map<String, dynamic> json) => _$PodcastSearchFromJson(json);

  Map<String, dynamic> toJson() => _$PodcastSearchToJson(this);
}
