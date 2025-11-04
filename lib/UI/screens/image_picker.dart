import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  //  Function to pick image from gallery

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
        actions: [
          IconButton(
            onPressed: () => {
              context.read<FileUploadBloc>().add(PickImageEvent()),
            },
            icon: const Icon(Icons.photo),
          ),
        ],
      ),
      body: BlocBuilder<FileUploadBloc, FileUploadState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is PickedImageState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(state.file!, height: 100, width: 100),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      context.read<FileUploadBloc>().add(
                        UploadImageEvent(state.file),
                      );
                    },
                    child: Text("upload"),
                  ),
                ],
              ),
            );
          }
          else if (state.status == Status.success) {
//print("${state.fileUrl!}...................");
           return Center(
             child: Image.network(
                '${state.fileUrl}',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Text("Failed to load image");
                },
              ),
           );
          }
          return const Center(child: Text("Pick an Image to Upload"));
        },
      ),
    );
  }
}
