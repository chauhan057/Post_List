// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../model/post_model.dart';
//
// class LocalStorageService {
//   static const String postsKey = 'posts';
//
//   // Load posts from local storage
//   Future<List<Post>> loadPosts() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? postsJson = prefs.getString(postsKey);
//     if (postsJson != null) {
//       final List<dynamic> decodedJson = json.decode(postsJson);
//       return decodedJson.map((e) => Post.fromJson(e)).toList();
//     }
//     return [];
//   }
//
//   // Save posts to local storage
//   Future<void> savePosts(List<Post> posts) async {
//     final prefs = await SharedPreferences.getInstance();
//     final postsJson = json.encode(posts.map((e) => e.toJson()).toList());
//     prefs.setString(postsKey, postsJson);
//   }
// }
