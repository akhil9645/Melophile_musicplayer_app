import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musicplayer_app/db/db_functions/allsongsdb.dart';
import 'package:musicplayer_app/db/db_functions/favsongdb.dart';
import 'package:musicplayer_app/db/models/all_songs_model.dart';
import 'package:musicplayer_app/screens/homescreen/home_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  List<AllsongsModel> allsongsListsearch =
      Hive.box<AllsongsModel>('all_songs').values.toList();

  late List<AllsongsModel> allsongsDisplay =
      List<AllsongsModel>.from(allsongsListsearch);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(247, 22, 21, 21),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Search',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 45,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autofocus: true,
                cursorColor: Color.fromARGB(255, 13, 13, 13),
                controller: _searchController,
                style: const TextStyle(fontFamily: 'Poppins', fontSize: 16),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  prefixIconColor: Colors.black,
                  suffixIcon: IconButton(
                      onPressed: () {
                        clearText();
                      },
                      icon: Icon(Icons.clear)),
                  suffixIconColor: Colors.black,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Search Songs',
                  hintStyle: const TextStyle(
                      color: Colors.black, fontFamily: 'Poppins', fontSize: 15),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                ),
                onChanged: (value) {
                  _searchSongs(value.trim());
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: allsongsNotifier,
                  builder: (context, List<AllsongsModel> allSongs, child) {
                    return allsongsDisplay.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemCount: allsongsDisplay.length,
                            itemBuilder: (context, index) {
                              var song = allsongsDisplay[index];
                              bool isfavsong = isFavsong(song);
                              return AllSongsListWidget(
                                allsongs: allsongsDisplay,
                                index: index,
                                song: song,
                                isfavsong: isfavsong,
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'No Songs Found',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 28,
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
      ),
    );
  }

  void _searchSongs(String value) {
    setState(() {
      allsongsDisplay = allsongsListsearch
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void clearText() {
    _searchController.clear();
  }
}
