import 'package:spotify_clone/operations/api_operations.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/widgets/main_page_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TimeOfDay day = TimeOfDay.now();
  String greetingText = "";
  @override
  void initState() {
    super.initState();

    switch (day.period) {
      case DayPeriod.am:
        greetingText = 'Good Morning';
        break;
      case DayPeriod.pm:
        greetingText = 'Good Evening';
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(233, 15, 15, 15),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
          child: Column(children: [
            MyWidgets().greetingContainer(greetingText),
            MyWidgets().listAudioType(),
            Container(
              padding: EdgeInsets.zero,
              child: MyWidgets().ShowUserPlaylist(),
            ),
            MyWidgets().ScrollableRowTitle(),
            MyWidgets().ScrollableRowContent(),
          ]),
        ),
      ),
    );
  }
}
