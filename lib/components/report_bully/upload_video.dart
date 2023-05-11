import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:our_e_college_app/components/report_bully/uploader.dart';

class UploadVideo extends StatefulWidget {
  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {

  File file = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: pickFile, child: const Text("Pick File")),
            const SizedBox(height: 40),
            if (file != null) Text(file.path.split('/').last),
            const SizedBox(height: 40),
            ElevatedButton(
                onPressed: uploadFile, child: const Text("Upload File"))
          ],
        ),
      ),
    );
  }

  pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        file = File(result.files.single.path);
      });
    }
  }

  uploadFile() async {
    if(file != null){
      _prepareMediaUploadListener();
      String taskId = await BackgroundUploader.uploadEnqueue(file);
      print("TaskID ${taskId}");
      if (taskId != null) {
      } else {
        BackgroundUploader.uploader.cancelAll();
      }
    }
  }

  static void _prepareMediaUploadListener() {
    //listen
    BackgroundUploader.uploader.result.listen((UploadTaskResponse response) {
      BackgroundUploader.uploader.clearUploads();

      if (response.status == UploadTaskStatus.complete) {
      } else if (response.status == UploadTaskStatus.canceled) {
        BackgroundUploader.uploader.cancelAll();
      }
    }, onError: (error) {
      //handle failure
      BackgroundUploader.uploader.cancelAll();
    });
  }
}
