import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Seat extends ChangeNotifier {
  String? id;
  int price;
  bool status = false;
  bool confirm;
  String? parentId;

  Seat({this.id, this.parentId, required this.price, required this.confirm});

  bool get isBooked => status;

  changeStatus() {
    if (!confirm) {
      status = !status;
    }
  }

  confirmBooking() async {
    if (!confirm) {
      confirm = !confirm;
      status = !status;
    }
    await FirebaseFirestore.instance
        .collection('bus_routes')
        .doc(parentId)
        .collection('seats')
        .doc(id)
        .update({
      'confirm': confirm,
    });
  }

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        price: json["price"],
        confirm: json["confirm"],
        id: json["id"],
        parentId: json["parentId"],
      );

  toJson() => {
        "price": price,
        "confirm": confirm,
      };
}
