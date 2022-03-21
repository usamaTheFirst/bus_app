import 'package:flutter/material.dart';
import '../exports.dart';

class ConfirmDetails extends StatelessWidget {
  const ConfirmDetails({Key? key, this.source, this.destination})
      : super(key: key);

  static const routeName = '/confirm_details_screen';
  final String? source;
  final String? destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        bottom: PreferredSize(
          child: Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 50, top: 10, left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
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
                      ),
                      Container(
                        child: Column(
                          children: [
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
                      ),
                    ],
                  ),
                ),
                Text(
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
          preferredSize: Size.fromHeight(150),
        ),
      ),
    );
  }
}
