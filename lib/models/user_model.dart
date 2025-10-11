import 'package:evently_app/models/event_model.dart';

class UserModel {
  String name;
  String email;
  String? uid;
  List<EventModel>? favEvents;
  UserModel({
    required this.email,
    required this.name,
    this.uid,
    this.favEvents,
  });
  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "uid": uid};
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      uid: json['uid'],
    );
  }
}
