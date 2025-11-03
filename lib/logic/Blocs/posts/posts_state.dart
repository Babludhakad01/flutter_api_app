import 'package:equatable/equatable.dart';
import 'package:youtub_flutter_project/data/models/post_get_model.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class PostStates extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postlist;
  final List<PostModel> tempPostList;
  final String message;
  final String searchMessage;

  const PostStates({
    this.postStatus = PostStatus.loading,
    this.postlist = const [],
    this.tempPostList = const [],
    this.message = "",
    this.searchMessage = "",
  });

  PostStates copyWith({
    PostStatus? postStatus,
    List<PostModel>? postlist,
    List<PostModel>? tempPostList,
    String? message,
    String? searchMessage,
  }) {
    return PostStates(
      postStatus: postStatus ?? this.postStatus,
      postlist: postlist ?? this.postlist,
      tempPostList: tempPostList ?? this.tempPostList,
      message: message ?? this.message,
      searchMessage: searchMessage ?? this.searchMessage,
    );
  }

  @override
  List<Object?> get props => [postStatus, postlist, message, tempPostList, searchMessage];
}
