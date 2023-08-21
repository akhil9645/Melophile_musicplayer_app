import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';

class NowPlayingButtons extends StatefulWidget {
  const NowPlayingButtons({super.key});

  @override
  State<NowPlayingButtons> createState() => _NowPlayingButtonsState();
}

class _NowPlayingButtonsState extends State<NowPlayingButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlayerBuilder.isPlaying(
            player: audioPlayer,
            builder: (cntx, isPlaying) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      audioPlayer.toggleShuffle();
                    }
                  });
                },
                icon: const Icon(
                  Icons.shuffle_rounded,
                  color: Colors.green,
                ),
                iconSize: 25,
              );
            }),
        PlayerBuilder.isPlaying(
            player: audioPlayer,
            builder: (cntx, isPlaying) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      audioPlayer.previous();
                    }
                  });
                },
                icon: Icon(
                  Icons.skip_previous_rounded,
                  color: Colors.white.withOpacity(0.8),
                ),
                iconSize: 45,
              );
            }),
        PlayerBuilder.isPlaying(
            player: audioPlayer,
            builder: (cntx, isPlaying) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      audioPlayer.pause();
                    } else {
                      audioPlayer.play();
                    }
                  });
                },
                icon: isPlaying
                    ? Icon(
                        Icons.pause_circle_filled_rounded,
                        color: Colors.white.withOpacity(0.8),
                      )
                    : Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white.withOpacity(0.8),
                      ),
                iconSize: 70,
              );
            }),
        PlayerBuilder.isPlaying(
            player: audioPlayer,
            builder: (cntx, isPlaying) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      audioPlayer.next();
                    }
                  });
                },
                icon: Icon(
                  Icons.skip_next_rounded,
                  color: Colors.white.withOpacity(0.8),
                ),
                iconSize: 45,
              );
            }),
        PlayerBuilder.isPlaying(
            player: audioPlayer,
            builder: (cntx, isPlaying) {
              return IconButton(
                onPressed: () {
                  setState(() {
                    if (isPlaying) {
                      audioPlayer.setLoopMode(
                        LoopMode.single,
                      );
                    }
                  });
                },
                icon: Icon(
                  Icons.repeat_rounded,
                  color: Colors.white.withOpacity(0.8),
                ),
                iconSize: 25,
              );
            }),
      ],
    );
  }
}
