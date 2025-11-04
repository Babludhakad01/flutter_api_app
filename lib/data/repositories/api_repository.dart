import 'dart:io';

import 'package:youtub_flutter_project/core/constants/api_urls/apis_urls.dart';
import 'package:youtub_flutter_project/data/models/post_create_model.dart';
import 'package:youtub_flutter_project/data/models/post_get_model.dart';
import 'package:youtub_flutter_project/data/models/user_model.dart';
import 'package:youtub_flutter_project/data/network/api_client.dart';

class ApiMethods {
  ApiClient apiClient = ApiClient();

  // Get API
  Future<List<PostModel>> fetchPost() async {
    try {
      final res = await apiClient.get(ApiUrls.endPointsOfComments);
      return (res as List).map((e) => PostModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PostCreateModel> createPost(String title, String userId) async {
    try {
      final res = await apiClient.post(ApiUrls.endPointsOfPosts, {
        'title': title,
        'userId': userId,
      });
      return PostCreateModel.fromJson(res);
    } catch (e) {
      throw Exception("create post api error");
    }
  }

  Future<PostCreateModel> updatePost(
    String title,
    String userId,
    String id,
  ) async {
    try {
      final res = await apiClient.put("${ApiUrls.endPointsOfPosts}/$id", {
        'title': title,
        'userId': userId,
      });
      return PostCreateModel.fromJson(res);
    } catch (e) {
      throw Exception("Update API Error");
    }
  }

  Future<UserModel> loginDetails(String email, String password) async {
    try {
      final res = await apiClient.post(ApiUrls.endPointsLogin, {
        "email": email,
        'password': password,
      });
      final userdata = res['user'] ?? res;
      final user = UserModel.fromJson(userdata);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> uploadFiles(File? file) async {
    try {

      final res = await apiClient.multiPartRequest(
        url: ApiUrls.endPointsOfFile,
        singleFile: file,
      );

      print("API Response for File Upload: $res");

      if (res != null && res['location'] != null) {
        return res['location']; // uploaded image ka URL
      } else {
        throw Exception(
          "Upload successful but 'location' not found in response",
        );
      }
    } catch (e) {
      throw Exception("Error in uploading file: ${e.toString()}");
    }
  }
}
