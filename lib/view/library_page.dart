import 'package:flutter/material.dart';
import 'package:spotify_clone/operations/api_operations.dart';
import 'package:spotify_clone/widgets/library_page_widgets.dart';
import 'package:spotify_clone/widgets/main_page_widgets.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        flexibleSpace: Container(
          color: const Color.fromARGB(233, 15, 15, 15),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                LibraryPageWidgets().libraryPageAppbar(),
                LibraryPageWidgets().audioTypeBar(),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(233, 15, 15, 15),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              LibraryPageWidgets().filterUserPlaylists(),
              LibraryPageWidgets().showUserPlaylists()
            ],
          ),
        ),
      ),
    );
  }
}
