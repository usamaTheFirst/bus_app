import 'package:bus_ticket_app/models/seat.dart';

class Bus {
  late String id;
  late List<Seat> seats;
  late int totalSeats;

  Bus({required this.id, required this.seats, required this.totalSeats});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      seats: (json['seats'] as List<dynamic>)
          .map((seat) => Seat.fromJson(seat))
          .toList(),
      totalSeats: json['totalSeats'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'seats': seats
          .map((seat) => {
                'id': seat.id,
                'number': seat.id,
                'status': seat.status,
                "confirm": seat.confirm,
              })
          .toList(),
      'totalSeats': totalSeats,
    };
  }
}
