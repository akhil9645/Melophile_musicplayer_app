import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

ValueNotifier<List<AllsongsModel>> favsongNotifier = ValueNotifier([]);

Future<void> addToFav(AllsongsModel value, BuildContext context) async {
  final favSongDb = await Hive.openBox<AllsongsModel>('favsongs');
  bool check = true;
  for (var favsongs in favSongDb.values) {
    if (value.songId == favsongs.songId) {
      check = false;
    }
  }
  if (check == true && value != null) {
    final key = await favSongDb.add(value);
    value.id = key;
    getAllFav();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 1),
        content: Text(
          'Added to Favourites',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.grey.shade700,
      ),
    );
  }
}

Future<void> getAllFav() async {
  final favSongDb = await Hive.openBox<AllsongsModel>('favsongs');
  favsongNotifier.value.clear();
  favsongNotifier.value.addAll(favSongDb.values);
  favsongNotifier.notifyListeners();
}

Future<void> DeleteFav(AllsongsModel song, BuildContext context) async {
  final favSongDb = await Hive.openBox<AllsongsModel>('favsongs');
  bool check = false;
  int index = 0;
  for (var deletesong in favSongDb.values) {
    if (deletesong.songId == song.songId) {
      check = true;
      break;
    }
    index++;
  }
  if (check == true) {
    favSongDb.deleteAt(index);
  }
  getAllFav();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1),
    content: Text(
      'Removed From Favourites',
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.grey.shade700,
  ));
}

isFavsong(AllsongsModel value) {
  for (var isFav in favsongNotifier.value) {
    if (value.songId == isFav.songId) {
      return true;
    }
  }
  return false;
}
