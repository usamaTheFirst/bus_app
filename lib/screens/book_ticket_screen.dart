import 'package:flutter/material.dart';

import '../bus.dart';
import '../constants/constants.dart';

class BookTicket extends StatelessWidget {
  const BookTicket({Key? key}) : super(key: key);

  static const routeName = '/book_ticket_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Ticket',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 4)
          ],
          color: kBackgroundColor,
        ),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.departure_board),
                  hintText: 'Enter Source'),
            ),
            TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.share_arrival_time),
                  hintText: 'Enter Destination'),
            ),
            DatePickerWidget(),
            Padding(
              padding: EdgeInsets.all(15),
              child: InkWell(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 48,
                  child: Center(
                      child: Text(
                    'Search',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kTextColor,
                      fontFamily: 'Inter',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
