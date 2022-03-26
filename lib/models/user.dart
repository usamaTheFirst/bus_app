import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  late String name;
  late String email;
  late String id;

  setUserData(String? name, String? email, String id) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    this.id = id;

    notifyListeners();
  }

  // void setUser(User user) {
  //   this.name = user.displayName!;
  //   this.email = user.email!;
  //   this.id = user.uid;
  //   print("setUser");
  //   print(user.uid);
  //   print(user.displayName);
  //   print(user.email);
  //   print("End setUser");
  //   notifyListeners();
  // }

  // write a functions to get name, id and email

  String? getName() {
    return name;
  }

  String? getEmail() {
    return email;
  }
}
