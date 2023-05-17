import "package:flutter/material.dart";
import 'package:spotify_clone/operations/api_operations.dart';

class MyWidgets {
  Container greetingContainer(String greetingText) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  greetingText,
                  style: const TextStyle(
                    fontFamily: "SpotifyFont",
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    color: Colors.white,
                    Icons.notifications,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/clock.png",
                    width: 28,
                    height: 28,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    color: Colors.white,
                    Icons.settings,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container listAudioType() {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 0),
      height: 20,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              constraints: const BoxConstraints(maxWidth: 100),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Music',
                  style: TextStyle(
                    fontFamily: "SpotifyFont",
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    background: Paint()
                      ..strokeWidth = 20.0
                      ..color = const Color.fromARGB(255, 41, 41, 46)
                      ..style = PaintingStyle.stroke
                      ..strokeJoin = StrokeJoin.round,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: InkWell(
                onTap: () {
                  print("podcaste tıklandı");
                },
                child: Text(
                  'Podcasts and Programs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SpotifyFont",
                    fontSize: 13,
                    background: Paint()
                      ..strokeWidth = 20.0
                      ..color = const Color.fromARGB(255, 41, 41, 46)
                      ..style = PaintingStyle.stroke
                      ..strokeJoin = StrokeJoin.round,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container userPlaylists(String url, String text) {
    return Container(
      width: 200,
      height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 41, 41, 46),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
            child: Image(
              image: NetworkImage(url),
              height: 60,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: "SpotifyFont",
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
        ],
      ),
    );
  }

  GestureDetector rowAlbumCard2(String text, String imageUrl) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(imageUrl),
                width: 160,
                height: 160,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 160,
                child: Text(
                  text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: "SpotifyFont",
                    color: Color.fromARGB(152, 220, 220, 220),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Container ScrollableRowContent() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder(
              future: ApiOperations().fetchFeatured(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final items = snapshot.data!['playlists']['items'];
                  return SizedBox(
                    width: 210,
                    height: 210,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!['playlists']['limit'],
                        itemBuilder: (context, index) {
                          return MyWidgets().rowAlbumCard2(
                              items[index]['description'],
                              items[index]['images'][0]['url']);
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  FutureBuilder<Map<String, dynamic>> ScrollableRowTitle() {
    return FutureBuilder(
      future: ApiOperations().fetchFeatured(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            alignment: Alignment.topLeft,
            child: Text(
              snapshot.data!['message'],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Row ShowUserPlaylist() {
    return Row(
      children: [
        Expanded(
          child: FutureBuilder(
            future: ApiOperations().fetchUserAlbums(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: 200,
                  height: 250,
                  child: ListView.builder(
                    physics: const PageScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final images = snapshot.data!['items'][index]['images'];
                      final imageUrl = images != null && images.isNotEmpty
                          ? images[0]['url']
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png';
                      final name = snapshot.data!['items'][index]['name'];

                      return Column(
                        children: [
                          MyWidgets().userPlaylists(imageUrl, name),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: ApiOperations().fetchUserAlbums(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: 200,
                  height: 250,
                  child: ListView.builder(
                    physics: const PageScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final images =
                          snapshot.data!['items'][index + 3]['images'];
                      final imageUrl = images != null && images.isNotEmpty
                          ? images[0]['url']
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png';
                      final name = snapshot.data!['items'][index + 3]['name'];

                      return Column(
                        children: [
                          MyWidgets().userPlaylists(imageUrl, name),
                        ],
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    );
  }
}
