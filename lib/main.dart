import 'package:flutter/material.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:posts_app_with_clean_architecture/features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Posts App',
        home: PostsPage(),
      ),
    );
  }
}
