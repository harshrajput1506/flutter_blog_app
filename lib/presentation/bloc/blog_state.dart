import 'package:blogography/domain/models/blog_model.dart';

abstract class BlogState {}

class BlogsInitialize extends BlogState {}

class BlogsLoading extends BlogState {}
class BlogsLoaded extends BlogState {
  final List<BlogModel> blogs;
  BlogsLoaded({
    required this.blogs
  });
}

class BlogsFailed extends BlogState {
  final String message;
  BlogsFailed({
    required this.message
  });
}

class BlogHighlight extends BlogState {
  final int highlightIndex;
  BlogHighlight({required this.highlightIndex});
}

class RevokeHighlightPost extends BlogState {}


