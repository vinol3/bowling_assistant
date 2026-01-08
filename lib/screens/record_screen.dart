import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../services/analysis_api_service.dart';
import '../services/throw_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  late CameraController _controller;
  late Future<void> _initializeCamera;

  bool _isRecording = false;
  bool _isAnalyzing = false;

  bool get _isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  void initState() {
    super.initState();

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
    if (!_isMobile || cameras.isEmpty || _isAnalyzing) return;

    try {
      if (!_isRecording) {
        await _controller.startVideoRecording();
        setState(() => _isRecording = true);
      } else {
        final XFile video = await _controller.stopVideoRecording();
        setState(() => _isRecording = false);

        final file = File(video.path);
        debugPrint('Recorded video path: ${file.path}');

        if (!await file.exists()) {
          throw Exception('Recorded video file not found');
        }

        setState(() => _isAnalyzing = true);

        final bowlingThrow =
            await AnalysisApiService.analyzeVideoFile(file);

        await ThrowService.saveThrow(bowlingThrow);

        await file.delete();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Throw analyzed successfully'),
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('Recording / analysis error: $e');
      debugPrintStack(stackTrace: stackTrace);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to analyze video'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isAnalyzing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isMobile || cameras.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Record Throw')),
        body: Center(
          child: Text(
            'Video recording is only available on mobile devices.',
            style: AppTextStyles.body,
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
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            children: [
              CameraPreview(_controller),

              // gradient overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ),

              // recording indicator
              Positioned(
                top: 16,
                left: 16,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: _isRecording ? 1 : 0,
                  child: Row(
                    children: const [
                      Icon(Icons.fiber_manual_record,
                          color: Colors.red, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'REC',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // analyzing overlay
              if (_isAnalyzing)
                Positioned.fill(
                  child: Container(
                    color: Colors.black54,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(color: Colors.white),
                          SizedBox(height: 12),
                          Text(
                            'Analyzing throw...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              // record button
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: _toggleRecording,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: _isRecording ? 72 : 84,
                      height: _isRecording ? 72 : 84,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isRecording
                            ? Colors.red
                            : AppColors.primary,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isRecording ? Icons.stop : Icons.videocam,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
