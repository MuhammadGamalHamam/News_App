import 'package:BreakingNews/Screens/science_screen.dart';
import 'package:BreakingNews/Screens/trending_screen.dart';
import 'package:BreakingNews/Screens/world_screen.dart';
import 'package:flutter/material.dart';
import 'package:BreakingNews/Screens/home_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  PageController _pageController = PageController(initialPage: 0);
  bool themeContent = false;


  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = true;

  Color selectedColor = Colors.black;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.white;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeContent
          ? ThemeData.dark().copyWith(
              accentColor: Colors.red,
              primaryTextTheme: TextTheme(
                  headline1: TextStyle(color: Colors.white),
                  headline2: TextStyle(color: Colors.white)))
          : ThemeData(
              primaryColor: Colors.white,
              accentColor: Colors.red[800],
              primaryTextTheme: TextTheme(
                  headline1: TextStyle(color: Colors.black),
                  headline2: TextStyle(color: Colors.black87))),
      home: Scaffold(
        
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: snakeBarStyle,
          snakeShape: snakeShape,
          shape: bottomBarShape,
          padding: padding,
          selectedLabelStyle: TextStyle(color: Colors.white),
          unselectedLabelStyle:
              TextStyle(color: themeContent ? Colors.white : Colors.black),
          snakeViewColor: selectedColor,
          selectedItemColor:
              snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: themeContent ? Colors.white : Colors.black,
          showUnselectedLabels: showUnselectedLabels,
          showSelectedLabels: showSelectedLabels,
          currentIndex: selectedPage,
          onTap: (newindex) {
            setState(() {
              selectedPage = newindex;
              _pageController.animateToPage(newindex,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.flaskOutline),
              label: 'Science',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'World',
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          children: [
            HomeScreen(),
            TrendingScreen(),
            ScienceScreen(),
            WorldScreen(),
          ],
        ),
      ),
    );
  }
}
