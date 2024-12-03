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
      appBar: AppBar(
        title: Text('Post Detail',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
        elevation: 0,
        backgroundColor: Colors.blueAccent,

      ),
      body: BlocProvider(
        create: (context) => PostDetailCubit(ApiService())..fetchPostDetail(postId),
        child: BlocBuilder<PostDetailCubit, Post?>(
          builder: (context, post) {
            if (post == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 16),

                    // Body text
                    Text(
                      post.body,
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                    ),


                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
