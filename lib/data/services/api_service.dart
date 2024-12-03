import 'dart:convert';
import 'dart:io';  // Import for SocketException
import 'package:http/http.dart' as http;
import '../model/post_model.dart';

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load posts');
      }
    } on SocketException {
      // Catch SocketException for no network or server unavailable
      throw Exception('No Internet connection or server unavailable.');
    } on http.ClientException {
      // Catch ClientException for other HTTP client-related errors
      throw Exception('Failed to load posts. Please try again later.');
    } catch (e) {
      // Catch other unknown errors
      throw Exception('An error occurred: $e');
    }
  }

  Future<Post> fetchPostDetail(int postId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts/$postId'));

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load post details');
      }
    } on SocketException {
      throw Exception('No Internet connection or server unavailable.');
    } on http.ClientException {
      throw Exception('Failed to load post details. Please try again later.');
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }
}
