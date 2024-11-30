import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:blogography/core/theme/colors.dart';
import 'package:blogography/domain/models/blog_model.dart';
import 'package:blogography/presentation/bloc/blog_bloc.dart';
import 'package:blogography/presentation/bloc/blog_event.dart';
import 'package:blogography/presentation/bloc/blog_state.dart';
import 'package:blogography/presentation/screens/blog_screen.dart';
import 'package:blogography/presentation/widgets/blog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogListScreen extends StatefulWidget {
  const BlogListScreen({super.key});

  @override
  State<BlogListScreen> createState() => _BlogListScreenState();
}

class _BlogListScreenState extends State<BlogListScreen> {
  final appLinks = AppLinks();
  late StreamSubscription<Uri> _subscription;
  bool isBlogsLoaded = false;
  String? deeplink;
  int highlightIndex = -1;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _initDeeplinkListener();
    BlocProvider.of<BlogBloc>(context).add(FetchBlogsEvent());
    super.initState();
  }

  void _onReadMore(BlogModel blog) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => BlogScreen(blog: blog)));
  }

  void _initDeeplinkListener() {
    _subscription = appLinks.uriLinkStream.listen((uri) {
      // Do something (navigation, ...)
      if (uri.pathSegments.contains('blogs')) {
        if (isBlogsLoaded) {
          BlocProvider.of<BlogBloc>(context)
              .add(HighlightBlogEvent(deeplink: uri.toString()));
        } else {
          deeplink = uri.toString();
        }
      }
    });
  }

  void _checkDeeplink() {
    if (deeplink != null) {
      BlocProvider.of<BlogBloc>(context)
          .add(HighlightBlogEvent(deeplink: deeplink!));
      deeplink = null;
    }
  }

  void _scrollToPost(int index) {
    // Scroll to the highlighted post
    if (index >= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          index * 132.0, // Adjust item height
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientColor1, gradientColor2, gradientColor3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/globe.svg',
                      height: 40,
                      width: 40,
                    ),
                    Text(
                      'Blogography',
                      style: GoogleFonts.tinos(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Expanded(
                child: BlocConsumer<BlogBloc, BlogState>(
                    listener: (context, state) {
              if (state is BlogHighlight) {
                _scrollToPost(state.highlightIndex);
                setState(() {
                  highlightIndex = state.highlightIndex;
                });
              } else if (state is RevokeHighlightPost) {
                highlightIndex = -1;
              }
            }, buildWhen: (previous, current) {
              if (current is BlogHighlight) {
                return false;
              } else if (current is RevokeHighlightPost) {
                return false;
              }
              return true;
            }, builder: (context, state) {
              if (state is BlogsLoaded) {
                isBlogsLoaded = true;
                _checkDeeplink();
                return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    controller: _scrollController,
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) {
                      return BlogWidget(
                          blog: state.blogs[index],
                          highlight: (index == highlightIndex),
                          onReadMore: () => _onReadMore(state.blogs[index]));
                    });
              } else if (state is BlogsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is BlogsFailed) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text("No Blogs Yet!"),
                );
              }
            }))
          ],
        )),
      ),
    );
  }
}
