import 'package:bus_ticket_app/constants/constants.dart';
import 'package:bus_ticket_app/exports.dart';
import 'package:bus_ticket_app/models/user.dart';
import 'package:bus_ticket_app/screens/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<UserData>(context, listen: false);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: kPrimaryColor,
              ),
              accountName: Text(data.getName().toString()),
              accountEmail: Text(data.getEmail().toString()),
              currentAccountPicture: CircleAvatar(
                child: Text(data.getName().toString()[0],
                    style: const TextStyle(fontSize: 30)),
                backgroundColor: kBackgroundColor,
              ),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.of(context).pop();

                String role = data.role;

                if (role == "admin") {
                  Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
                } else if (role == "user") {
                  Navigator.of(context).pushNamed(MainUserScreen.routeName);
                } else if (role == "driver") {
                  Navigator.of(context).pushNamed(MainDriverScreen.routeName);
                }
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, SettingScreen.routeName);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.mailBulk),
              onTap: () async {
                await launch("mailto:usamafiaz@1453@gmail.com");
              },
              title: const Text("Contact us"),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
            const Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
