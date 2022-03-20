import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/bus.dart';
import '../constants/constants.dart';

class MainUserScreen extends StatelessWidget {
  const MainUserScreen({Key? key}) : super(key: key);

  static const routeName = '/main_user_screen';

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
            child: Text(
              'User Name',
              style: TextStyle(
                fontSize: 20,
                color: kBackgroundColor,
              ),
            ),
          ),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 40,
          mainAxisSpacing: 40,
          children: [
            MenuTile(
                title: 'Book Ticket',
                onTap: () {},
                iconSource: FontAwesomeIcons.ticketAlt),
            MenuTile(
                title: 'View History',
                onTap: () {},
                iconSource: FontAwesomeIcons.history),
            MenuTile(
                title: 'My Booking',
                onTap: () {},
                iconSource: FontAwesomeIcons.bus),
            MenuTile(
                title: 'View Schedule',
                onTap: () {},
                iconSource: FontAwesomeIcons.calendarDay),
          ],
        ),
      ),
    );
  }
}
