import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../config.dart';
import '../models/post.dart';

class PostService {
  final _db = FirebaseFirestore.instance;

  CloudinaryPublic _cloudinary() => CloudinaryPublic(
        AppConfig.cloudinaryCloudName,
        AppConfig.cloudinaryUploadPreset,
        cache: false,
      );

  Stream<List<Post>> getPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Post.fromMap(d.data()))
            .toList(growable: false));
  }

  Future<void> createPost({
    required String userId,
    required String content,
    String? imagePath,
  }) async {
    String? imageUrl;
    if (imagePath != null) {
      final cloudinary = _cloudinary();
      final res = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(imagePath,
            resourceType: CloudinaryResourceType.Image),
      );
      imageUrl = res.secureUrl;
    }

    final id = _db.collection('posts').doc().id;
    final post = Post(
      id: id,
      userId: userId,
      content: content,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );
    await _db.collection('posts').doc(id).set(post.toMap());
  }
}
