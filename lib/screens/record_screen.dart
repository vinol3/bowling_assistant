import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late CameraController _controller;
  late Future<void> _initializeCamera;
  bool _isRecording = false;

  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();

    // Only initialize camera on mobile and if cameras are available
    if (_isMobile && cameras.isNotEmpty) {
      _controller = CameraController(
        cameras.first,
        ResolutionPreset.high,
        enableAudio: false,
      );
      _initializeCamera = _controller.initialize();
    }
  }

  @override
  void dispose() {
    if (_isMobile && cameras.isNotEmpty) {
      _controller.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (!_isMobile || cameras.isEmpty) return;

    try {
      if (!_isRecording) {
        // START RECORDING
        await _controller.startVideoRecording();
        setState(() => _isRecording = true);
        debugPrint('Recording started');
      } else {
        // STOP RECORDING
        final XFile video = await _controller.stopVideoRecording();
        setState(() => _isRecording = false);

        debugPrint('Recorded video path: ${video.path}');

        // TEMPORARILY DELETE THE VIDEO AFTER RECORDING FOR TESTING PURPOSES
        final file = File(video.path);
        if (await file.exists()) {
          await file.delete();
          debugPrint('Video deleted');
        }
      }
    } catch (e) {
      debugPrint('Recording error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //recording is only available on mobile
    if (!_isMobile || cameras.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Throw')),
        body: const Center(
          child: Text(
            'Video recording is only available on mobile',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Record Throw')),
      body: FutureBuilder(
        future: _initializeCamera,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                CameraPreview(_controller),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: _toggleRecording,
                      child: Text(_isRecording ? 'Stop Recording' : 'Start Recording'),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
