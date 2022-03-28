import 'package:bus_ticket_app/models/seat.dart';

class Bus {
  late String id;
  late List<Seat> seats;
  late int totalSeats;

  Bus({required this.id, required this.seats, required this.totalSeats});
}
