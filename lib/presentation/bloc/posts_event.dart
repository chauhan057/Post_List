import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPosts extends PostsEvent {}

class MarkPostAsRead extends PostsEvent {
  final int postId;

  MarkPostAsRead(this.postId);

  @override
  List<Object> get props => [postId];
}