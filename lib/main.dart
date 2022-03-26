import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserData()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomePage.routeName: (context) => const HomePage(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        MainUserScreen.routeName: (context) => const MainUserScreen(),
        BookTicket.routeName: (context) => const BookTicket(),
        ConfirmDetails.routeName: (context) => const ConfirmDetails(),
        PaymentScreen.routeName: (context) => const PaymentScreen(),
        ViewHistory.routeName: (context) => const ViewHistory(),
        MyBooking.routeName: (context) => const MyBooking(),
        MainDriverScreen.routeName: (context) => const MainDriverScreen(),
        DriverRoutes.routeName: (context) => const DriverRoutes(),
        DriverPastRoutes.routeName: (context) => const DriverPastRoutes(),
        DriverUpcomingRoutes.routeName: (context) =>
            const DriverUpcomingRoutes(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: Changer(),
    );
  }
}

class Changer extends StatefulWidget {
  const Changer({
    Key? key,
  }) : super(key: key);

  @override
  State<Changer> createState() => _ChangerState();
}

class _ChangerState extends State<Changer> {
  String? role;
  bool firstTime = true;

  getRole() async {
    print('Calling get role');
    final _user = FirebaseAuth.instance.currentUser;
    String? id = _user?.uid;

    String role = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) => value.data()!['role']);
    if (firstTime) {
      setState(() {
        this.role = role;
        firstTime = false;
      });
      print('Before calling provider in get role');
      print(_user?.displayName);
      Provider.of<UserData>(context, listen: false).setUser(_user!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          getRole();
          if (role == 'customer') {
            return const MainUserScreen();
          } else if (role == 'driver') {
            return const MainDriverScreen();
          }
        }

        return const HomePage();
      },
    );
  }
}
