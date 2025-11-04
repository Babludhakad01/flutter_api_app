import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtub_flutter_project/UI/screens/image_picker.dart';
import 'package:youtub_flutter_project/core/navigation/navigation_service.dart';
import 'package:youtub_flutter_project/logic/Blocs/Auth/auth_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/fileUpload/file_upload_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_bloc.dart';
import 'package:youtub_flutter_project/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => CreatePostBloc()),
        BlocProvider(create: (_) => FileUploadBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
          home: ImagePickerScreen(),
      ),
    );
  }
}
