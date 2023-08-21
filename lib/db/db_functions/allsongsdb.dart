import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<AllsongsModel>> allsongsNotifier = ValueNotifier([]);

Future<void> addAllsongs(SongModel song) async {
  final allsongsdb = await Hive.openBox<AllsongsModel>('all_songs');
  bool check = false;
  AllsongsModel newSong = AllsongsModel(
      name: song.title,
      artist: song.artist,
      songId: song.id,
      duration: song.duration,
      uri: song.uri);
  for (var element in allsongsdb.values) {
    if (element.songId == newSong.songId) {
      check = true;
      break;
    }
  }

  if (check == false) {
    await allsongsdb.add(newSong);
    getAllSongs();
    allsongsNotifier.notifyListeners();
  }
}

Future<void> getAllSongs() async {
  final allsongsdb = await Hive.openBox<AllsongsModel>('all_songs');
  allsongsNotifier.value.clear();
  allsongsNotifier.value.addAll(allsongsdb.values);
  allsongsNotifier.notifyListeners();
}
