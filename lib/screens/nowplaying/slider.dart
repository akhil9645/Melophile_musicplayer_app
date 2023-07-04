import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';

class SongSlider extends StatefulWidget {
  const SongSlider({super.key});

  @override
  State<SongSlider> createState() => _SongSliderState();
}

class _SongSliderState extends State<SongSlider> {
  Duration currentDuration = Duration(seconds: 0);
  Duration duration = Duration(seconds: 0);
  Duration songDuration = Duration();

  double sliderValue = 0.0;

  double maxSliderValue = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.current.listen((Playing) {
      if (Playing != null) {
        duration = Playing.audio.duration;
        maxSliderValue = Playing.audio.duration.inSeconds.toDouble();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.currentPosition(
        player: audioPlayer,
        builder: (context, position) {
          sliderValue = position.inSeconds.toDouble();
          return Slider(
            activeColor: Colors.white70,
            thumbColor: Colors.white,
            value: sliderValue,
            min: 0.0,
            max: maxSliderValue,
            onChanged: (value) {
              setState(
                () {
                  sliderValue = value;
                  audioPlayer.seek(Duration(seconds: value.toInt()));
                },
              );
            },
          );
        });
  }
}
