import 'package:hive_flutter/hive_flutter.dart';
part 'all_songs_model.g.dart';

@HiveType(typeId: 1)
class AllsongsModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? artist;

  @HiveField(3)
  int? songId;

  @HiveField(4)
  int? duration;

  @HiveField(5)
  String? uri;

  @HiveField(6)
  int? count;

  AllsongsModel(
      {required this.name,
      required this.artist,
      required this.songId,
      required this.duration,
      required this.uri,
      this.count,
      this.id});
}
