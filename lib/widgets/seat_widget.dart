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
              widget.seat.changeStatus();
              setState(() {
                if (widget.seat.isBooked) {
                  color = Colors.green;
                } else {
                  color = kPrimaryColor;
                }
              });
            },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );
  }
}
