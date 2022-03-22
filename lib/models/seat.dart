class Seat {
  int id;
  String price;
  bool status = false;
  bool confirm = false;

  Seat({
    required this.id,
    required this.price,
  });

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
}
