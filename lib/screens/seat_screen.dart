import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:bus_ticket_app/models/currently_booked_seats.dart';
import 'package:bus_ticket_app/models/seat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// var seats = [
//   Seat(
//     id: '122',
//     price: 133,
//     confirm: true,
//   ),
//   Seat(
//     id: '122',
//     price: 133,
//     confirm: false,
//   ),
//   Seat(
//     id: '122',
//     price: 133,
//     confirm: true,
//   ),
//   Seat(
//     id: '122',
//     price: 133,
//     confirm: false,
//   ),
//   Seat(
//     id: '122',
//     price: 133,
//     confirm: true,
//   ),
//   Seat(
//     id: 122.toString(),
//     price: 133,
//     confirm: false,
//   ),
// ];

class SeatScreen extends StatefulWidget {
  const SeatScreen({Key? key}) : super(key: key);
  static const String routeName = '/seat';

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  final booked_seats = [];
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final index = args['index'];
    final seats = Provider.of<BusRouteBag>(context).busRoutes[index].seats;
    return Scaffold(
        drawer: const DrawerWidget(),
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
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.all(8),
                        // height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.60,
                        height: MediaQuery.of(context).size.height * 0.70,
                        child: GridView.builder(
                            itemCount: seats.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 3 / 3,
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
                    const SizedBox(
                      height: 10,
                    ),
                    SeatInformationWidget(
                      title: 'Available',
                      color: kPrimaryColor,
                    ),
                    const SizedBox(
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
                color: kTextColor,
                title: 'Confirm Seats',
                function: () {
                  int l = Provider.of<BookedSeats>(context, listen: false)
                      .bookedSeats
                      .length;
                  print(l);
                })
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
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
        ),
        const SizedBox(
          width: 2,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
