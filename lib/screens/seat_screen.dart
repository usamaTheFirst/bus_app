import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:bus_ticket_app/models/currently_booked_seats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SeatScreen extends StatefulWidget {
  const SeatScreen({Key? key}) : super(key: key);
  static const String routeName = '/seat';

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final seatNumber = args['seatNumber'];
    final id = args['id'];
    final seats = Provider.of<BusRouteBag>(context)
        .busRoutes
        .where((element) => element.routeId == id)
        .toList()[0]
        .seats;
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
                              SeatWidget(seat: seats[ind], seatNumber: ind),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeatInformationWidget(title: "Booked", color: Colors.grey),
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
                function: () async {
                  final bookedSeats =
                      Provider.of<BookedSeats>(context, listen: false)
                          .bookedSeats;
                  print(seats[bookedSeats[0]].confirm);
                  int total = 0;
                  // final seats = Provider.of<BusRouteBag>(context, listen: false)
                  //     .busRoutes[index]
                  //     .seats;
                  for (var seat in bookedSeats) {
                    total += seats[seat].price;
                    print(seats[seat].confirm);
                  }

                  await makePayment(total);

                  print(total);
                  // await makePayment(total);
                  print(bookedSeats);
                  // for (var seat in bookedSeats) {
                  //   await seats[seat].confirmBooking();
                  //   print('index: $seat');
                  // }
                  setState(() {});
                  // Provider.of<BookedSeats>(context, listen: false)
                  //     .clearBookedSeats();
                })
          ],
        ));
  }

  Future<void> makePayment(int total) async {
    try {
      paymentIntentData = await createPaymentIntent(
          total.toString(), 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'US',
                  merchantDisplayName: 'ANNIE'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 8),
          content: Text("Seat Booked successfully"),
        ));
        final args =
            ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
        final index = args['index'];
        final seats = Provider.of<BusRouteBag>(context, listen: false)
            .busRoutes[index]
            .seats;
        final bookedSeats =
            Provider.of<BookedSeats>(context, listen: false).bookedSeats;
        for (var seat in bookedSeats) {
          await seats[seat].confirmBooking();
        }
        Navigator.of(context).popUntil((route) => route.isFirst);
        paymentIntentData = null;
        //Navigator.pushNamedAndRemoveUntil(context, MainUserScreen.routeName, (route) => false);
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Kk8BvGxayrTC90rZ4Fe7OTA7K3DzKf43AmEmW593sO8fsKlwsyQrW6EatNHQS7CKhjKnZX2Q6s2eXVHWRNuM4a200lVeqlFNi',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
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
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: color,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }
}
