import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/errors/failure.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase({required this.repository});

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
