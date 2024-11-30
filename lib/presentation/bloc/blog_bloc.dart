import 'dart:async';

import 'package:blogography/domain/models/blog_model.dart';
import 'package:blogography/domain/repositories/blog_repository.dart';
import 'package:blogography/presentation/bloc/blog_event.dart';
import 'package:blogography/presentation/bloc/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {

  final BlogRepository blogRepository;
  List<BlogModel> blogs = [];

  BlogBloc({required this.blogRepository}) : super(BlogsInitialize()){
    on<FetchBlogsEvent>(_onFetchBlogsEvent);
    on<HighlightBlogEvent>(_onHighlightBlogEvent);
    on<RevokeHighlightPostEvent>(_onRevokeHighlightPostEvent);
  }

  Future<void> _onFetchBlogsEvent(FetchBlogsEvent event, Emitter<BlogState> emit) async {
    try {
      emit(BlogsLoading());
      final blogs = await blogRepository.getBlogs();
      this.blogs = blogs;
      emit(BlogsLoaded(blogs: blogs));
    } catch (e) {
      emit(BlogsFailed(message: "Failed to fetch blogs, error : ${e.toString()}"));
    }
  }

  void _onHighlightBlogEvent(HighlightBlogEvent event, Emitter<BlogState> emit) {
    if(blogs.isNotEmpty){
      int highlightIndex = blogs.indexWhere((blog) => blog.deepLink == event.deeplink);
      emit(BlogHighlight(highlightIndex: highlightIndex));
    }
  }

  void _onRevokeHighlightPostEvent(RevokeHighlightPostEvent event, Emitter<BlogState> emit) {

    emit(RevokeHighlightPost());
  }
}