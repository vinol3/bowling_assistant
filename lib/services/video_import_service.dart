import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class VideoImportService {
  static Future<void> pickVideo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
    );

    if (result == null) return;

    if (kIsWeb) {
      debugPrint('Picked video (web): ${result.files.single.name}');
    } else {
      final path = result.files.single.path!;
      final file = File(path);
      debugPrint('Picked video path: $path');
      debugPrint('File size: ${await file.length()} bytes');
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Video selected successfully')),
    );

    // TODO: forward path/bytes to analysis pipeline
  }
}
