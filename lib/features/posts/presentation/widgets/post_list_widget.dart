import 'package:flutter/material.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(
            posts[index].id.toString(),
          ),
          title: Text(
            posts[index].title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            posts[index].body,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
        );
      },
      separatorBuilder: (context, index) => Divider(thickness: 1),
      itemCount: posts.length,
    );
  }
}
