import 'package:bus_ticket_app/models/seat.dart';
import 'package:flutter/foundation.dart';

class BookedSeats extends ChangeNotifier {
  List<int> _bookedSeats = [];

  List<int> get bookedSeats => _bookedSeats;

  void addBookedSeat(int index) {
    _bookedSeats.add(index);
    notifyListeners();
  }

  void removeBookedSeat(int index) {
    _bookedSeats.remove(index);
    notifyListeners();
  }
}
