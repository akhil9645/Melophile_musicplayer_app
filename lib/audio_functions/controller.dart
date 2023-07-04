import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

final songQuery = OnAudioQuery();

List<SongModel> allsonglist = [];
List<SongModel> mp3songslist = [];
checkpermission() async {
  final permission = await Permission.storage.request();
  if (permission.isGranted) {
    allsonglist = await songQuery.querySongs();

    for (var element in allsonglist) {
      if (element.fileExtension == 'mp3') {
        mp3songslist.add(element);
      }
    }
    for (var element in mp3songslist) {
      addAllsongs(element);
    }
  } else {
    checkpermission();
  }
}
