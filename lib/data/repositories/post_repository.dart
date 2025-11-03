import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtub_flutter_project/data/models/post_create_model.dart';
import 'package:youtub_flutter_project/data/models/post_get_model.dart';
import 'package:youtub_flutter_project/data/network/api_client.dart';

class PostRepository {
  ApiClient apiClient = ApiClient();

  // Get API
  Future<List<PostModel>> fetchPost() async {
    try {
      final res = await apiClient.get("/comments");

      // final response = await http.get(
      //   Uri.parse(PostApi.fetchPost),
      // );

      // if (response.statusCode == 200) {
      //   final body = jsonDecode(response.body) as List;
      return (res as List).map((e) => PostModel.fromJson(e)).toList();
      //   return PostModel(
      //     postId: e['postId'] as int,
      //
      //      name: e['name'] as String,
      //     email: e['email'] as String,
      //     // body: e['body'] as String,
      //   );
      // }).toList();
      // } else {
      //   throw Exception("While Fetching data from API error..");
      // }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PostCreateModel> createPost(String title, String userId) async {
    try {

      final res = await apiClient.post("/posts", {'title': title, 'userId': userId});
      return PostCreateModel.fromJson(res);
      /*
      final res = await http.post(
        Uri.parse("https://dummyjson.com/posts/add"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'userId': userId}),
      );
      if (res.statusCode == 200 || res.statusCode == 201) {
        final data = jsonDecode(res.body);
        return PostCreateModel.fromJson(data);
      } else {
        throw Exception("Failed to create post");
      }

       */
    } catch (e) {
      throw Exception("create post api error");
    }
  }

  Future<PostCreateModel> updatePost(String title, String userId, String id) async{
    try{
      final res = await apiClient.put("/posts/$id", {'title': title, 'userId': userId});
      return PostCreateModel.fromJson(res);
    }catch(e){
      throw Exception("Update API Error");
    }

  }
}
