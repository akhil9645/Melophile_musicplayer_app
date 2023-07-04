import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/audio_functions/controller.dart';
import 'package:musicplayer_app/db/db_functions/mostplayed.dart';
import 'package:musicplayer_app/db/db_functions/playlist_db.dart';
import 'package:musicplayer_app/db/db_functions/recentlyplayed.dart';
import 'package:musicplayer_app/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkpermission();
    getAllSongs();
    getPlaylist();
    getMostPlayed();
    getRecentlyPlayed();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(247, 10, 11, 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.music_note_rounded,
                size: 53,
                color: Color.fromARGB(200, 141, 31, 208),
              ),
              Text(
                'Melophile',
                style: TextStyle(
                    color: Color.fromARGB(200, 141, 31, 208),
                    fontFamily: 'Poppins',
                    fontSize: 44,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
