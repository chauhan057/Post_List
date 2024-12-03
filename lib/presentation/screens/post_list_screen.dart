import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:task1_knovator/presentation/screens/post_detail_screen.dart';

import '../../data/services/api_service.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/posts_event.dart';
import '../bloc/posts_state.dart';

class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),      body: BlocProvider(
        create: (context) => PostsBloc(ApiService())..add(FetchPosts()),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostsLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];

                  return VisibilityDetector(
                    key: Key(post.id.toString()),
                    onVisibilityChanged: (visibilityInfo) {
                      final visiblePercentage =
                          visibilityInfo.visibleFraction * 100;
                      if (visiblePercentage > 50) {
                        post.timerController.start();
                      } else {
                        post.timerController.pause();
                      }
                    },
                    child: Card(
                      color: post.read ? Colors.white : Colors.yellow[100],
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.grey[300]!, width: 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                                maxLines: 1,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.timer, color: Colors.blue, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        '${post.timerDuration - post.timerController.elapsedTime}s',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ),

                                      ),
                                    ],
                                  ),
                                  if (!post.read)
                                    Icon(
                                      Icons.notifications_active,
                                      color: Colors.orange,
                                      size: 24,
                                    ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            context.read<PostsBloc>().add(MarkPostAsRead(post.id));
                            post.timerController.pause();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostDetailScreen(postId: post.id),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is PostsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
