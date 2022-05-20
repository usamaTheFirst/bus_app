import 'package:cloud_firestore/cloud_firestore.dart';

class TripHistory {
  String source, destination, price, seatNumber;
  Timestamp date;

  TripHistory(
      {required this.source,
      required this.destination,
      required this.date,
      required this.price,
      required this.seatNumber});

  factory TripHistory.fromJSON(Map<String, dynamic> json) => TripHistory(
      source: json['source'],
      destination: json['destination'],
      date: json['date'] as Timestamp,
      price: json['price'].toString(),
      seatNumber: json['seatNumber'].toString());
}
