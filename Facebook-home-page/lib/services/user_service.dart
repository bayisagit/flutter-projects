import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserService {
  final _db = FirebaseFirestore.instance;

  Stream<List<UserModel>> getUsers() {
    return _db.collection('users').orderBy('name').snapshots().map((snapshot) =>
        snapshot.docs
            .map((d) => UserModel.fromMap(d.data()))
            .toList(growable: false));
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserModel.fromMap(doc.data()!);
  }
}
