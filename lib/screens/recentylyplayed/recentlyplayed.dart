import 'package:flutter/material.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/db_functions/recentlyplayed.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:musicplayer_app/widgets/popupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(149, 17, 17, 16),
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
                    'Recently Played',
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
                  valueListenable: recently_played_notifier,
                  builder: (BuildContext cntx, List<AllsongsModel> recentSongs,
                      Widget? child) {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: recentSongs.length,
                        itemBuilder: (context, index) {
                          var song = recentSongs[index];
                          bool isfavsong = isFavsong(song);
                          return SongRecentlyPlayed(
                              index: index,
                              isFav: isfavsong,
                              song: song,
                              recentSongs: recentSongs);
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

class SongRecentlyPlayed extends StatefulWidget {
  SongRecentlyPlayed({
    super.key,
    required this.index,
    required this.isFav,
    required this.song,
    required this.recentSongs,
  });
  AllsongsModel song;
  int index;
  List<AllsongsModel> recentSongs;
  bool isFav;

  @override
  State<SongRecentlyPlayed> createState() => _SongRecentlyPlayedState();
}

class _SongRecentlyPlayedState extends State<SongRecentlyPlayed> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changeFormatesong(widget.index, widget.recentSongs);

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
        widget.song.artist ?? 'Artist Name',
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
                  addToFav(widget.song, context);
                  widget.isFav = !widget.isFav;
                } else {
                  DeleteFav(widget.song, context);
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
            song: widget.song,
          )
        ],
      ),
    );
  }
}
