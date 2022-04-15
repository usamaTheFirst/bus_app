import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/bus_route_bag.dart';
import 'package:bus_ticket_app/models/currently_booked_seats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  Map<String, dynamic>? paymentIntentData;
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
                              SeatWidget(seat: seats[ind], index: index),
                        ),
                      )
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
                function: () async {
                  final bookedSeats =
                      Provider.of<BookedSeats>(context, listen: false)
                          .bookedSeats;
                  int total = 0;
                  final seats = Provider.of<BusRouteBag>(context, listen: false)
                      .busRoutes[index]
                      .seats;
                  for (var seat in bookedSeats) {
                    await seats[index].confirmBooking();
                    total += seats[index].price;
                  }

                  print(total);
                  setState(() {});
                  await makePayment(total);
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
    } catch (e, s) {
      print('exception:$e$s');
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
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;
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
