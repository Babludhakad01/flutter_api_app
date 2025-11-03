import 'package:bloc/bloc.dart';
import 'package:youtub_flutter_project/data/models/post_get_model.dart';
import 'package:youtub_flutter_project/data/repositories/post_repository.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class PostBloc extends Bloc<PostEvent, PostStates> {
  List<PostModel> tempPostList = [];
  PostRepository postRepository = PostRepository();

  PostBloc() : super(const PostStates()) {
    on<PostFetched>(_onFetchPost);
    on<SearchItem>(_onSearchItem);
  }

  // Fetch Post
  void _onFetchPost(PostFetched event, Emitter<PostStates> emit) async {
    await postRepository
        .fetchPost()
        .then((value) {
          emit(
            state.copyWith(
              postStatus: PostStatus.success,
              message: "Success",
              postlist: value,
            ),
          );
        })
        .onError((error, StackTrace) {
          emit(
            state.copyWith(
              postStatus: PostStatus.failure,
              message: error.toString(),
            ),
          );
        });
  }

  // Search Item
  void _onSearchItem(SearchItem event, Emitter<PostStates> emit) async {
    if (event.search.isEmpty) {
      emit(state.copyWith(tempPostList: [], searchMessage: ""));
    } else {
      tempPostList = state.postlist
          .where(
        // element.name == event.search.toString()).toList();
            (element) => element.name.toString().toLowerCase().contains(
              event.search.toLowerCase(),
            ),

          )
          .toList();
      if (tempPostList.isEmpty) {
        emit(
          state.copyWith(
            tempPostList: tempPostList,
            searchMessage: "no data found",
          ),
        );
      } else {
        emit(state.copyWith(tempPostList: tempPostList, searchMessage: ''));
      }
    }
  }
}
