import 'package:equatable/equatable.dart';
import 'package:youtub_flutter_project/data/models/post_create_model.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class CreatePostState extends Equatable {
  final PostStatus postStatus;
  final List<PostCreateModel> createPostList;
  final String? error;
  final bool? isEditing;

  const CreatePostState({
    this.postStatus = PostStatus.initial,
    this.createPostList = const [],
    this.error = "",
    this.isEditing = false,
  });

  CreatePostState copyWith({PostStatus? postStatus, List<
      PostCreateModel>? createPostList, String? error, bool? isEditing}) {
    return CreatePostState(
        postStatus: postStatus ?? this.postStatus,
        createPostList: createPostList ?? this.createPostList,
        error: error ?? this.error, isEditing: isEditing?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [postStatus, createPostList, error, isEditing];
}
