import 'package:flutter/material.dart';
import 'package:spotify_clone/view/library_page.dart';
import 'package:spotify_clone/view/main_page.dart';
import 'package:spotify_clone/view/search_page.dart';

class Tabbar extends StatefulWidget {
  @override
  _TabbarState createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) {
          setState(() {
            this._selectedTab = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search_outlined,
              size: 35,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_music,
              size: 35,
            ),
            label: "Your Library",
          ),
        ],
      ),
      body: Stack(
        children:  [
          renderView(
            0,
            const MainPage(),
          ),
          renderView(
            1,
            const SearchPage(),
          ),
          renderView(
            2,
            const LibraryPage(),
          ),
        ],
      ),
    );
  }

  Widget renderView(int tabIndex, Widget view) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }

  
}
