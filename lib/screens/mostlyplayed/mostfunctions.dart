import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/db_functions/mostplayed.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

List<AllsongsModel> mostPlayedList = [];

Future<void> mostAdd(int songID) async {
  for (var elements in AllsongsNotifier.value) {
    if (elements.songId == songID) {
      mostPlayedList.insert(0, elements);
      addMostPlayed(mostPlayedList[0]);
    }
  }
}
