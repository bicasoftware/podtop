import 'package:flutter/material.dart';
import 'package:podtop/src/bloc/base_bloc.dart';
import 'package:podtop/src/database/podtop_db.dart';
import 'package:podtop/src/models/podcast.dart';
import 'package:podtop/src/parsers/parser_podcast_feed.dart';
import 'package:rxdart/rxdart.dart';

class BlocMain with BaseBloc {
  BlocMain({@required this.isLight, @required this.podcasts}) {
    inBrightness.add(isLight ? Brightness.light : Brightness.dark);
    inPodcasts.add(podcasts);
  }

  bool isLight;
  final List<Podcast> podcasts;

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
    isLight = !isLight;
    inBrightness.add(isLight ? Brightness.light : Brightness.dark);
  }

  Future subscribeOnPodcast(String podcastLink) async {
    final Podcast podcast = ParserPodcastFeed.parseXMLFeed(podcastLink);
    if (podcast != Podcast.empty()) {
      final insertedPodcast = await PodTopDB().podcastsDao.appendPodcast(podcast);
      ///TODO - inserir Episodios! e passar os dados pro [inPodcasts]
      podcasts.add(insertedPodcast);      
    }
  }

  Future unsubscribeOnPodcast(int idPodcast) async {
    await PodTopDB().podcastsDao.removePodcast(idPodcast);
  }
}
