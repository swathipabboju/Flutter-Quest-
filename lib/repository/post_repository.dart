import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:TalkNest/model/post_data_response.dart';

class PostRepository {
  final String baseUrl = "https://jsonplaceholder.typicode.com/";

  Future<List<PostDataResponse>?> getPostDetails() async {
    var client = http.Client();
    List<PostDataResponse> postDataList = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List;
        postDataList = jsonResponse
            .map((post) => PostDataResponse.fromJson(post))
            .toList();
        return postDataList;
      } else {
        return [];
      }
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  Future<bool?> addPost() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": 'foo',
        "body": 'bar',
        "userId": "1",
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }
}
