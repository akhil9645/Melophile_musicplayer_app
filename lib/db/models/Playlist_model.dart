import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

part 'Playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  List<AllsongsModel>? songs;

  PlayListModel({required this.name, this.songs, this.id});
}
