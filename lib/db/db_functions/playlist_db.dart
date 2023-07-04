import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/db/models/Playlist_model.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

ValueNotifier<List<PlayListModel>> playlist_notifier = ValueNotifier([]);

Future<void> createPlaylistDb(
    PlayListModel playlistitem, BuildContext context) async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  bool check = false;
  for (var elements in playlist_db.values) {
    if (elements.name == playlistitem.name) {
      check = true;
      break;
    }
  }
  if (check == false) {
    final playlist_id = await playlist_db.add(playlistitem);
    playlistitem.id = playlist_id;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('This Name is already exist'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey.shade700,
    ));
  }
  getPlaylist();
}

Future<void> getPlaylist() async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  playlist_notifier.value.clear();
  playlist_notifier.value.addAll(playlist_db.values);
  playlist_notifier.notifyListeners();
}

Future<void> addSongstoPlaylist(
    PlayListModel playlistitem, AllsongsModel song) async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  int index = 0;
  bool check = false;
  List<AllsongsModel> temp = [];
  for (var elements in playlist_db.values) {
    if (playlistitem == elements) {
      break;
    }
    index++;
  }
  String? name = playlistitem.name;
  List<AllsongsModel> currentSongs = playlistitem.songs ?? temp;
  for (var elements in currentSongs) {
    if (song.songId == elements.songId) {
      check = true;
      break;
    }
  }
  if (check == false) {
    currentSongs.add(song);
  }
  PlayListModel newsong = PlayListModel(name: name, songs: currentSongs);
  playlist_db.putAt(index, newsong);
  getPlaylist();
}

Future<void> deletePlaylist(PlayListModel item, int index) async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  playlist_db.deleteAt(index);
  getPlaylist();
}

Future<void> updatePlaylistDb(
    PlayListModel newitem, int index, BuildContext context) async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  bool check = false;
  for (var elements in playlist_db.values) {
    if (elements.name == newitem.name) {
      check = true;
      break;
    }
  }
  if (check == false) {
    playlist_db.putAt(index, newitem);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('This Name is already exist'),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.grey.shade700,
    ));
  }
  getPlaylist();
}

Future<void> removeSong(
    AllsongsModel? song, PlayListModel item, int index) async {
  final playlist_db = await Hive.openBox<PlayListModel>('playlist_db');
  bool check = false;
  List<AllsongsModel> temp = [];
  int songIndx = 0;
  String? name = item.name;
  List<AllsongsModel> currentSongs = item.songs ?? temp;
  for (var elements in currentSongs) {
    if (song?.songId == elements.songId) {
      check = true;
      break;
    }
    songIndx++;
  }
  if (check == true) {
    currentSongs.removeAt(songIndx);
  }
  PlayListModel newsong = PlayListModel(name: name, songs: currentSongs);
  await playlist_db.putAt(index, newsong);
  getPlaylist();
}

bool checkPlay(AllsongsModel song, int index) {
  PlayListModel item = playlist_notifier.value[index];
  List<AllsongsModel> temp = [];
  List<AllsongsModel> songs = item.songs ?? temp;
  for (var elements in songs) {
    if (elements.songId == song.songId) {
      return true;
    }
  }
  return false;
}
