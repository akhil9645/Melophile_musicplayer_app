import 'package:flutter/material.dart';
import 'package:musicplayer_app/db/db_functions/playlist_db.dart';
import 'package:musicplayer_app/db/models/Playlist_model.dart';
import 'package:musicplayer_app/screens/library/playlist_functions.dart';
import 'package:quickalert/quickalert.dart';

class PopupMenu extends StatefulWidget {
  PopupMenu({super.key, required this.index, required this.playlistlist});
  int index;
  PlayListModel playlistlist;

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  final _playlistcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: playlist_notifier,
        builder: (BuildContext cntx, List<PlayListModel> playlistlist,
            Widget? child) {
          // int indx = playlistlist.length;
          return PopupMenuButton(
            color: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Edit Playlist Name',
                  child: ListTile(
                    leading: const Icon(
                      Icons.mode_edit_rounded,
                      color: Colors.white,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.info,
                          barrierDismissible: true,
                          confirmBtnText: 'Save',
                          confirmBtnColor: Colors.grey.shade800,
                          showCancelBtn: true,
                          widget: TextFormField(
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                hintText: 'Enter Name',
                                prefixIcon: Icon(
                                  Icons.edit_rounded,
                                ),
                                prefixIconColor: Colors.black),
                            cursorColor: const Color.fromARGB(255, 13, 13, 13),
                            controller: _playlistcontroller,
                          ),
                          onConfirmBtnTap: () {
                            updatePlaylist(_playlistcontroller.text,
                                widget.index, widget.playlistlist, context);
                            Navigator.pop(context);
                          });
                    },
                    title: const Text(
                      'Edit Playlist Name',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'Delete Playlist',
                  child: ListTile(
                    leading: Icon(
                      Icons.delete_rounded,
                      color: Colors.red.shade400,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Warning?',
                        text: 'Are you sure You want to delete this playlist',
                        showCancelBtn: true,
                        confirmBtnText: 'Confirm',
                        onConfirmBtnTap: () {
                          Navigator.pop(context);
                          deletePlaylist(
                              playlistlist[widget.index], widget.index);
                        },
                      );
                    },
                    title: const Text(
                      'Delete Playlist',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ];
            },
            padding: const EdgeInsets.only(left: 30),
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          );
        });
  }
}
