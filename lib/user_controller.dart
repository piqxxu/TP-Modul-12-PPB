import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UserController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _collectionName = 'users';

  Stream<List<UserModel>> streamUsers() {
    return _db
        .collection(_collectionName)
        .orderBy('createdDate', descending: true)
        .snapshots() 
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return UserModel.fromMap(doc.id, doc.data());
          }).toList();
        });
  }

  Future<void> createUser(String name, String description) async {
    final UserModel newUser = UserModel(
      name: name,
      description: description,
      createdDate: DateTime.now(), 
    );

    try {
      await _db.collection(_collectionName).add(newUser.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
