import 'package:flutter/material.dart';
import 'package:musicplayer_app/db/db_functions/playlist_db.dart';
import 'package:musicplayer_app/db/models/Playlist_model.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/library/add_playlist.dart';

class PopUpMenuFunction extends StatelessWidget {
  PopUpMenuFunction({super.key, required this.song});
  AllsongsModel song;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: 'Create New Playlist',
            child: ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreatePlaylist()));
                },
                icon: const Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Create New Playlist',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          PopupMenuItem<String>(
            value: 'Add to Playlist',
            child: ListTile(
              leading: IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  bottomSheet(context, song);
                },
              ),
              title: const Text(
                'Add to Playlist',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ];
      },
      icon: const Icon(
        Icons.playlist_add,
        color: Colors.white,
        size: 27,
      ),
    );
  }
}

Future bottomSheet(BuildContext cntx, AllsongsModel song) {
  return showModalBottomSheet(
      context: cntx,
      builder: (BuildContext context) {
        var mediaQuary = MediaQuery.of(context);
        return Container(
            height: 400,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: mediaQuary.size.height * 0.06,
                    width: mediaQuary.size.width * 0.5,
                    child: const Text(
                      'Existing Playlist',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    )),
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: playlist_notifier,
                    builder: (BuildContext context,
                        List<PlayListModel> playlistList, Widget? child) {
                      return ListView.builder(
                          itemCount: playlistList.length,
                          itemBuilder: (cntx, indx) {
                            var playlist = playlistList[indx];
                            bool isInPlaylist = checkPlay(song, indx);
                            return Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      playlist.name.toString(),
                                      style: const TextStyle(
                                          fontFamily: 'poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          if (!isInPlaylist) {
                                            addSongstoPlaylist(
                                                playlistList[indx], song);
                                            isInPlaylist = !isInPlaylist;
                                          } else {
                                            removeSong(song, playlist, indx);
                                            isInPlaylist = !isInPlaylist;
                                          }
                                        },
                                        icon: !isInPlaylist
                                            ? const Icon(
                                                Icons.add,
                                                color: Colors.black,
                                              )
                                            : const Icon(
                                                Icons.check,
                                                color: Colors.blue,
                                              ))
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ));
      });
}
