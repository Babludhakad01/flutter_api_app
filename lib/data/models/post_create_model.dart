class PostCreateModel {
  final int? id;
  final String? title;
  final String? userId;

  PostCreateModel({this.id
    ,this.userId, this.title});

  factory PostCreateModel.fromJson(Map<String, dynamic> json) {
    return PostCreateModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      userId: json['userId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, 'userId': userId};
  }
}
