import 'dart:convert';

import 'package:posts_app_with_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
}

const baseURL = 'https://jsonplaceholder.typicode.com/';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse('$baseURL/posts/'),
    );

    if (response.statusCode == 200) {
      //success
      final List decodedJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodedJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }
}
