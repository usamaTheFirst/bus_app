import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/models/currently_booked_seats.dart';
import 'package:bus_ticket_app/models/seat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget({Key? key, required this.seat, required this.seatNumber})
      : super(key: key);
  final Seat seat;
  final int seatNumber;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  Color? color;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.seat.confirm) {
      color = Colors.grey;
    } else {
      color = kPrimaryColor;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.seat.confirm
          ? null
          : () {
              print(widget.seat.confirm);
              print(widget.seatNumber);
              widget.seat.changeStatus();
              setState(() {
                if (widget.seat.isBooked) {
                  color = Colors.green;
                  Provider.of<BookedSeats>(context, listen: false)
                      .addBookedSeat(widget.seatNumber);
                } else {
                  color = kPrimaryColor;
                  Provider.of<BookedSeats>(context, listen: false)
                      .removeBookedSeat(
                    widget.seatNumber,
                  );
                }
              });
            },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(widget.seatNumber.toString()),
        ),
      ),
    );
  }
}
