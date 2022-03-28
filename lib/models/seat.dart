import 'package:flutter/cupertino.dart';

class Seat extends ChangeNotifier {
  String? id;
  int price;
  bool status = false;
  bool confirm;

  Seat({this.id, required this.price, required this.confirm});

  bool get isBooked => status;

  changeStatus() {
    if (!confirm) {
      status = !status;
    }
  }

  confirmBooking() {
    if (!confirm) {
      confirm = !confirm;
    }
  }

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        price: json["price"],
        confirm: json["confirm"],
      );

  toJson() => {
        "price": price,
        "confirm": confirm,
      };
}
