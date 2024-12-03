import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/post_model.dart';
import '../../data/services/api_service.dart';

class PostDetailCubit extends Cubit<Post?> {
  final ApiService apiService;

  PostDetailCubit(this.apiService) : super(null);

  void fetchPostDetail(int postId) async {
    try {
      final post = await apiService.fetchPostDetail(postId);
      emit(post);
    } catch (e) {
      emit(null);
    }
  }
}
