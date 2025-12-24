import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../services/user_service.dart';

class UsersList extends StatelessWidget {
  final UserService service;
  const UsersList({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Expanded(
      child: StreamBuilder<List<UserModel>>(
        stream: service.getUsers(),
        builder: (context, snapshot) {
          final users = snapshot.data ?? const <UserModel>[];
          if (users.isEmpty) {
            return const Center(child: Text('No users yet'));
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final u = users[index];
              final isMe = u.uid == auth.firebaseUser?.uid;
              return ListTile(
                leading: CircleAvatar(
                    child: Text(
                        u.name.isNotEmpty ? u.name[0].toUpperCase() : '?')),
                title: Text(u.name + (isMe ? ' (You)' : '')),
                subtitle: Text(u.email),
              );
            },
          );
        },
      ),
    );
  }
}
