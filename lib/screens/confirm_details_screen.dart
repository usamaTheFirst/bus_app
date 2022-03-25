import 'package:flutter/material.dart';
import '../exports.dart';

class ConfirmDetails extends StatelessWidget {
  const ConfirmDetails(
      {Key? key, this.source, this.destination, this.dateTime, this.busNumber})
      : super(key: key);

  static const routeName = '/confirm_details_screen';
  final String? source;
  final String? destination;
  final DateTime? dateTime;
  final String? busNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50, top: 10, left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Source',
                            style: TextStyle(
                              fontSize: 18,
                              color: kBackgroundColor,
                            ),
                          ),
                          Text(
                            'Source City',
                            style: TextStyle(
                              fontSize: 16,
                              color: kBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: const [
                          Text(
                            'Destination',
                            style: TextStyle(
                              fontSize: 18,
                              color: kBackgroundColor,
                            ),
                          ),
                          Text(
                            'Destination City',
                            style: TextStyle(
                              fontSize: 16,
                              color: kBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Route Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
          preferredSize: const Size.fromHeight(150),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: const [
                DetailsTile(
                  type: 'Date',
                  info: 'Date Placeholder',
                ),
                DetailsTile(
                  type: 'Time',
                  info: 'Time Placeholder',
                ),
                DetailsTile(
                  type: 'Bus Number',
                  info: 'Number Placeholder',
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: RoundedButton(
                title: 'Confirm Details', function: () {}, color: kTextColor),
          ),
        ],
      ),
    );
  }
}
