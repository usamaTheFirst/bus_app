import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../exports.dart';
import '../../models/user.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/admin-home';
  @override
  Widget build(BuildContext context) {
    String? name = Provider.of<UserData>(context).name;
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text(
          'Admin Home',
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        bottom: PreferredSize(
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(
              name,
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
                title: 'Manage Routes',
                onTap: () {
                  Navigator.pushNamed(context, ManageRoutes.routeName);
                },
                iconSource: FontAwesomeIcons.edit),
          ],
        ),
      ),
    );
  }
}
