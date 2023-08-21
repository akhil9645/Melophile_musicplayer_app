import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

final audioPlayer = AssetsAudioPlayer();

var duration = '';
var position = '';

ValueNotifier<bool> isSongPlayingNotifier = ValueNotifier(false);

List<Audio> audioSongs = [];

changeFormatesong(int index, List<AllsongsModel>? currentSongs) {
  bool songOn = true;
  isSongPlayingNotifier.value = songOn;
  isSongPlayingNotifier.notifyListeners();
  audioSongs.clear();
  if (currentSongs != null) {
    for (var element in currentSongs) {
      audioSongs.add(Audio.file(element.uri ?? 'song name',
          metas: Metas(
            id: element.songId.toString(),
            artist: element.artist,
            title: element.name,
          )));
    }
  }
  audioPlayer.open(
      Playlist(
        audios: audioSongs,
        startIndex: index,
      ),
      loopMode: LoopMode.playlist,
      autoStart: true,
      showNotification: true);
}

AllsongsModel changeToSongModel(int songId) {
  late AllsongsModel data;
  for (var element in allsongsNotifier.value) {
    if (element.songId == songId) {
      data = element;
      break;
    }
  }
  return data;
}
