import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/database/tables/table_episode.dart';
import 'package:podtop/src/models/episode.dart';

part 'dao_episodes.g.dart';

@UseDao(tables: [TbEpisodes])
class EpisodesDao extends DatabaseAccessor<PodTopDB> with _$EpisodesDaoMixin {
  EpisodesDao(PodTopDB db) : super(db);

  Future<List<Episode>> listAllEpisodes() async {
    final episodes = await select(tbEpisodes).get();
    return episodes.map((e) => Episode.fromTableData(e)).toList();
  }

  Future<List<Episode>> listEpisodesByPodcast(int podcastId) async {
    final List<TbEpisode> episodes =
        await (select(tbEpisodes)..where((e) => e.idPodcast.equals(podcastId))).get();

    return episodes.map((ep) => Episode.fromTableData(ep)).toList();
  }

  Future<int> appendSingle(int podcastId, Episode ep) async {
    return await into(tbEpisodes).insert(ep.asTableEntry(podcastId));
  }

  Future removeEpisodesByPodcastId(int podcastId) async {
    return (delete(tbEpisodes)..where((e) => e.idPodcast.equals(podcastId))).go();
  }
}
