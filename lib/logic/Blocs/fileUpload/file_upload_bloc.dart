import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtub_flutter_project/data/repositories/api_repository.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class FileUploadBloc extends Bloc<FileUploadEvent, FileUploadState> {
  ApiMethods apiMethods = ApiMethods();

  FileUploadBloc() : super(PickedInitialState()) {
    on<UploadImageEvent>(_onImageUpload);
    on<PickImageEvent>(_onPickImage);
  }

  void _onImageUpload(
    UploadImageEvent event,
    Emitter<FileUploadState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final imageUrl = await apiMethods.uploadFiles(event.file);
      emit(state.copyWith( status: Status.success,fileUrl: imageUrl));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _onPickImage(
    FileUploadEvent event,
    Emitter<FileUploadState> emit,
  ) async {
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    print("picked image.......... ${File(picked!.path)}");

    if (picked != null) {
      emit(PickedImageState(file: File(picked.path)));
    } else {
      emit(PickedErrorImageState("No image selected"));
    }
  }
}
