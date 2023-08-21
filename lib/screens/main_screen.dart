import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/db_functions/mostplayed.dart';
import 'package:musicplayer_app/db/db_functions/recentlyplayed.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/favourites/favouritessongs.dart';
import 'package:musicplayer_app/screens/homescreen/home_screen.dart';
import 'package:musicplayer_app/screens/library/librarys.dart';
import 'package:musicplayer_app/screens/mostlyplayed/mostfunctions.dart';
import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:musicplayer_app/screens/recentylyplayed/recentlyfunctions.dart';
import 'package:musicplayer_app/screens/searchscreen/search_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    getAllFav();
    getAllSongs();
    getMostPlayed();
    getRecentlyPlayed();

    super.initState();
  }

  int currentScreen = 0;
  var screens = const [
    HomeScreen(),
    FavouritesList(),
    SearchScreen(),
    Library()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentScreen],
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
              valueListenable: isSongPlayingNotifier,
              builder: (BuildContext context, isPlay, Widget? child) {
                return isPlay ? const MiniPlayer() : const SizedBox();
              }),
          Container(
            color: const Color.fromARGB(247, 10, 11, 20),
            child: GNav(
              iconSize: 27,
              gap: 12,
              color: Colors.white,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(18),
              tabs: const [
                GButton(
                  icon: Icons.home_filled,
                  text: 'Home',
                  textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                GButton(
                  icon: Icons.favorite,
                  iconColor: Colors.red,
                  text: 'Favourites',
                  active: true,
                  textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                GButton(
                  icon: Icons.search,
                  active: true,
                  text: 'Search',
                  textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
                GButton(
                  icon: Icons.my_library_music_rounded,
                  text: 'Library',
                  textStyle: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ],
              onTabChange: (value) {
                setState(() {
                  currentScreen = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.current(
        player: audioPlayer,
        builder: (context, playing) {
          AllsongsModel thisSong =
              changeToSongModel(int.parse(playing.audio.audio.metas.id!));
          recentAdd(int.parse(playing.audio.audio.metas.id!));
          mostAdd(int.parse(playing.audio.audio.metas.id!));

          return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (cntx) {
                  return const NowPlaying();
                }));
              },
              child: Container(
                color: const Color.fromARGB(247, 39, 59, 74),
                width: double.infinity,
                height: 65,
                child: ClipRRect(
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.black,
                        child: QueryArtworkWidget(
                            id: int.parse(playing.audio.audio.metas.id!),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/fonts/images/songicon.jpg'),
                              radius: 22,
                            )),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            playing.audio.audio.metas.title!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      playing.audio.audio.metas.artist!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'poppins', color: Colors.white70),
                    ),
                    trailing: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            audioPlayer.previous();
                          },
                          color: Colors.white,
                          icon: const Icon(Icons.skip_previous_rounded),
                          iconSize: 30,
                        ),
                        PlayerBuilder.isPlaying(
                            player: audioPlayer,
                            builder: (cntx, isPlaying) {
                              return IconButton(
                                  onPressed: () {
                                    if (isPlaying) {
                                      audioPlayer.pause();
                                    } else {
                                      audioPlayer.play();
                                    }
                                  },
                                  color: Colors.white,
                                  iconSize: 35,
                                  icon: isPlaying
                                      ? const Icon(Icons.pause)
                                      : const Icon(Icons.play_arrow));
                            }),
                        IconButton(
                            onPressed: () {
                              audioPlayer.next();
                            },
                            color: Colors.white,
                            iconSize: 30,
                            icon: const Icon(Icons.skip_next_rounded)),
                        IconButton(
                            onPressed: () {
                              audioPlayer.stop();

                              setState(() {
                                isPlaying = false;
                                isSongPlayingNotifier.value = isPlaying;
                                isSongPlayingNotifier.notifyListeners();
                              });
                            },
                            color: Colors.white,
                            iconSize: 25,
                            icon: const Icon(Icons.stop)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
