import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserModel?> login(String email, String password) async {
    try {
      print('------>Logedin');

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel? user = await _getUserInfo(credential.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      print('----->${e.code}');
      throw e.message ?? 'some thing went wrong';
    } catch (e) {
      print('----->$e');
      rethrow;
    }
  }

  static Future<void> registerNewUser(UserModel user, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email,
            password: password,
          );
      user.uid = credential.user!.uid;
      await _addUserInfo(user);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'something went wrong';
    } catch (e) {
      rethrow;
    }
  }

  static CollectionReference<UserModel> _getUserCollection() {
    CollectionReference<UserModel> users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return users;
  }

  static Future<void> _addUserInfo(UserModel user) async {
    CollectionReference<UserModel> usersCollection = _getUserCollection();
    DocumentReference<UserModel> doc = usersCollection.doc(user.uid);
    await doc.set(user);
  }

  static Future<UserModel?> _getUserInfo(String uid) async {
    CollectionReference<UserModel> users = _getUserCollection();
    DocumentSnapshot<UserModel> doc = await users.doc(uid).get();
    return doc.data();
  }

  logout() {}
  deleteUser() {}
  updateUSer(UserModel user) {}
}
