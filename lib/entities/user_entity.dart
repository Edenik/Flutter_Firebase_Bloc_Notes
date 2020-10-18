import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;

  const UserEntity({
    this.id,
    @required this.email,
  });

  @override
  List<Object> get props => [id, email];

  @override
  String toString() => '''UserEntity {
    id: $id,
    email: $email
  }''';

  Map<String, dynamic> toDocument() {
    return {
      'email': email,
    };
  }

  factory UserEntity.fromSnapshot(DocumentSnapshot doc) {
    return UserEntity(
      id: doc.documentID,
      email: doc.data['email'] ?? '',
    );
  }
}
