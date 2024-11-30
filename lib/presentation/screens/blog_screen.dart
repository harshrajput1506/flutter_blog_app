import 'package:blogography/core/theme/colors.dart';
import 'package:blogography/domain/models/blog_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogScreen extends StatefulWidget {
  final BlogModel blog;
  const BlogScreen({required this.blog, super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  void _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;

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
            child: SingleChildScrollView(
              child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: GestureDetector(
                    onTap: () => _onBack(),
                    child: SvgPicture.asset(
                      'assets/images/back.svg',
                      height: 30.0,
                      width: 30.0,
                    ),
                  ),
                ),
                ClipRect(
                  child: CachedNetworkImage(
                    imageUrl: blog.thumbnail ?? "",
                    width: double.maxFinite,
                    height: 180.0,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Container(
                        width: double.maxFinite,
                        height: 180.0,
                        color: Colors.grey.shade300,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => Container(
                      height: 180,
                      width: double.maxFinite,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.broken_image,
                        color: Colors.grey,
                        size: 50.0,
                      ),
                    ),
                  ),
                ),
              
                const SizedBox(height: 12.0,),
              
                Text(
                    blog.title ?? "No Title",
                    style: GoogleFonts.tinos(
                        fontSize: 24.0, fontWeight: FontWeight.bold, height: 1.2),
                  ),
              
                  const SizedBox(height: 8.0,),
              
                  Text(
                    blog.summary ?? "",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 14.0,
                    ),
                  ),
              
                  const SizedBox(height: 8.0,),
              
                  const Divider(color: Colors.black12,),
              
                  const SizedBox(height: 8.0,),
              
                  Text(
                    blog.content ?? "",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 16.0,
                    ),
                  ),

                  const SizedBox(height: 16.0,),
              
              ],
                        ),
                      ),
            )),
      ),
    );
  }
}
