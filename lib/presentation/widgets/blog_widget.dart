import 'package:blogography/domain/models/blog_model.dart';
import 'package:blogography/presentation/bloc/blog_bloc.dart';
import 'package:blogography/presentation/bloc/blog_event.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogWidget extends StatefulWidget {
  final BlogModel blog;
  final void Function() onReadMore;
  final bool highlight;

  const BlogWidget(
      {required this.blog,
      required this.onReadMore,
      required this.highlight,
      super.key});

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {

  @override
  void initState() {
    if(widget.highlight){
      BlocProvider.of<BlogBloc>(context).add(RevokeHighlightPostEvent());
    }
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            color: widget.highlight ? Colors.black12 : Colors.transparent,
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRect(
                child: CachedNetworkImage(
                  imageUrl: widget.blog.thumbnail ?? "",
                  width: 160.0,
                  height: 120.0,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    return Container(
                      width: 160.0,
                      height: 120.0,
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Container(
                    height: 120.0,
                    width: 160.0,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.blog.title ?? "No Title",
                      style: GoogleFonts.tinos(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          height: 1.2),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.blog.summary ?? "",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 12.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: widget.onReadMore,
                      child: Text(
                        "Read More",
                        style: GoogleFonts.nunitoSans(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        
      ],
    );
  }
}
