import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:async';
//import 'CropImagePage.dart';



class TakePicturePage extends StatefulWidget {
  const TakePicturePage({
    super.key,
  });

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller;
  final _cameraLoaded = Completer<bool>();
  var _isZooming = false;
  var _isTakingPicture = false;

  File? _imageFile;

  @override
  void initState() {
    super.initState();

    availableCameras().then((cameras) {
      _controller = CameraController(cameras.first, ResolutionPreset.medium)
        ..initialize().then((_) {
          setState(() {
            _cameraLoaded.complete(true);
          });
        }).onError((CameraException error, stackTrace) {
          if (error.code == 'CameraAccessDenied') {
            showDialog(
              context: context,
              builder: (context) => const SimpleDialog(
                children: [Text('カメラに撮影許可を出してください')],
              ),
            );
          }
        });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                FutureBuilder<bool>(
                  future: _cameraLoaded.future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error!}');
                    } else if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    return CameraPreview(_controller);
                  },
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey,
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            const Text('2倍ズーム'),
                            Switch(
                              value: _isZooming,
                              onChanged: zoomingChanged,
                            ),
                          ],
                        ),
                        Center(
                          child: FilledButton(
                            onPressed:
                                _cameraLoaded.isCompleted && !_isTakingPicture
                                    ? () {
                                        setState(() {
                                          _isTakingPicture = true;
                                        });
                                        onTakePicture(context).then((_) {
                                          setState(() {
                                            _isTakingPicture = false;
                                          });
                                        });
                                      }
                                    : null,
                            child: const Text('撮影'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (_imageFile != null)
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Image.file(_imageFile!),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> onTakePicture(BuildContext context) async {
    final image = await _controller.takePicture();
    setState(() {
      _imageFile = File(image.path);
    });
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        _imageFile = null;
      });
    });
  }

  void zoomingChanged(bool? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _isZooming = value;
    });
    _controller.setZoomLevel(_isZooming ? 2.0 : 1.0);
  }
}