import 'package:bus_ticket_app/models/bus.dart';
import 'package:bus_ticket_app/models/seat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusRoute {
  late String routeId;
  late String source;
  late String destination;
  late int price;
  late String busNumber;
  late DateTime time;
  late int numberOfSeats;
  List<Seat> seats = [];
  //write constructor
  BusRoute({
    required this.routeId,
    required this.source,
    required this.destination,
    required this.price,
    required this.busNumber,
    required this.time,
    required this.numberOfSeats,
    required this.seats,
  });

  toJson() {
    return {
      'source': source,
      'destination': destination,
      'price': price,
      'busNumber': busNumber,
      'time': time,
      'numberOfSeats': numberOfSeats,
    };
  }

  factory BusRoute.fromJson(Map<String, dynamic> json) {
    return BusRoute(
      source: json['source'],
      destination: json['destination'],
      price: int.parse(json['price']),
      busNumber: (json['busNumber']),
      numberOfSeats: int.parse(json['numberOfSeats']),
      seats: List<Seat>.from(json['seats'].map((x) => Seat.fromJson(x))),
      time: json['time'],
      routeId: 'routeId',
    );
  }
}
