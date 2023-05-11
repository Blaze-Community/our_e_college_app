import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_uploader/flutter_uploader.dart';

class BackgroundUploader {
  BackgroundUploader._();

  static final uploader = FlutterUploader();

  static Future<String> uploadEnqueue(File file) async {
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "accessToken");
    print(accessToken);
    final String taskId = await uploader.enqueue(
      MultipartFormDataUpload(
        url: 'https://college-app-backend-production.up.railway.app/api/bully/upload',
        method: UploadMethod.PUT,
        headers: {"Authorization": "Bearer $accessToken","Content-Type": "multipart/form-data"},
        files: [FileItem(path: file.path, field: "file")],
        tag: "Media Uploading",
      ),
    );

    return taskId;
  }
}