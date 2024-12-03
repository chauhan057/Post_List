import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/post_model.dart';
import '../../data/services/api_service.dart';
import 'posts_event.dart';
import 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService apiService;

  PostsBloc(this.apiService) : super(PostsInitial()) {
    on<FetchPosts>((event, emit) async {
      emit(PostsLoading());
      try {
        final posts = await apiService.fetchPosts();
        final postsWithTimers = posts.map((post) {
          return post.copyWith(timerDuration: 10 + (new DateTime.now().millisecondsSinceEpoch % 15) % 10);
        }).toList();
        emit(PostsLoaded(posts: postsWithTimers));
      } catch (e) {
        emit(PostsError(message: e.toString()));
      }
    });

    on<MarkPostAsRead>((event, emit) async {
      if (state is PostsLoaded) {
        final posts = (state as PostsLoaded).posts;
        final postIndex = posts.indexWhere((post) => post.id == event.postId);
        if (postIndex != -1) {
          final updatedPost = posts[postIndex].copyWith(read: true);
          final updatedPosts = List<Post>.from(posts);
          updatedPosts[postIndex] = updatedPost;

          emit(PostsLoaded(posts: updatedPosts));
        }
      }
    });
  }
}
