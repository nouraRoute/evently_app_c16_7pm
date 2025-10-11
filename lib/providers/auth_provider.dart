import 'package:evently_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

class CurrantAuthProvider extends ChangeNotifier {
  UserModel? userModel;
  setCurrantUser(UserModel user) {
    userModel = user;
    notifyListeners();
  }
}
