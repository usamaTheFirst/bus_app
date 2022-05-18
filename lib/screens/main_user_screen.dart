import 'package:bus_ticket_app/models/user.dart';
import 'package:bus_ticket_app/screens/booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../exports.dart';

class MainUserScreen extends StatelessWidget {
  const MainUserScreen({Key? key}) : super(key: key);

  static const routeName = '/main_user_screen';

  @override
  Widget build(BuildContext context) {
    String? name = Provider.of<UserData>(context).getName();
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
            child: Text(
              name!,
              style: const TextStyle(
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
                onTap: () {
                  Navigator.of(context).pushNamed(SelectCityScreen.routeName);
                },
                iconSource: FontAwesomeIcons.ticketAlt),
            MenuTile(
                title: 'View History',
                onTap: () {
                  Navigator.pushNamed(context, ViewHistory.routeName);
                },
                iconSource: FontAwesomeIcons.history),
            MenuTile(
                title: 'My Booking',
                onTap: () {
                  Navigator.pushNamed(context, ViewBooking.routeName);
                },
                iconSource: FontAwesomeIcons.bus),
          ],
        ),
      ),
    );
  }
}
