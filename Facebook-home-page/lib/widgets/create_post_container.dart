import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../services/post_service.dart';

class CreatePostContainer extends StatelessWidget {
  const CreatePostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.userModel;

    return Container(
      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.grey[200],
                backgroundImage: user?.photoUrl != null
                    ? NetworkImage(user!.photoUrl!)
                    : null,
                child: user?.photoUrl == null
                    ? const Icon(Icons.person, color: Colors.grey)
                    : null,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration.collapsed(
                    hintText: 'What\'s on your mind?',
                  ),
                  onSubmitted: (value) async {
                    if (value.trim().isNotEmpty && user != null) {
                      await PostService().createPost(
                        userId: user.uid,
                        content: value.trim(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const Divider(height: 10.0, thickness: 0.5),
          SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam, color: Colors.red),
                  label: const Text('Live'),
                ),
                const VerticalDivider(width: 8.0),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.photo_library, color: Colors.green),
                  label: const Text('Photo'),
                ),
                const VerticalDivider(width: 8.0),
                TextButton.icon(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.video_call, color: Colors.purpleAccent),
                  label: const Text('Room'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
