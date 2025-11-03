import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtub_flutter_project/core/constants/post_apis/post_api_url.dart';

class ApiClient {
  // GET API FOR Fetch post
  Future<dynamic> get(String endPoints) async {
    final response = await http.get(
      Uri.parse("${PostApi.postbaseUrl}${endPoints}"),
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'Mozilla/5.0 (Flutter App)',
      },
    );
    // print("api get $response");
    return _onHandleResponse(response);
  }

  //Post API for Create Post
  Future<dynamic> post(String endPoints, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse("${PostApi.postbaseUrl}$endPoints"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _onHandleResponse(res);
  }

  // Put API For Entire Object update
  Future<dynamic> put(String endPoints, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse("${PostApi.postbaseUrl}$endPoints"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _onHandleResponse(res);
  }

  dynamic _onHandleResponse(http.Response response) {
    // print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception('HTTP Error ${response.statusCode} - ${response.body}');
    }
  }
}
