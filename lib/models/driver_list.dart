import 'package:bus_ticket_app/models/bus_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DriverData extends ChangeNotifier {
  List<BusRoute> pastRoutes = <BusRoute>[];
  List<BusRoute> newRoutes = <BusRoute>[];

  String? name, id, email;

  DriverData({
    this.name,
    this.id,
    this.email,
  });

  assignDriver(String routeId) async {
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(routeId)
        .update({'driver': name});

    final routeData = await FirebaseFirestore.instance
        .collection("bus_routes")
        .doc(routeId)
        .get();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jobs')
        .doc(routeId)
        .set(routeData.data() as Map<String, dynamic>);
    // });
  }

  getPastRoutes() async {
    pastRoutes = [];
    final id = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jobs')
        .where("time", isLessThan: Timestamp.now())
        .get()
        .then((value) => value.docs.forEach((doc) {
              pastRoutes.add(BusRoute(
                  routeId: doc.id,
                  source: doc.get("source"),
                  destination: doc.get("destination"),
                  price: doc.get("price"),
                  busNumber: doc.get("bus_number"),
                  time: doc.get("time"),
                  numberOfSeats: doc.get("number_of_seats"),
                  seats: []));
            }));
    notifyListeners();
  }

  getNewRoutes() async {
    newRoutes = [];
    final id = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('jobs')
        .where("time", isGreaterThan: Timestamp.now())
        .get()
        .then((value) => value.docs.forEach((doc) {
              newRoutes.add(BusRoute(
                  routeId: doc.id,
                  source: doc.get("source"),
                  destination: doc.get("destination"),
                  price: doc.get("price"),
                  busNumber: doc.get("bus_number"),
                  time: doc.get("time"),
                  numberOfSeats: doc.get("number_of_seats"),
                  seats: []));
            }));
    notifyListeners();
  }
}

class DriverList extends ChangeNotifier {
  List<DriverData> drivers = [];

  fetchDrivers() async {
    final ffb = FirebaseFirestore.instance.collection('users');

    await ffb.where('role', isEqualTo: 'driver').get().then((value) {
      drivers = [];
      for (var doc in value.docs) {
        drivers.add(DriverData(
            name: doc.data()['name'], id: doc.id, email: doc.data()['email']));
      }
      notifyListeners();
    });
  }

  assignDriver(int index, String id) async {
    await drivers[index].assignDriver(id);
    notifyListeners();
  }
}
