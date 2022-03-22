import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/models/seat.dart';
import 'package:flutter/material.dart';

class SeatWidget extends StatefulWidget {
  const SeatWidget({Key? key, required this.seat}) : super(key: key);
  final Seat seat;

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<SeatWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.seat.changeStatus();
        setState(() {});
      },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: widget.seat.isBooked ? Colors.grey : Colors.lightGreenAccent,
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
