import 'package:dartz/dartz.dart';
import 'package:posts_app_with_clean_architecture/core/errors/exceptions.dart';
import 'package:posts_app_with_clean_architecture/core/errors/failure.dart';
import 'package:posts_app_with_clean_architecture/core/network/network_info.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data%20sources/local_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data%20sources/remote_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/entities/post.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repositories/posts_repository.dart';

class PostRepositoryImpl implements PostsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      //user is connected to internet
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}
