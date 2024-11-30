class BlogModel {
  String? title;
  String? summary;
  String? thumbnail;
  String? content;
  String? deepLink;

  BlogModel({
    required this.title,
    required this.content,
    required this.deepLink,
    required this.summary,
    required this.thumbnail
  });

  factory BlogModel.fromFirestore(Map<String, dynamic> snapshot){
    return BlogModel(title: snapshot['title'], content: snapshot['content'], deepLink: snapshot['deeplink'], summary: snapshot['summary'], thumbnail: snapshot['thumbnail']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (thumbnail != null) "thumbnail": thumbnail,
      if (summary != null) "summary": summary,
      if (content != null) "content":  content,
      if (deepLink != null) "deeplink": deepLink,
    };
  }
}