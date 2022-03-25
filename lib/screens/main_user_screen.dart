import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../exports.dart';

class MainUserScreen extends StatelessWidget {
  const MainUserScreen({Key? key}) : super(key: key);

  static const routeName = '/main_user_screen';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              args['name'],
              style: TextStyle(
                fontSize: 20,
                color: kBackgroundColor,
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(40),
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
