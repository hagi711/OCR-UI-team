import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  //const CameraPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "Menu Page",
          style: TextStyle(
            fontSize: 20
          ),
        ),
      ),
    );
  }
}