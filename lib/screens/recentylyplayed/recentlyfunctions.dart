import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/db_functions/recentlyplayed.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

List<AllsongsModel> recentlylist = [];

Future<void> recentAdd(int songID) async {
  for (var elements in AllsongsNotifier.value) {
    if (elements.songId == songID) {
      recentlylist.insert(0, elements);
      addRecently(recentlylist[0]);
    }
  }
}
