import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id; 
  final String name;
  final String description;
  final DateTime createdDate;

  UserModel({
    this.id,
    required this.name,
    required this.description,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      name: map['name'] as String,
      description: map['description'] as String,
      createdDate: (map['createdDate'] as Timestamp).toDate(),
    );
  }
}
