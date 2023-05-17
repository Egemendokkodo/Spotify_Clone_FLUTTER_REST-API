import 'package:flutter/material.dart';
import 'package:spotify_clone/operations/api_operations.dart';
import 'dart:math' as math;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(233, 15, 15, 15),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Search",
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "SpotifyFont",
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 50,
                    child: TextFieldCustom()),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: IntrinsicWidth(
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          "Genres & Moods",
                          style: TextStyle(
                            fontFamily: "SpotifyFont",
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: FutureBuilder(
                      future: ApiOperations().fetchCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.count(
                            childAspectRatio: (20 / 10),
                            crossAxisCount: 2,
                            physics: const ScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            shrinkWrap: true,
                            children: List.generate(
                                snapshot.data!['categories']['items'].length,
                                growable: false, (index) {
                              return Container(
                                color: Color(
                                        (math.Random().nextDouble() * 0xFFFFFF)
                                            .toInt())
                                    .withOpacity(1.0),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            right: 15, bottom: 10),
                                        width: 50,
                                        height: 50,
                                        transformAlignment: Alignment.center,
                                        transform: Matrix4.rotationZ(
                                          3.1415926535897932 / 4,
                                        ),
                                        child: Image.network(
                                          snapshot.data!['categories']['items']
                                              [index]['icons'][0]['url'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 5, top: 5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data!['categories']['items']
                                              [index]['name'],
                                          style: const TextStyle(
                                            fontFamily: "SpotifyFont",
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          );
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

TextField TextFieldCustom() {
  return const TextField(
    textAlignVertical: TextAlignVertical.bottom,
    keyboardType: TextInputType.name,
    decoration: InputDecoration(
      prefixIcon: Icon(
        Icons.search,
        color: Colors.black,
      ),
      hintText: "Artist, songs or podcasts",
      hintStyle: TextStyle(
          color: Color.fromARGB(195, 54, 54, 54), fontFamily: "SpotifyFont"),
      contentPadding: EdgeInsets.all(20),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
    ),
  );
}
