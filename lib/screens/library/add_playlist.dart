import 'package:flutter/material.dart';
import 'package:musicplayer_app/screens/library/playlist_functions.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({super.key});

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  final _playlistcontroller = TextEditingController();
  final playlistKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String fontfamily = 'Poppins';
    final double ScreenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(247, 66, 64, 11),
        body: Stack(
          children: [
            Positioned(
              top: 10,
              left: 5,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
            Positioned(
              left: 15,
              right: 15,
              top: ScreenHeight * 0.35,
              height: ScreenHeight * 0.26,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: ScreenHeight * 0.03,
                    ),
                    Text(
                      'Give Your Playlist a Name',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),
                    SizedBox(
                      height: ScreenHeight * 0.02,
                    ),
                    TextFormField(
                      key: playlistKey,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamily,
                          fontSize: 18),
                      controller: _playlistcontroller,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter your Playlist name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontFamily: fontfamily,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenHeight * 0.04,
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          Colors.white30,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        if (playlistKey.currentState?.validate() ?? true) {
                          changeToPlaylist(_playlistcontroller.text, context);
                        } else {
                          print('Error');
                        }
                      },
                      child: Text(
                        'Create',
                        style: TextStyle(
                            fontFamily: fontfamily,
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
