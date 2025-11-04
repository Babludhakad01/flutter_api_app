import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class FileUploadEvent extends Equatable{
  const FileUploadEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];


}

class UploadImageEvent extends FileUploadEvent{
  final File? file;
  const UploadImageEvent(this.file);
  @override
  List<Object?> get props => [file];
}
class PickImageEvent extends FileUploadEvent{

  @override
  List<Object?> get props => [];
}

