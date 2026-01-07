import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/analysis_api_service.dart';
import '../services/throw_service.dart';

class VideoImportService {
  static Future<void> pickVideo(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      allowMultiple: false,
      withData: kIsWeb,
    );

    if (result == null) return;

    try {
      late final bowlingThrow;

      if (kIsWeb) {
        final bytes = result.files.single.bytes!;
        final filename = result.files.single.name;

        bowlingThrow =
            await AnalysisApiService.analyzeVideoBytes(
          bytes,
          filename,
        );
      } else {
        final path = result.files.single.path!;
        final file = File(path);

        bowlingThrow =
            await AnalysisApiService.analyzeVideoFile(file);
      }

      await ThrowService.saveThrow(bowlingThrow);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video analyzed successfully'),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Video analysis failed: $e');
      debugPrintStack(stackTrace: stackTrace);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video analysis failed'),
        ),
      );
    }
  }
}
