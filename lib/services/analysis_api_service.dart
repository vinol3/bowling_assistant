import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import '../config/api_config.dart';
import '../models/bowling_throw.dart';

class AnalysisApiService {
  static final String _baseUrl = ApiConfig.baseUrl;
  static const _uuid = Uuid();

  //Mobile, Desktop
  static Future<BowlingThrow> analyzeVideoFile(File videoFile) async {
    final uri = Uri.parse('$_baseUrl/analyze');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
        ),
      );

    return _sendRequest(request);
  }

  //Web
  static Future<BowlingThrow> analyzeVideoBytes(
    Uint8List bytes,
    String filename,
  ) async {
    final uri = Uri.parse('$_baseUrl/analyze');

    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'video',
          bytes,
          filename: filename,
        ),
      );

    return _sendRequest(request);
  }

  //Shared logic
  static Future<BowlingThrow> _sendRequest(
    http.MultipartRequest request,
  ) async {
    final streamedResponse = await request.send();

    if (streamedResponse.statusCode != 200) {
      throw Exception(
        'Video analysis failed (status ${streamedResponse.statusCode})',
      );
    }

    final responseBody =
        await streamedResponse.stream.bytesToString();

    final Map<String, dynamic> data =
        jsonDecode(responseBody) as Map<String, dynamic>;

    final String id = _uuid.v4();
    return BowlingThrow.fromMap(id, data);
  }
}
