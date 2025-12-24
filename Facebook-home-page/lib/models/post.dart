class Post {
  final String id;
  final String userId;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'content': content,
        'imageUrl': imageUrl,
        'likes': likes,
        'comments': comments,
        'shares': shares,
        'createdAt': createdAt.toUtc().millisecondsSinceEpoch,
      };

  static Post fromMap(Map<String, dynamic> map) => Post(
        id: map['id'] as String,
        userId: map['userId'] as String,
        content: map['content'] as String,
        imageUrl: map['imageUrl'] as String?,
        likes: (map['likes'] as num?)?.toInt() ?? 0,
        comments: (map['comments'] as num?)?.toInt() ?? 0,
        shares: (map['shares'] as num?)?.toInt() ?? 0,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          (map['createdAt'] as num).toInt(),
          isUtc: true,
        ).toLocal(),
      );
}
