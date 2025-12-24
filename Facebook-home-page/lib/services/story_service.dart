import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import '../config.dart';
import '../models/story.dart';

class StoryService {
  final _db = FirebaseFirestore.instance;

  CloudinaryPublic _cloudinary() => CloudinaryPublic(
        AppConfig.cloudinaryCloudName,
        AppConfig.cloudinaryUploadPreset,
        cache: false,
      );

  Stream<List<Story>> getActiveStories() {
    final since = DateTime.now().toUtc().millisecondsSinceEpoch -
        const Duration(hours: 24).inMilliseconds;
    return _db
        .collection('stories')
        .where('createdAt', isGreaterThan: since)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Story.fromMap(d.data()))
            .where((s) => s.isActive)
            .toList(growable: false));
  }

  Future<Story> uploadStory({
    required String userId,
    required String filePath,
  }) async {
    final cloudinary = _cloudinary();
    final res = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath,
          resourceType: CloudinaryResourceType.Image),
    );
    final id = _db.collection('stories').doc().id;
    final story = Story(
      id: id,
      userId: userId,
      imageUrl: res.secureUrl,
      createdAt: DateTime.now(),
    );
    await _db.collection('stories').doc(id).set(story.toMap());
    return story;
  }
}
