import 'package:bus_ticket_app/models/trip_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    this.role = role;
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
    history = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('bookings')
        .where('date', isLessThan: DateTime.now())
        .get()
        .then((value) {
      for (var element in value.docs) {
        history.add(TripHistory.fromJSON(element.data()));
      }
    });
    notifyListeners();
  }

  getBooking() async {
    schedule = [];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection('bookings')
        .where('date', isGreaterThan: DateTime.now())
        .get()
        .then((value) {
      for (var element in value.docs) {
        print(element.data());

        schedule.add(TripHistory.fromJSON(element.data()));
      }
    });
    notifyListeners();
  }
}
