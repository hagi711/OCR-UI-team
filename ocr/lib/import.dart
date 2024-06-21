import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImportPage extends StatefulWidget {
  const ImportPage({Key? key}) : super(key: key);
  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends State {
  File? image;
  final picker = ImagePicker();

  Future getImage() async {
    final XFile? _image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_image != null) {
        image = File(_image.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('読み込む画像を選んでください'),
      ),
      body: Center(
        child: image == null
            ? const Text('画像がありません')
            : Image.file(image!, fit: BoxFit.cover),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getImage();
        },
        child: const Icon(Icons.photo),
      ),
    );
  }
}
