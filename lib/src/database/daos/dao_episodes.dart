import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/database/tables/table_episode.dart';
import 'package:podtop/src/models/episode.dart';

part 'dao_episodes.g.dart';

@UseDao(tables: [TableEpisodes])
class EpisodesDao extends DatabaseAccessor<PodTopDB> with _$EpisodesDaoMixin {
  EpisodesDao(PodTopDB db) : super(db);

  Future<List<TableEpisode>> get listAllEpisodes => select(tableEpisodes).get();

  Future<List<TableEpisode>> listEpisodesByPodcast(int podcastId) async {
    return (select(tableEpisodes)
      ..where((e) => e.idPodcast.equals(podcastId))).get();
  }

  Future<int> appendSingle(int podcastId, Episode ep) async {
    return await into(tableEpisodes).insert(ep.asTableEntry(podcastId));
  }
}
