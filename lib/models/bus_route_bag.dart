import 'package:bus_ticket_app/models/seat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bus_route.dart';

class BusRouteBag extends ChangeNotifier {
  List<BusRoute> busRoutes = [];

  addBusRoute(
      {required int price,
      required String source,
      required String destination,
      required String busNumber,
      required int numberOfSeats,
      required Timestamp time}) async {
    DocumentReference routeId =
        await FirebaseFirestore.instance.collection('bus_routes').add({
      'price': price,
      'source': source,
      'destination': destination,
      'bus_number': busNumber,
      'number_of_seats': numberOfSeats,
      'time': time,
    });
    final routeID = routeId.id;

    final List<Seat> seats = [];
    for (int i = 0; i < numberOfSeats; i++) {
      final tempSeat = Seat(confirm: false, price: price, seatNumber: i + 1);
      final seatId = await FirebaseFirestore.instance
          .collection('bus_routes')
          .doc(routeId.id)
          .collection('seats')
          .add(tempSeat.toJson());
      tempSeat.id = seatId.id;
      seats.add(tempSeat);
    }
    final busRoute = BusRoute(
      routeId: routeID,
      price: price,
      source: source,
      destination: destination,
      busNumber: busNumber,
      numberOfSeats: numberOfSeats,
      time: time,
      seats: seats,
    );

    fetchBusRoutes();
    notifyListeners();
  }

  fetchBusRoutes() async {
    busRoutes = [];
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('bus_routes').get();
    for (var doc in snapshot.docs) {
      final List<Seat> seats = [];
      await FirebaseFirestore.instance
          .collection('bus_routes')
          .doc(doc.id)
          .collection('seats')
          .get()
          .then((value) => value.docs.forEach((seat) {
                seats.add(Seat.fromJson({
                  'id': seat.id,
                  'confirm': seat['confirm'],
                  'price': seat['price'],
                  'parentId': doc.id,
                }));
              }));

      busRoutes.add(BusRoute(
        routeId: doc.id,
        price: doc['price'],
        source: doc['source'],
        destination: doc['destination'],
        busNumber: doc['bus_number'],
        numberOfSeats: doc['number_of_seats'],
        time: doc['time'],
        seats: seats,
      ));
    }
    notifyListeners();
  }

  updateBusRoute(
      {required String routeId,
      required int price,
      required String source,
      required String destination,
      required String busNumber,
      required int numberOfSeats,
      required Timestamp time}) async {
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(routeId)
        .update({
      'price': price,
      'source': source,
      'destination': destination,
      'bus_number': busNumber,
      'number_of_seats': numberOfSeats,
      'time': time,
    });
    fetchBusRoutes();
    notifyListeners();
  }

  deleteBusRoute(String routeId) async {
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(routeId)
        .delete();
    fetchBusRoutes();
    notifyListeners();
  }
}
