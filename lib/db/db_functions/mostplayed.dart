import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

ValueNotifier<List<AllsongsModel>> mostplayed_notifier = ValueNotifier([]);

Future<void> addMostPlayed(AllsongsModel song) async {
  final mostplayed_db = await Hive.openBox<AllsongsModel>('mostplayed_db');
  int forcount = 0;
  int index = 0;
  for (var dbelements in mostplayed_db.values) {
    if (song.songId == dbelements.songId) {
      forcount++;
      break;
    }
    index++;
  }
  if (forcount == 0) {
    song.count = 1;
    final _mostid = await mostplayed_db.add(song);
    song.id = _mostid;
  } else {
    AllsongsModel? mostSong = mostplayed_db.get(index);
    mostSong?.count = mostSong.count! + 1;
    mostplayed_db.deleteAt(index);
    final _mostid = await mostplayed_db.add(song);
    song.id = _mostid;
  }
  getMostPlayed();
}

Future<void> getMostPlayed() async {
  final mostplayed_db = await Hive.openBox<AllsongsModel>('mostplayed_db');
  mostplayed_notifier.value.clear();
  mostplayed_notifier.value.addAll(mostplayed_db.values);
  AllsongsModel temp;
  for (var i = 0; i < mostplayed_notifier.value.length; i++) {
    for (var j = i + 1; j < mostplayed_notifier.value.length; j++) {
      if (mostplayed_notifier.value[i].count != null &&
          mostplayed_notifier.value[j].count != null &&
          mostplayed_notifier.value[i].count! <
              mostplayed_notifier.value[j].count!) {
        temp = mostplayed_notifier.value[i];
        mostplayed_notifier.value[i] = mostplayed_notifier.value[j];
        mostplayed_notifier.value[j] = temp;
      }
    }
  }
  mostplayed_notifier.notifyListeners();
}
