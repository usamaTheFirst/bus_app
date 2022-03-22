class Seat {
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
}
