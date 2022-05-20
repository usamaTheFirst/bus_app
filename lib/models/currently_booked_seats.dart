import 'package:flutter/foundation.dart';

class BookedSeats extends ChangeNotifier {
  List<int> bookedSeats = [];

  void addBookedSeat(int index) {
    bookedSeats.add(index);
    notifyListeners();
  }

  void removeBookedSeat(int index) {
    bookedSeats.remove(index);
    notifyListeners();
  }

  clearBookedSeats() {
    bookedSeats = [];
    notifyListeners();
  }
}
