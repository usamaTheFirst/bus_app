import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  String? name;
  String? email;
  String? id;

  void setUser(User user) {
    this.name = user.displayName;
    this.email = user.email;
    this.id = user.uid;

    print(user.uid);
    print(user.displayName);
    print(user.email);

    notifyListeners();
  }
}
