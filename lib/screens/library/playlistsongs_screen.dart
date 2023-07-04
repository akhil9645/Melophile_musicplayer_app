import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:musicplayer_app/audio_functions/assetsauidoplayer.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/db_functions/playlist_db.dart';
import 'package:musicplayer_app/db/models/Playlist_model.dart';

import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/nowplaying/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistSongs extends StatefulWidget {
  PlaylistSongs({super.key, required this.playlist, required this.indx});
  PlayListModel playlist;
  int indx;

  @override
  State<PlaylistSongs> createState() => _PlaylistSongsState();
}

class _PlaylistSongsState extends State<PlaylistSongs> {
  late Box<PlayListModel> playlistBox;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlistBox = Hive.box('playlist_db');
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.playlist.name.toString(),
            style: const TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.yellow,
                color: Colors.white,
                fontFamily: 'poppins',
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: playlist_notifier,
              builder: (BuildContext context, List<PlayListModel> playlistlist,
                  Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.playlist.songs?.length ?? 0,
                  itemBuilder: (context, index) {
                    var song = playlistlist[widget.indx].songs?[index];
                    bool isFav = isFavsong(song!);
                    return SongsInPlaylist(
                        song: song,
                        playlistindex: widget.indx,
                        allsongs: playlistlist[widget.indx].songs,
                        index: index,
                        isFavsong: isFavsong(song),
                        item: widget.playlist);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SongsInPlaylist extends StatefulWidget {
  SongsInPlaylist({
    super.key,
    required this.song,
    required this.playlistindex,
    required this.allsongs,
    required this.index,
    required this.isFavsong,
    required this.item,
  });
  AllsongsModel? song;
  PlayListModel item;
  bool isFavsong;
  int index;
  List<AllsongsModel>? allsongs;
  int playlistindex;

  @override
  State<SongsInPlaylist> createState() => _SongsInPlaylistState();
}

class _SongsInPlaylistState extends State<SongsInPlaylist> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        changeFormatesong(widget.index, widget.allsongs);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => NowPlaying()));
      },
      leading: QueryArtworkWidget(
        id: widget.song?.songId ?? 0,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: const CircleAvatar(
          backgroundImage: AssetImage('assets/fonts/images/songicon.jpg'),
          radius: 25,
        ),
      ),
      title: Text(
        widget.song?.name ?? 'song name',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        widget.song?.artist ?? 'artist name',
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
                if (!widget.isFavsong) {
                  addToFav(widget.song!, context);
                  widget.isFavsong = !widget.isFavsong;
                } else {
                  DeleteFav(widget.song!, context);
                  widget.isFavsong = !widget.isFavsong;
                }
              });
            },
            icon: !widget.isFavsong
                ? Icon(
                    Icons.favorite_border_rounded,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
            iconSize: 28,
          ),
          IconButton(
            onPressed: () {
              removeSong(widget.song, widget.item, widget.playlistindex);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            iconSize: 28,
          ),
        ],
      ),
    );
  }
}
