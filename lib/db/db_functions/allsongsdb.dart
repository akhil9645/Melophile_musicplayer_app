import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

ValueNotifier<List<AllsongsModel>> AllsongsNotifier = ValueNotifier([]);

Future<void> addAllsongs(SongModel song) async {
  final allsongs_db = await Hive.openBox<AllsongsModel>('all_songs');
  bool check = false;
  AllsongsModel newSong = AllsongsModel(
      name: song.title,
      artist: song.artist,
      songId: song.id,
      duration: song.duration,
      uri: song.uri);
  for (var element in allsongs_db.values) {
    if (element.songId == newSong.songId) {
      check = true;
      break;
    }
  }

  if (check == false) {
    await allsongs_db.add(newSong);
    getAllSongs();
    AllsongsNotifier.notifyListeners();
  }
}

Future<void> getAllSongs() async {
  final allsongs_db = await Hive.openBox<AllsongsModel>('all_songs');
  AllsongsNotifier.value.clear();
  AllsongsNotifier.value.addAll(allsongs_db.values);
  AllsongsNotifier.notifyListeners();
}
