import 'package:blogography/domain/models/blog_model.dart';

abstract class BlogRepository {
  Future<List<BlogModel>> getBlogs();
}