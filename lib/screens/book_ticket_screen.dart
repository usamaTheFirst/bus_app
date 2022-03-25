import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../exports.dart';

class BookTicket extends StatefulWidget {
  const BookTicket({Key? key}) : super(key: key);

  static const routeName = '/book_ticket_screen';

  @override
  State<BookTicket> createState() => _BookTicketState();
}

class _BookTicketState extends State<BookTicket> {
  DateTime pickedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Book Ticket',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
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
              decoration: const InputDecoration(
                prefixIcon: Icon(FontAwesomeIcons.arrowRight),
                hintText: 'Enter Source',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(FontAwesomeIcons.arrowLeft),
                  hintText: 'Enter Destination'),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Picked Date : ${DateFormat.yMd().format(pickedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _datePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  width: 150,
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

  _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((date) {
      if (date == null) {
        return;
      }
      setState(() {
        pickedDate = date;
      });
    });
  }
}
