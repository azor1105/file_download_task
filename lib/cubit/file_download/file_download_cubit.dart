import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
part 'file_download_state.dart';

class FileDownloadCubit extends Cubit<FileDownloadState> {
  FileDownloadCubit({required Dio dio})
      : _dio = dio,
        super(FileDownloadState(progress: StreamController()));

  final Dio _dio;

  Future<void> downloadFile({
    required String fileName,
    required String url,
  }) async {
    bool isGranted = await requestPermissionStorage();
    if (!isGranted) return;
    var directory = await getDownloadPath();
    String fileLocation =
        '${directory?.path}/$fileName.${getFileType(url: url)}';
    var filesOnDownloads = directory?.list();
    List<String> filePaths = [];
    await filesOnDownloads?.forEach((element) {
      print("FILES IN DOWNLOAD FOLDER:${element.path}");
      filePaths.add(element.path.toString());
    });

    if (filePaths.contains(fileLocation)) {
      OpenFile.open(fileLocation);
    } else {
      try {
        await _dio.download(url, fileLocation,
            onReceiveProgress: (received, total) {
          double precent = received / total;
          state.progress.sink.add(precent);
          emit(state.copyWith(
            progress: state.progress,
          ));
        });
        OpenFile.open(
          fileLocation,
        );
      } catch (error) {
        debugPrint("DOWNLOAD ERROR:$error");
      }
    }
  }

  Future<bool> requestPermissionStorage() async {
    await Permission.storage.request();
    return Permission.storage.isGranted;
  }

  Future<Directory?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      debugPrint("Cannot get download folder path");
    }
    return directory;
  }

  String getFileType({required String url}) {
    if (url.contains('.jpg')) {
      return 'jpg';
    } else if (url.contains('.png')) {
      return 'png';
    } else if (url.contains('.mp3')) {
      return 'mp3';
    } else if (url.contains('.mp4')) {
      return 'mp4';
    } else if (url.contains('.pdf')) {
      return 'pdf';
    }
    return '';
  }
}
