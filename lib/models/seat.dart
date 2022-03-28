import 'package:flutter/cupertino.dart';

class Seat extends ChangeNotifier {
  int id;
  int price;
  bool status = false;
  bool confirm;

  Seat({required this.id, required this.price, required this.confirm});

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
        id: json["id"],
        price: json["price"],
        confirm: json["confirm"],
      );

  toJson() => {
        "id": id,
        "price": price,
        "confirm": confirm,
      };
}
