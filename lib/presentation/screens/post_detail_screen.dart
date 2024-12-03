import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/post_model.dart';
import '../../data/services/api_service.dart';
import '../bloc/post_details_bloc.dart';


class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Details')),
      body: BlocProvider(
        create: (context) => PostDetailCubit(ApiService())..fetchPostDetail(postId),
        child: BlocBuilder<PostDetailCubit, Post?>(
          builder: (context, post) {
            if (post == null) {
              return Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title, style: Theme.of(context).textTheme.headline5),
                  SizedBox(height: 16),
                  Text(post.body),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
