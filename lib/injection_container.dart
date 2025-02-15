import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:posts_app_with_clean_architecture/core/network/network_info.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data%20sources/local_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/data%20sources/remote_data_source.dart';
import 'package:posts_app_with_clean_architecture/features/posts/data/repositories/post_repository_impl.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/repositories/posts_repository.dart';
import 'package:posts_app_with_clean_architecture/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Bloc

  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));

// UseCases

  sl.registerLazySingleton(() => GetAllPostsUsecase(repository: sl()));

// Repository

  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

// DataSources

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

// Core

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

// External

  final sharedPrefrences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPrefrences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}
