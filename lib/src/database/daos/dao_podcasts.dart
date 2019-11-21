import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/database/tables/table_podcast.dart';
import 'package:podtop/src/models/episode.dart';
import 'package:podtop/src/models/podcast.dart';

part 'dao_podcasts.g.dart';

@UseDao(tables: [TbPodcasts])
class PodcastsDao extends DatabaseAccessor<PodTopDB> with _$PodcastsDaoMixin {
  PodcastsDao(PodTopDB db) : super(db);

  Future<List<Podcast>> get listAllPodcasts async {
    final List<TbPodcast> dt = await select(tbPodcasts).get();
    var podcasts = dt.map((TbPodcast podcast) => Podcast.fromTableData(podcast)).toList();

    for(Podcast pod in podcasts) {
      final ep = await PodTopDB().episodesDao.listEpisodesByPodcast(pod.id);
      pod = pod.copyWith(episodes : ep);
    }

    return podcasts;
  }

  Future<Podcast> appendPodcast(Podcast podcast) async {
    final int p = await into(tbPodcasts).insert(podcast.asTableEntry());
    await transaction(() async {
      podcast.episodes.forEach((Episode ep) async {
        final int epId = await db.episodesDao.appendSingle(p, ep);
        ep = ep.copyWith(id: epId);
      });
    });

    return podcast.copyWith(id: p);
  }

  Future removePodcast(int podcastId) async {
    (delete(tbPodcasts)..where((p) => p.id.equals(podcastId))).go();
    await PodTopDB().episodesDao.removeEpisodesByPodcastId(podcastId);
  }
}
