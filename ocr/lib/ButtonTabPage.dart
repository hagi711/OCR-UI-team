import 'package:flutter/material.dart';
import './camera.dart';
import './import.dart';
import './Menu.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage>  {

  int _currentIndex = 0;
  final _pageWidgets = [
    CameraPage(),
    ImportPage(),
    MenuPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OCR Scheduler'),
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt),label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.vertical_align_bottom),label: 'Import'),
          BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Menu'),
        ],
        currentIndex: _currentIndex,
        fixedColor: Colors.blueAccent,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index );
}