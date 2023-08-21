import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/mostlyplayed/mostfunctions.dart';
import 'package:musicplayer_app/screens/nowplaying/nowplayingbuttons.dart';
import 'package:musicplayer_app/screens/nowplaying/slider.dart';
import 'package:musicplayer_app/screens/nowplaying/song_duration.dart';
import 'package:musicplayer_app/screens/recentylyplayed/recentlyfunctions.dart';
import 'package:musicplayer_app/widgets/popupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return PlayerBuilder.current(
      player: audioPlayer,
      builder: (context, playing) {
        AllsongsModel thisSong =
            changeToSongModel(int.parse(playing.audio.audio.metas.id!));
        recentAdd(int.parse(playing.audio.audio.metas.id!));
        mostAdd(int.parse(playing.audio.audio.metas.id!));
        bool isfav = isFavsong(thisSong);

        return Scaffold(
          backgroundColor: const Color.fromARGB(247, 20, 21, 20),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
            actions: [
              PopUpMenuFunction(
                song: thisSong,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  width: screenwidth - 60,
                  height: screenwidth - 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: QueryArtworkWidget(
                      id: int.parse(playing.audio.audio.metas.id ?? ''),
                      type: ArtworkType.AUDIO,
                      artworkBorder: BorderRadius.circular(25),
                      artworkFit: BoxFit.fill,
                      nullArtworkWidget: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/fonts/images/songicon.jpg',
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 65,
                ),
                SizedBox(
                  width: screenwidth - 40,
                  height: screenheight * 0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              playing.audio.audio.metas.title ?? 'Song Name',
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          IconButton(
                              color: Colors.white,
                              onPressed: () {
                                setState(() {
                                  if (isfav) {
                                    DeleteFav(thisSong, context);
                                    isfav = !isfav;
                                  } else {
                                    addToFav(thisSong, context);
                                    isfav = !isfav;
                                  }
                                });
                              },
                              icon: !isfav
                                  ? const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                        ],
                      ),
                      SizedBox(
                        width: screenwidth - 60,
                        child: Text(
                          playing.audio.audio.metas.artist ?? 'Artist Name',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                const SongSlider(),
                const SongDuration(),
                const SizedBox(
                  height: 25,
                ),
                const NowPlayingButtons(),
              ],
            ),
          ),
        );
      },
    );
  }
}
