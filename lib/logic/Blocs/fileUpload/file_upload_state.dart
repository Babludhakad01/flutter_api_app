import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class FileUploadState extends Equatable {
  final Status status;
  final String? fileUrl;
  final String? error;

  const FileUploadState({
    this.status = Status.initial,
    this.fileUrl="",
    this.error = "",
  });

  FileUploadState copyWith({Status? status, String? fileUrl, String? error}) {
    return FileUploadState(
      status: status ?? this.status,
      fileUrl: fileUrl ?? this.fileUrl,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, fileUrl, error];
}

class PickedImageState extends FileUploadState {
  final File? file;

  const PickedImageState({this.file});

  List<Object?> get props => [file];
}

class PickedErrorImageState extends FileUploadState {
  final String error;

  const PickedErrorImageState(this.error);

  List<Object?> get props => [error];
}
class PickedInitialState extends FileUploadState {}