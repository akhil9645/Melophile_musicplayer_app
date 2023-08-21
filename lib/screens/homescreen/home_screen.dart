import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/widgets/popupmenu.dart';
import 'package:musicplayer_app/screens/mostlyplayed/mostlyplayed.dart';
import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:musicplayer_app/screens/recentylyplayed/recentlyplayed.dart';
import 'package:musicplayer_app/screens/settings/settings.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<AllsongsModel> allsongBox;
  @override
  void initState() {
    super.initState();
    allsongBox = Hive.box('all_songs');
  }

  int index = 0;
  var screens = const [MostlyPlayed(), RecentlyPlayed()];
  @override
  Widget build(BuildContext context) {
    final double screenheight = MediaQuery.of(context).size.height;
    final double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 10, 11, 20),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
            },
            icon: const Icon(
              Icons.settings,
              size: 28,
              color: Colors.white70,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Enjoy your favourite Music',
                    style: TextStyle(
                        color: Colors.white70,
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: screenheight * 0.2,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screens[index]));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 4, right: 5),
                            height: screenheight,
                            width: screenwidth * 0.45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/fonts/images/songicon.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Mostly Played',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Recently Played',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      'All Songs',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Flexible(
                    child: ValueListenableBuilder(
                      valueListenable: allsongsNotifier,
                      builder: (context, List<AllsongsModel> allSongs, child) {
                        return allSongs.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: allSongs.length,
                                itemBuilder: (context, index) {
                                  var song = allSongs[index];
                                  bool isfav = isFavsong(song);
                                  return AllSongsListWidget(
                                    allsongs: allSongs,
                                    index: index,
                                    song: song,
                                    isfavsong: isfav,
                                  );
                                },
                              )
                            : const Center(
                                child: Text(
                                  'No Songs Found',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllSongsListWidget extends StatefulWidget {
  AllSongsListWidget(
      {super.key,
      required this.song,
      required this.allsongs,
      required this.isfavsong,
      required this.index});
  AllsongsModel song;
  int index;
  List<AllsongsModel> allsongs;
  bool isfavsong;

  @override
  State<AllSongsListWidget> createState() => _AllSongsListWidgetState();
}

class _AllSongsListWidgetState extends State<AllSongsListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changeFormatesong(widget.index, widget.allsongs);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NowPlaying()));
      },
      leading: QueryArtworkWidget(
        id: widget.song.songId!,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: const CircleAvatar(
          backgroundImage: AssetImage('assets/fonts/images/songicon.jpg'),
          radius: 25,
        ),
      ),
      title: Text(
        widget.song.name ?? 'song name',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        widget.song.artist ?? 'artist name',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white54,
          fontFamily: 'Poppins',
          fontSize: 14,
        ),
      ),
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                if (!widget.isfavsong) {
                  addToFav(widget.song, context);
                  widget.isfavsong = !widget.isfavsong;
                } else {
                  DeleteFav(widget.song, context);
                  widget.isfavsong = !widget.isfavsong;
                }
              });
            },
            icon: !widget.isfavsong
                ? const Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
            iconSize: 28,
          ),
          PopUpMenuFunction(
            song: widget.song,
          )
        ],
      ),
    );
  }
}
