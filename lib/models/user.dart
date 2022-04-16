import 'package:bus_ticket_app/models/trip_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserData extends ChangeNotifier {
  String? name;
  late String email;
  late String id;
  late String role;
  List<TripHistory> history = [];
  List<TripHistory> schedule = [];

  setUserData(String? name, String? email, String id, String role) {
    if (name != null) this.name = name;
    if (email != null) this.email = email;
    if (role != null) this.role = role;
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

  getHistory() async {
    print("getHistory");

    history = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('bookings')
        .where('date', isLessThan: DateTime.now())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        history.add(TripHistory.fromJSON(element.data()));
      });
    });
    notifyListeners();
  }

  getBooking() async {
    print("getBookings");

    schedule = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('bookings')
        .where('date', isGreaterThan: DateTime.now())
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print(element.data());

        history.add(TripHistory.fromJSON(element.data()));
      });
    });
    notifyListeners();
  }
}
