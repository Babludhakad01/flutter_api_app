import 'package:bloc/bloc.dart';
import 'package:youtub_flutter_project/data/models/post_create_model.dart';
import 'package:youtub_flutter_project/data/repositories/post_repository.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  PostRepository postRepository = PostRepository();

  CreatePostBloc() : super(const CreatePostState()) {
    on<PostCreated>(_onCreatePost);
    on<UpdatePostEvent>(_onUpdatePost);
    on<SelectEditPostEvent>(_onEditPost);
    on<DeletePostEvent>(_onDeletePost);
  }

  void _onCreatePost(PostCreated event, Emitter<CreatePostState> emit) async {
    emit(state.copyWith(postStatus: PostStatus.initial));

    try {
      emit(state.copyWith(postStatus: PostStatus.loading));
      final newPost = await postRepository.createPost(
        event.title,
        event.userId,
      );
      final localId = state.createPostList.length + 1;

      final updatedPost = PostCreateModel(
        id: localId,
        title: newPost.title,
        userId: newPost.userId,
      );

      final updatedList = List<PostCreateModel>.from(state.createPostList)
        ..insert(0, updatedPost);
      emit(
        state.copyWith(
          postStatus: PostStatus.success,
          createPostList: updatedList,
        ),
      );
    } catch (e) {
      emit(state.copyWith(postStatus: PostStatus.failure, error: e.toString()));
    }
  }

  void _onUpdatePost(UpdatePostEvent event, Emitter<CreatePostState> emit) async {
    try {
      final updatedPostList = state.createPostList.map((post) {
        if (post.id.toString() == event.id.toString()) {
          return PostCreateModel(
            id: post.id,
            title: event.title,
            userId: event.userId,
          );
        } else {
          return post;
        }
      }).toList();

      emit(state.copyWith(createPostList: updatedPostList, postStatus: PostStatus.success, isEditing: false));
    } catch (e) {
      emit(state.copyWith(postStatus: PostStatus.failure, error: e.toString()));
    }
  }

  void _onEditPost(SelectEditPostEvent event, Emitter<CreatePostState> emit){
    emit(state.copyWith(isEditing: true, postStatus: PostStatus.success ));
  }

  void _onDeletePost(DeletePostEvent event, Emitter<CreatePostState> emit){
    final updatedList = state.createPostList.where((post)=> post.id.toString() != event.id.toString()).toList();

    emit(state.copyWith(createPostList: updatedList,postStatus: PostStatus.success));
  }
}
