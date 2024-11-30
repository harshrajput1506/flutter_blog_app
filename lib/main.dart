import 'package:blogography/data/data_source/firestore/blog_firestore.dart';
import 'package:blogography/data/repositories/blog_repository_impl.dart';
import 'package:blogography/domain/repositories/blog_repository.dart';
import 'package:blogography/presentation/bloc/blog_bloc.dart';
import 'package:blogography/presentation/screens/blog_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<BlogRepository>(
      create: (context) => BlogRepositoryImpl(blogFirestore: BlogFirestore()),
      child: BlocProvider<BlogBloc>(
        create: (context) => BlogBloc(blogRepository: RepositoryProvider.of<BlogRepository>(context)),
        child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: BlogListScreen()),
      ),
    );
  }
}
