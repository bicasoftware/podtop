import 'package:json_annotation/json_annotation.dart';

part 'podcast_search_result.g.dart';

@JsonSerializable(nullable: true)
class Result {
  String wrapperType;
  String kind;
  int artistId;
  int collectionId;
  int trackId;
  String artistName;
  String collectionName;
  String trackName;
  String collectionCensoredName;
  String trackCensoredName;
  String artistViewUrl;
  String collectionViewUrl;
  String feedUrl;
  String trackViewUrl;
  String artworkUrl30;
  String artworkUrl60;
  String artworkUrl100;
  double collectionPrice;
  double trackPrice;
  int trackRentalPrice;
  int collectionHdPrice;
  int trackHdPrice;
  int trackHdRentalPrice;
  String releaseDate;
  String collectionExplicitness;
  String trackExplicitness;
  int trackCount;
  String country;
  String currency;
  String primaryGenreName;
  String contentAdvisoryRating;
  String artworkUrl600;
  List<String> genreIds;
  List<String> genres;
  String previewUrl;
  int discCount;
  int discNumber;
  int trackNumber;
  int trackTimeMillis;
  bool isStreamable;

  Result({
    this.wrapperType,
    this.kind,
    this.artistId,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.artistViewUrl,
    this.collectionViewUrl,
    this.feedUrl,
    this.trackViewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.trackRentalPrice,
    this.collectionHdPrice,
    this.trackHdPrice,
    this.trackHdRentalPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.trackCount,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.contentAdvisoryRating,
    this.artworkUrl600,
    this.genreIds,
    this.genres,
    this.previewUrl,
    this.discCount,
    this.discNumber,
    this.trackNumber,
    this.trackTimeMillis,
    this.isStreamable,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
