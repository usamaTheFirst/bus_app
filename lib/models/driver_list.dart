import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DriverData {
  String name, id, email, busNumber;
  DriverData(
      {required this.name,
      required this.id,
      required this.email,
      required this.busNumber});

  assignDriver(String routeId) async {
    print('assigning driver');
    print(id);
    print(routeId);
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(routeId)
        .update({'driver': name});

    await FirebaseFirestore.instance
        .collection("bus_routes")
        .doc(routeId)
        .get()
        .then((value) async {
      final tempSource = value['source'];
      final tempDestination = value['destination'];
      final tempDate = value['time'];
      final busNumber = value['bus_number'];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('jobs')
          .add({
        'name': name,
        'email': email,
        'source': tempSource,
        'destination': tempDestination,
        'time': tempDate,
        'bus_number': busNumber,
      });
    });
  }
}

class DriverList extends ChangeNotifier {
  List<DriverData> drivers = [];

  fetchDrivers() async {
    final ffb = FirebaseFirestore.instance.collection('users');

    ffb.where('role', isEqualTo: 'driver').get().then((value) {
      drivers = [];
      for (var doc in value.docs) {
        drivers.add(DriverData(
            name: doc.data()['name'],
            id: doc.id,
            email: doc.data()['email'],
            busNumber: doc.data()['bus_number']));
      }
      notifyListeners();
    });
  }

  assignDriver(int index, String id) async {
    await drivers[index].assignDriver(id);
    notifyListeners();
  }
}
