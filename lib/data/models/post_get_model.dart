class PostModel {
  final int? id;
  final String? userId;
  final int? postId;
  final String? name;
  final String? title;
  final String? email;
  final String? body;

  PostModel({this.id, this.userId, this.postId, this.name, this.title, this.email, this.body});

  // factory constructor dart object from json
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int?,
      userId: json['userId'] as String?,
      postId: json['postId'] as int?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      email: json['email'] as String?,
      body: json['body'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return ({
      'postId': postId,
      'id': id,
      'userId': userId,
      'name': name,
      'title': title,
      'email': email,
      'body': body,
    });
  }

  // Immutable Updates ke liye
  PostModel copyWith({
    final int? id,
    final int? postId,
    final String? userId,
    final String? name,
    final String? title,
    final String? email,
    final String? body,
  }) {
    return PostModel(
      id: this.id ?? id,
      userId: this.userId ?? userId,
      postId: this.postId ?? postId,
      name: this.name ?? name,
      title: this.title ?? title,
      email: this.email ?? email,
      body: this.body ?? body,
    );
  }
}
