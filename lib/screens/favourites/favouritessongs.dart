import 'package:flutter/material.dart';

import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';

import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:musicplayer_app/widgets/popupmenu.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouritesList extends StatefulWidget {
  const FavouritesList({super.key});

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(228, 0, 0, 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Liked Songs',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: favsongNotifier,
                  builder: (BuildContext cntx, List<AllsongsModel> favssongs,
                      Widget? child) {
                    return favssongs.isEmpty
                        ? const Center(
                            child: Text(
                              'No Liked Songs',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: favssongs.length,
                            itemBuilder: (context, index) {
                              var song = favssongs[index];
                              return FavSongList(
                                  song: song, favsong: favssongs, index: index);
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

class FavSongList extends StatefulWidget {
  FavSongList({
    super.key,
    required this.song,
    required this.favsong,
    required this.index,
  });
  AllsongsModel song;
  int index;
  List<AllsongsModel> favsong;
  @override
  State<FavSongList> createState() => _FavSongListState();
}

class _FavSongListState extends State<FavSongList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changeFormatesong(widget.index, widget.favsong);

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
                  DeleteFav(widget.song, context);
                });
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              )),
          PopUpMenuFunction(
            song: widget.song,
          )
        ],
      ),
    );
  }
}
