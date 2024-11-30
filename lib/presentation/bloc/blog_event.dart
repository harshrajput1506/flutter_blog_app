abstract class BlogEvent {}

class FetchBlogsEvent extends BlogEvent {}

class HighlightBlogEvent extends BlogEvent {
  String deeplink;
  HighlightBlogEvent({
    required this.deeplink
  });
}
 class RevokeHighlightPostEvent extends BlogEvent{}