import 'package:flutter/material.dart';
import 'camera.dart';
import './import.dart';
import './Menu.dart';

class BottomTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BottomTabPageState();
  }
}

class _BottomTabPageState extends State<BottomTabPage> {

  int _currentIndex = 0;
  final _pageWidgets = [
    TakePicturePage(),
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
          const BottomNavigationBarItem(icon: Icon(Icons.camera_alt),label: 'Camera'),
          const BottomNavigationBarItem(icon: Icon(Icons.vertical_align_bottom),label: 'Import'),
          const BottomNavigationBarItem(icon: Icon(Icons.menu),label: 'Menu'),
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