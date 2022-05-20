import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Seat extends ChangeNotifier {
  String? id;
  int price;
  bool status = false;
  bool confirm;
  String? parentId;
  int? seatNumber;

  Seat(
      {this.id,
      this.parentId,
      required this.price,
      required this.confirm,
      this.seatNumber});

  bool get isBooked => status;

  changeStatus() {
    if (!confirm) {
      status = !status;
    }
  }

  confirmBooking() async {
    print(confirm);
    if (!confirm) {
      confirm = !confirm;
      status = !status;
      print('Starting booking');
      print(confirm);
      final response = await FirebaseFirestore.instance
          .collection('bus_routes')
          .doc(parentId)
          .collection('seats')
          .doc(id)
          .update({
        'confirm': confirm,
      });
      await assignSeatToUser(seatNumber as int);
      print('Booking completed');
    }
    final response = await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(parentId)
        .collection('seats')
        .doc(id)
        .update({
      'confirm': confirm,
    });

    await assignSeatToUser(seatNumber as int);
    print('Booking completed');
  }

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        price: json["price"],
        confirm: json["confirm"],
        id: json["id"],
        parentId: json["parentId"],
        seatNumber: json["seatNumber"],
      );

  toJson() => {
        "price": price,
        "confirm": confirm,
        "seatNumber": seatNumber,
      };

  assignSeatToUser(int seatNumber) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final ffstore = FirebaseFirestore.instance;
    ffstore.collection('bus_routes').doc(parentId).get().then((value) {
      final source = value.data()!['source'];
      final destination = value.data()!['destination'];
      final date = value.data()!['time'];

      print("Route info");
      print(source);
      print(destination);
      print(date);

      ffstore
          .collection('users')
          .doc(userId)
          .collection('bookings')
          .doc(id)
          .set({
        'id': id,
        'parentId': parentId,
        'source': source,
        'destination': destination,
        'price': price,
        'date': date,
        'seatNumber': seatNumber,
      });
    });
  }
}
