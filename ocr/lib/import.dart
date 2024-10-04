//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:firebase_storage/firebase_storage.dart';
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
    final imagefile = File(image!.path);
    //FirebaseStorage storage = FirebaseStorage.instance;
    //await storage.ref('sample.png').putFile(imagefile);
  }

  Future upload(File imagefile) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    await storage.ref('sample.png').putFile(imagefile);
  }

  Widget buttonfunc(bool value, File? file) {
    if (!value) {
      return Column(
        children: [
          Image.file(file!, fit: BoxFit.cover), //！！画像がでかすぎるとボタンがはみ出る！！
          const SizedBox(height: 30),
          OutlinedButton(
              onPressed: () async {
                upload(file);
              },
              style: OutlinedButton.styleFrom(
                  fixedSize: const Size(500, 50),
                  textStyle: const TextStyle(fontSize: 30)), //(横、高さ))
              child: const Text('はい')),
          const SizedBox(height: 15),
          OutlinedButton(
              onPressed: () async {
                getImage();
              },
              style: OutlinedButton.styleFrom(
                  fixedSize: const Size(500, 50),
                  textStyle: const TextStyle(fontSize: 30)),
              child: Text('いいえ'))
        ],
      );
    } else {
      return const Text('画像がありません');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: image == null
            ? const Text('読み込む画像を選んでください')
            : const Text('この画像をアップロードしますか？'),
      ),
      body: Center(child: buttonfunc(image == null, image)),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getImage();
        },
        child: const Icon(Icons.photo),
      ),
    );
  }
}
