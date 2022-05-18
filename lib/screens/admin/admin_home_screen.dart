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
    String? name = Provider.of<UserData>(context, listen: false).name;
    print('AdminHomeScreen: $name');
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
              name ?? "Admin",
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
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ManageRoutes.routeName);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 140,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: kBackgroundColor,
                elevation: 8,
                borderOnForeground: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FaIcon(FontAwesomeIcons.edit, size: 60, color: kTextColor),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Manage Routes',
                        style: TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
