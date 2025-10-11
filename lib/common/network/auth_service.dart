import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/event_model.dart';
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
      UserModel? user = await getUserInfo(credential.user!.uid);
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

  static Future<UserModel?> getUserInfo(String uid) async {
    CollectionReference<UserModel> users = _getUserCollection();
    DocumentSnapshot<UserModel> doc = await users.doc(uid).get();
    UserModel? user = doc.data();
    if (user != null) {
      List<EventModel> events = await getUserFavEvents(uid);
      user.favEvents = events;
    }
    return user;
  }

  static CollectionReference<EventModel> _getUserFavCollection(String uid) {
    CollectionReference<EventModel> userFavCollection = _getUserCollection()
        .doc(uid)
        .collection('fav_events')
        .withConverter<EventModel>(
          fromFirestore: (snapshot, options) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
    return userFavCollection;
  }

  static Future<List<EventModel>> getUserFavEvents(String uid) async {
    CollectionReference<EventModel> collction = _getUserFavCollection(uid);
    QuerySnapshot<EventModel> snapshot = await collction.get();
    return snapshot.docs.map((e) => e.data()).toList();
  }

  static Future<void> addFavEvent(EventModel event, String uid) async {
    CollectionReference<EventModel> collction = _getUserFavCollection(uid);
    DocumentReference doc = collction.doc(event.id);
    await doc.set(event);
  }

  static Future<void> removeFAvEvent(String eventID, String uid) async {
    CollectionReference<EventModel> collction = _getUserFavCollection(uid);
    await collction.doc(eventID).delete();
  }

  logout() {}
  deleteUser() {}
  updateUSer(UserModel user) {}
}
