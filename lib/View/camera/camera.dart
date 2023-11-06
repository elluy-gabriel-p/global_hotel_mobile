import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:ugdlayout2/database/sql_helper.dart';
import '../camera/display_picture.dart';
import '../camera/loging_utils.dart';

class CameraView extends StatefulWidget {
  final int id;
  const CameraView({super.key, required this.id});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late int idUser;
  Future<void>? _initializeCameraFuture;
  late CameraController _cameraController;
  var count = 0;

  @override
  void initState() {
    super.initState();
    idUser = widget.id;
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    LoggingUtils.logStartFunction('initialize camera'.toUpperCase());
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    _initializeCameraFuture = _cameraController.initialize();
    if (mounted) {
      setState(() {});
      LoggingUtils.logEndFunction('success initialize camera'.toUpperCase());
    }
  }

  Future<void> updateProfilePicture(Uint8List image) async {
    // Perbarui foto profil pengguna di database.
    SQLHelper.updateProfilePicture(idUser, image);

    // Kembali ke halaman Profile.
    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    LoggingUtils.logStartFunction('dispose cameraView'.toUpperCase());
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeCameraFuture == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a picture'),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await previewImageResult(idUser),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<DisplayPictureScreen?> previewImageResult(int id) async {
    String activity = 'PREVIEW IMAGE RESULT';
    LoggingUtils.logStartFunction(activity);
    try {
      await _initializeCameraFuture;
      final image = await _cameraController.takePicture();
      if (!mounted) return null;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            _cameraController.pausePreview();
            LoggingUtils.logDebugValue(
                'get image on previewImageResult'.toUpperCase(),
                'image.path: ${image.path}');
            return DisplayPictureScreen(
              imagePath: image.path,
              cameraController: _cameraController,
              id: id,
            );
          },
        ),
      );
    } catch (e) {
      LoggingUtils.logError(activity, e.toString());
      return null;
    }
    return null;
  }
}
