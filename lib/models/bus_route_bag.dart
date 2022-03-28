import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'bus_route.dart';

class BusRouteBag extends ChangeNotifier {
  List<BusRoute> busRoutes = [];

  addBusRoute(BusRoute busRoute) async {
    busRoutes.add(busRoute);
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .add(busRoute.toJson());
    fetchBusRoutes();
    notifyListeners();
  }

  fetchBusRoutes() async {
    busRoutes = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('bus_routes').get();
    snapshot.docs.forEach((doc) {
      busRoutes.add(BusRoute.fromJson(doc.data() as Map<String, dynamic>));
    });
    notifyListeners();
  }
}
