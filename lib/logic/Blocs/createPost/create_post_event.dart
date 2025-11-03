import 'package:equatable/equatable.dart';
import 'package:youtub_flutter_project/data/models/post_create_model.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

abstract class CreatePostEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class PostCreated extends CreatePostEvent{
  final String title;
  final String userId;

  PostCreated({required this.title, required this.userId});



  @override

  List<Object?> get props => [title,userId];
}

class UpdatePostEvent extends CreatePostEvent{
  final String title;
   final String userId;
  final String id;

  UpdatePostEvent({required this.title, required this.userId, required this.id});

  @override
  // TODO: implement props
  List<Object?> get props => [title,userId, id];
}

class SelectEditPostEvent extends CreatePostEvent{
  final PostCreateModel post;
  SelectEditPostEvent(this.post);
  @override

  List<Object?> get props => [post];
}


class DeletePostEvent extends CreatePostEvent{
  final String id;
  DeletePostEvent(this.id);
}