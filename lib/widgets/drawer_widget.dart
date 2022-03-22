import 'package:bus_ticket_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: kPrimaryColor,
              ),
              accountName: Text('Usama Fayyaz'),
              accountEmail: Text('usamafiaz1453@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1374&q=80'),
                backgroundColor: Colors.transparent,
                radius: 30,
              ),
            ),
            const ListTile(
              leading: Icon(FontAwesomeIcons.home),
              title: Text("Home"),
            ),
            const Divider(
              thickness: 1,
            ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.mailBulk),
              onTap: () async {
                await launch("mailto:usamafiaz@1453@gmail.com");
              },
              title: Text("Contact us"),
            ),
            Divider(
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
