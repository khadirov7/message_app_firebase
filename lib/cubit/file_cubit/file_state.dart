
import 'package:equatable/equatable.dart';

class FileManagerState extends Equatable {
  final double progress;
  final String newFileLocation;

  const FileManagerState({
    required this.progress,
    required this.newFileLocation,
  });

  FileManagerState copyWith({
    double? progress,
    String? newFileLocation,
  }) {
    return FileManagerState(
      progress: progress ?? this.progress,
      newFileLocation: newFileLocation ?? this.newFileLocation,
    );
  }

  @override
  List<Object?> get props => [progress, newFileLocation];
}
