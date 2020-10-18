import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_notes/config/paths.dart';
import 'package:flutter_bloc_notes/entities/entities.dart';
import 'package:flutter_bloc_notes/models/user_model.dart';
import 'package:flutter_bloc_notes/repositories/repositories.dart';
import 'package:meta/meta.dart';

class AuthRepository extends BaseAuthRepository {
  final Firestore _firestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({Firestore firestore, FirebaseAuth firebaseAuth})
      : _firestore = firestore ?? Firestore.instance,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  void dispose() {}

  Future<User> _firebaseUserToUser(FirebaseUser user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection(Paths.users).document(user.uid).get();
    if (userDoc.exists) {
      User user = User.fromEntity(UserEntity.fromSnapshot(userDoc));
      return user;
    }
    return User(
      id: user.uid,
      email: '',
    );
  }

  @override
  Future<User> loginAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<User> signupWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final currentUser = await _firebaseAuth.currentUser();
    final authCredential =
        EmailAuthProvider.getCredential(email: email, password: password);
    final authResult = await currentUser.linkWithCredential(authCredential);
    final user = await _firebaseUserToUser(authResult.user);
    _firestore
        .collection(Paths.users)
        .document(user.id)
        .setData(user.toEntity().toDocument());

    return user;
  }

  @override
  Future<User> loginWithEmailAndPassword(
      {@required String email, @required String password}) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return await _firebaseUserToUser(authResult.user);
  }

  @override
  Future<User> logout() async {
    await _firebaseAuth.signOut();
    return await loginAnonymously();
  }

  @override
  Future<User> getCurrentUser() async {
    final currentUser = await _firebaseAuth.currentUser();
    if (currentUser == null) return null;
    return await _firebaseUserToUser(currentUser);
  }

  @override
  Future<bool> isAnonymous() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser.isAnonymous;
  }
}
