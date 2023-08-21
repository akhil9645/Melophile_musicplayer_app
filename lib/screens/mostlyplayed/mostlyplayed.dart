import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/db_functions/mostplayed.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:musicplayer_app/widgets/popupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MostlyPlayed extends StatefulWidget {
  const MostlyPlayed({super.key});

  @override
  State<MostlyPlayed> createState() => _MostlyPlayedState();
}

class _MostlyPlayedState extends State<MostlyPlayed> {
  late Box<AllsongsModel> mostlyBox;

  @override
  void initState() {
    super.initState();
    mostlyBox = Hive.box('mostplayed_db');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(247, 14, 14, 13),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 55,
                  ),
                  const Text(
                    'Mostly Played',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: mostplayed_notifier,
                  builder: (BuildContext cntx, List<AllsongsModel> mostSongs,
                      Widget? child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            mostSongs.length < 10 ? mostSongs.length : 10,
                        itemBuilder: (context, index) {
                          var mostsong = mostSongs[index];
                          bool isfavsong = isFavsong(mostsong);
                          return SongMostlyPlayed(
                              index: index,
                              isFav: isfavsong,
                              mostSong: mostsong,
                              mostSongs: mostSongs);
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SongMostlyPlayed extends StatefulWidget {
  SongMostlyPlayed({
    super.key,
    required this.index,
    required this.isFav,
    required this.mostSong,
    required this.mostSongs,
  });
  AllsongsModel mostSong;
  int index;
  List<AllsongsModel> mostSongs;
  bool isFav;

  @override
  State<SongMostlyPlayed> createState() => _SongMostlyPlayedState();
}

class _SongMostlyPlayedState extends State<SongMostlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changeFormatesong(widget.index, widget.mostSongs);

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NowPlaying()));
      },
      leading: QueryArtworkWidget(
        id: widget.mostSong.songId!,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: const CircleAvatar(
          backgroundImage: AssetImage('assets/fonts/images/songicon.jpg'),
          radius: 25,
        ),
      ),
      title: Text(
        widget.mostSong.name ?? 'song name',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        widget.mostSong.artist ?? 'Artist Name',
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
                if (!widget.isFav) {
                  addToFav(widget.mostSong, context);
                  widget.isFav = !widget.isFav;
                } else {
                  DeleteFav(widget.mostSong, context);
                  widget.isFav = !widget.isFav;
                }
              });
            },
            icon: !widget.isFav
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
            song: widget.mostSong,
          )
        ],
      ),
    );
  }
}
