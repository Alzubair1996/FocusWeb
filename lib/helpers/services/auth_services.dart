import 'package:webkit/models/user.dart';

import '../../views/auth/login.dart';
import '../storage/local_storage.dart';

class AuthService {
  static bool isLoggedIn = false;

  static User get dummyUser =>
      User(-1, "Admin", "Denish", "Navadiya");

  static Future<Map<String, String>?> loginUser(String a) async {


   // await Future.delayed(Duration(seconds: 1));
    if (LoginPageState.pass != "focus12345") {
      return {"password": "Password is incorrect"};
    }

    isLoggedIn = true;await LocalStorage.setLoggedInUser(true);
    return null;
  }
}
