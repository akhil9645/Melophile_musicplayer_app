import 'package:flutter/material.dart';
import 'package:musicplayer_app/db/db_functions/playlist_db.dart';
import 'package:musicplayer_app/db/models/Playlist_model.dart';

Future<void> changeToPlaylist(String playlistName, BuildContext context) async {
  String name = playlistName;
  PlayListModel newplaylist = PlayListModel(name: name);
  createPlaylistDb(newplaylist, context);
}

Future<void> updatePlaylist(
    String name, int index, PlayListModel item, BuildContext context) async {
  PlayListModel newOne = PlayListModel(name: name, songs: item.songs);
  updatePlaylistDb(newOne, index, context);
}
