import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:projectmap/screens/detail.dart';
import 'package:projectmap/screens/list.dart';

import 'home/map.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexScreen = 0;
  late List<Widget> _ScreenPage;
  late LatLng coordinate;

  @override
  void initState() {
    super.initState();
    _ScreenPage = <Widget>[
      Mymap(),
      // MyForm(),
      MyList()
    ];
  }

  void onItemTap(int index) {
    setState(() {
      indexScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ScreenPage.elementAt(indexScreen),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: indexScreen,
          onTap: onItemTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
            // BottomNavigationBarItem(icon: Icon(Icons.article), label: "Detail"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          ]),
    );
  }
}
