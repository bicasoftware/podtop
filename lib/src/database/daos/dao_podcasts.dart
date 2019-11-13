import 'package:moor_flutter/moor_flutter.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/database/tables/table_podcast.dart';
import 'package:podtop/src/models/episode.dart';
import 'package:podtop/src/models/podcast.dart';

part 'dao_podcasts.g.dart';

@UseDao(tables: [TablePodcasts])
class PodcastsDao extends DatabaseAccessor<PodTopDB> with _$PodcastsDaoMixin {
  PodcastsDao(PodTopDB db) : super(db);

  Future<List<TablePodcast>> get listAllPodcasts => select(tablePodcasts).get();

  Future<Podcast> appendPodcast(Podcast podcast) async {
    final int p = await into(tablePodcasts).insert(podcast.asTableEntry());
    await transaction(() async {
      podcast.episodes.forEach((Episode ep) async {
        final int epId = await db.episodesDao.appendSingle(p, ep);
        ep = ep.copyWith(id: epId);
      });
    });

    return podcast.copyWith(id: p);
  }
}
