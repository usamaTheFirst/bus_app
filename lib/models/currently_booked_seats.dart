import 'package:bus_ticket_app/models/seat.dart';
import 'package:flutter/foundation.dart';

class BookedSeats extends ChangeNotifier {
  List<Seat> _bookedSeats = [];

  List<Seat> get bookedSeats => _bookedSeats;

  void addBookedSeat(Seat seat) {
    _bookedSeats.add(seat);
    notifyListeners();
  }

  void removeBookedSeat(Seat seat) {
    _bookedSeats.remove(seat);
    notifyListeners();
  }
}
