import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

ValueNotifier<List<AllsongsModel>> recently_played_notifier = ValueNotifier([]);

Future<void> getRecentlyPlayed() async {
  final recentlyDb = await Hive.openBox<AllsongsModel>('recently_db');
  recently_played_notifier.value.clear();
  recently_played_notifier.value.addAll(recentlyDb.values);
  recently_played_notifier.value =
      List<AllsongsModel>.from(recently_played_notifier.value.reversed);
  recently_played_notifier.notifyListeners();
}

Future<void> addRecently(AllsongsModel value) async {
  final recentlyDb = await Hive.openBox<AllsongsModel>('recently_db');
  int count = 0;
  int index = 0;
  for (var elements in recentlyDb.values) {
    if (elements.songId == value.songId) {
      recentlyDb.deleteAt(index);
    }
    index++;
  }
  final _recentId = await recentlyDb.add(value);
  value.id = _recentId;
  for (var elements in recentlyDb.values) {
    count++;
  }
  if (count > 15) {
    recentlyDb.deleteAt(0);
  }
  getRecentlyPlayed();
}
