import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';

class SongDuration extends StatefulWidget {
  const SongDuration({super.key});

  @override
  State<SongDuration> createState() => _SongsDurationState();
}

class _SongsDurationState extends State<SongDuration> {
  Duration currentDuration = const Duration(seconds: 0);
  Duration duration = const Duration(seconds: 0);
  Duration songDuration = const Duration();
  String mm = '';
  String ss = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PlayerBuilder.currentPosition(
              player: audioPlayer,
              builder: (context, position) {
                currentDuration = position;
                mm = (currentDuration.inMinutes % 60).toString();
                ss = (currentDuration.inSeconds % 60).toString();
                return Text(
                  '$mm:$ss',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                );
              }),
          PlayerBuilder.current(
              player: audioPlayer,
              builder: (context, playing) {
                songDuration = playing.audio.duration;
                mm = (songDuration.inMinutes % 60).toString();
                ss = (songDuration.inSeconds % 60).toString();
                return Text(
                  '$mm:$ss',
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                );
              }),
        ],
      ),
    );
  }
}
