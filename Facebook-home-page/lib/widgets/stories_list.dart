import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/story.dart';
import '../providers/auth_provider.dart';
import '../services/story_service.dart';

class StoriesList extends StatelessWidget {
  final StoryService service;
  const StoriesList({super.key, required this.service});

  Future<void> _addStory(BuildContext context) async {
    final auth = context.read<AuthProvider>();
    final userId = auth.firebaseUser?.uid;
    if (userId == null) return;

    final picker = ImagePicker();
    final xfile =
        await picker.pickImage(source: ImageSource.gallery, maxWidth: 1080);
    if (xfile == null) return;

    try {
      await service.uploadStory(userId: userId, filePath: xfile.path);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Story uploaded')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: StreamBuilder<List<Story>>(
        stream: service.getActiveStories(),
        builder: (context, snapshot) {
          final stories = snapshot.data ?? const <Story>[];
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: stories.length + 1,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () => _addStory(context),
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F3FF),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF1877F2)),
                    ),
                    child: const Icon(Icons.add, color: Color(0xFF1877F2)),
                  ),
                );
              }
              final story = stories[index - 1];
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: story.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Story',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
