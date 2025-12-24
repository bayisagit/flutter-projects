class Story {
  final String id;
  final String userId;
  final String imageUrl;
  final DateTime createdAt;

  Story({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
  });

  bool get isActive => DateTime.now().difference(createdAt).inHours < 24;

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'imageUrl': imageUrl,
        'createdAt': createdAt.toUtc().millisecondsSinceEpoch,
      };

  static Story fromMap(Map<String, dynamic> map) => Story(
        id: map['id'] as String,
        userId: map['userId'] as String,
        imageUrl: map['imageUrl'] as String,
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          (map['createdAt'] as num).toInt(),
          isUtc: true,
        ).toLocal(),
      );
}
