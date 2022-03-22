import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/seat.dart';
import 'package:bus_ticket_app/widgets/seat_widget.dart';
import 'package:flutter/material.dart';

var seats = [
  Seat(
    id: 122,
    price: 133,
    confirm: true,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: false,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: true,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: false,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: true,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: false,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: true,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: false,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: true,
  ),
  Seat(
    id: 122,
    price: 133,
    confirm: false,
  ),
];

class SeatScreen extends StatelessWidget {
  const SeatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const Text('Select Seats'),
          backgroundColor: kPrimaryColor,
        ),
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        margin: EdgeInsets.all(8),
                        // height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: GridView.builder(
                            itemCount: seats.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (ctx, ind) =>
                                SeatWidget(seat: seats[ind])),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeatInformationWidget(
                        title: "Not Available", color: Colors.grey),
                    SizedBox(
                      height: 10,
                    ),
                    SeatInformationWidget(
                      title: 'Available',
                      color: kPrimaryColor,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SeatInformationWidget(
                      title: 'Seleted',
                      color: Colors.green,
                    )
                  ],
                )
              ],
            ),
            RoundedButton(
                color: kTextColor, title: 'Confirm Seats', function: () {})
          ],
        ));
  }
}

class SeatInformationWidget extends StatelessWidget {
  SeatInformationWidget({Key? key, required this.title, required this.color})
      : super(key: key);
  String title;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}