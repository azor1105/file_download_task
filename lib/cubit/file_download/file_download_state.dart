part of 'file_download_cubit.dart';

class FileDownloadState extends Equatable {
  const FileDownloadState({
    required this.progress,
  });

  final StreamController<double> progress;

  FileDownloadState copyWith({StreamController<double>? progress}) =>
      FileDownloadState(
        progress: progress ?? this.progress,
      );

  @override
  List<Object> get props => [progress];
}
