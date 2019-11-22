import 'package:flutter/services.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/models/podcast.dart';

class StateMain {
  List<Podcast> podcasts;
  bool isLight;

  Future<StateMain> build() async {
    final episodes = await PodTopDB().episodesDao.listAllEpisodes();
    final List<Podcast> podcasts = await PodTopDB().podcastsDao.listAllPodcasts;
    final settings = await PodTopDB().appSettingsDao.listAllSettings;

    final List<Podcast> state = [];
    for (Podcast podcast in podcasts) {
      final eps = episodes.where((ep) => ep.idPodcast == podcast.id).toList();
      state.add(podcast.copyWith(episodes: eps));
    }

    return StateMain()
      ..isLight = settings[0].isLight
      ..podcasts = state;
  }

  Brightness toogleIsLight() {
    isLight  = !isLight;
    return isLight ? Brightness.light : Brightness.dark;
  }

  void addPodcast(Podcast pod) {
    podcasts.add(pod);
  }

  List<Podcast> removePodcast(int idPodcast) {
    podcasts.removeWhere((p) => p.id == idPodcast);
    return podcasts;
  }
}
