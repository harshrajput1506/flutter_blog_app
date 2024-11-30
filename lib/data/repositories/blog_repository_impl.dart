import 'package:blogography/data/data_source/firestore/blog_firestore.dart';
import 'package:blogography/domain/models/blog_model.dart';
import 'package:blogography/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl extends BlogRepository{
  final BlogFirestore blogFirestore;

  BlogRepositoryImpl({
    required this.blogFirestore
  });

  @override
  Future<List<BlogModel>> getBlogs() async {
    try{
      final dataList = await blogFirestore.fetchBlogs();
      final blogs = dataList.map((docSnap) => BlogModel.fromFirestore(docSnap.data())).toList();
      return blogs;
    } catch (e){
      throw Exception("failed to get data from firestore, error : ${e.toString()}");
    }
  }
  
}