import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/errors/failure.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
}
