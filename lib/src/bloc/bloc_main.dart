import 'package:flutter/material.dart';
import 'package:podtop/src/bloc/base_bloc.dart';
import 'package:podtop/src/bloc/state_main.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/services/service_search.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain({@required this.state}) {
    inBrightness.add(state.isLight ? Brightness.light : Brightness.dark);
    inPodcasts.add(state.podcasts);
  }

  StateMain state;

  BehaviorSubject<Brightness> _bhsBrightness = BehaviorSubject<Brightness>();
  Stream<Brightness> get outBrightness => _bhsBrightness.stream;
  Sink<Brightness> get inBrightness => _bhsBrightness.sink;

  BehaviorSubject<List<Podcast>> _bhsPodcasts = BehaviorSubject<List<Podcast>>();
  Stream<List<Podcast>> get outPodcasts => _bhsPodcasts.stream;
  Sink<List<Podcast>> get inPodcasts => _bhsPodcasts.sink;

  @override
  void dispose() {
    _bhsBrightness.close();
    _bhsPodcasts.close();
  }

  void toggleBrightness() {
    inBrightness.add(state.toogleIsLight());
  }

  Future subscribeOnPodcast(String podcastLink) async {
    final Podcast podcast = await ServiceSearch.getPodcastXMLFeed(podcastLink);
    print(podcast.episodes.length);
    if (podcast != Podcast.empty()) {
      final insertedPodcast = await PodTopDB().podcastsDao.appendPodcast(podcast);
      state.addPodcast(insertedPodcast);
    }

    inPodcasts.add(state.podcasts);
  }

  Future unsubscribeOnPodcast(int idPodcast) async {
    await PodTopDB().podcastsDao.removePodcast(idPodcast);    
    inPodcasts.add(state.removePodcast(idPodcast));
  }
}
