import 'package:flutter/material.dart';
import 'package:spotify_clone/operations/api_operations.dart';

class LibraryPageWidgets {
  Container libraryPageAppbar() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://datepsychology.com/wp-content/uploads/2022/09/gigachad.jpg"),
              ),
              SizedBox(
                width: 15,
                height: 0,
              ),
              Text(
                "Library",
                style: TextStyle(
                    fontFamily: "SpotifyFont",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
              IconButton(iconSize: 30, onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ))
        ],
      ),
    );
  }

  Container audioTypeBar() {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 0),
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
                child: Expanded(
                  child: Text(
                    'Playlists',
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
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(right: 15),
              constraints: const BoxConstraints(maxWidth: 200),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Artists',
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
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(maxWidth: 200),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Downloads',
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

  Row filterUserPlaylists() {
    return Row(
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: const [
                Icon(
                  Icons.compare_arrows,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Last updated",
                  style:
                      TextStyle(color: Colors.white, fontFamily: "SpotifyFont"),
                )
              ],
            )),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  FutureBuilder<Map<String, dynamic>> showUserPlaylists() {
    return FutureBuilder(
              future: ApiOperations().fetchUserAlbums(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView.count(
                    physics: const BouncingScrollPhysics(),
                    childAspectRatio: 6.40 / 7,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    shrinkWrap: true,
                    children: List.generate(snapshot.data!['items'].length,
                        (index) {
                      final images = snapshot.data!['items'][index]['images'];
                      final imageUrl = images != null && images.isNotEmpty
                          ? images[0]['url']
                          : 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Spotify_App_Logo.svg/2048px-Spotify_App_Logo.svg.png';

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage(imageUrl),
                            fit: BoxFit.cover,
                            width: 160,
                            height: 160,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 160,
                              height: 160,
                              child: Text(
                                snapshot.data!['items'][index]['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: "SpotifyFont",
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      );
                    }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            );
  }
}
