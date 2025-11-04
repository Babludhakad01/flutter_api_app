import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiClient {
  // GET API FOR Fetch post
  Future<dynamic> get(String endPoints) async {
    final response = await http.get(
      Uri.parse(endPoints),
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
      Uri.parse(endPoints),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return _onHandleResponse(res);
  }

  // Put API For Entire Object update
  Future<dynamic> put(String endPoints, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse(endPoints),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    return _onHandleResponse(res);
  }

  //? MultiPart API For File Upload
  Future<dynamic> multiPartRequest({required String url, File? singleFile,}) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add single file
      if (singleFile != null) {
        var file = await http.MultipartFile.fromPath('file', singleFile.path);
        request.files.add(file);
      } else {
        throw Exception("No file provided for upload");
      }

      //  Send Request
      var streamedResponse = await request.send();

      //  Convert streamedResponse to normal Response
      var res = await http.Response.fromStream(streamedResponse);

      //  Handle response
      return _onHandleResponse(res);
    } catch (e) {
      throw Exception("Error in multipart upload: ${e.toString()}");
    }
  }

  dynamic _onHandleResponse(http.Response response) {
    // print(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 400) {
      throw Exception('Bad request ${response.statusCode} - ${response.body}');
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: please login again");
    } else if (response.statusCode == 404) {
      throw Exception('Not Found: ${response.request?.url} - ${response.body}');
    } else if (response.statusCode == 500) {
      throw Exception("Server Error: ${response.body}");
    } else {
      throw Exception("Something went wrong: $response.body");
    }
  }
}
