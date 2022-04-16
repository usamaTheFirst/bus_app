import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/exports.dart';

class MainDriverScreen extends StatelessWidget {
  const MainDriverScreen({Key? key}) : super(key: key);

  static const routeName = '/main_driver_screen';

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
            child: const Text(
              "Driver Name",
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
                title: 'My Routes',
                onTap: () {
                  Navigator.pushNamed(context, DriverRoutes.routeName);
                },
                iconSource: FontAwesomeIcons.route),
            MenuTile(
                title: 'Past Routes',
                onTap: () {
                  Navigator.pushNamed(context, DriverPastRoutes.routeName);
                },
                iconSource: FontAwesomeIcons.history),
          ],
        ),
      ),
    );
  }
}
