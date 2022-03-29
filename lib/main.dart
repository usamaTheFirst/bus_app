import 'package:bus_ticket_app/screens/available_tickets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/bus_route_bag.dart';
import 'models/currently_booked_seats.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserData()),
    ChangeNotifierProvider.value(value: BusRouteBag()),
    ChangeNotifierProvider.value(value: BookedSeats()),
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
        AdminHomeScreen.routeName: (context) => const AdminHomeScreen(),
        ManageRoutes.routeName: (context) => const ManageRoutes(),
        SeatScreen.routeName: (context) => const SeatScreen(),
        AvailableTicketsScreen.routeName: (context) =>
            const AvailableTicketsScreen(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: const Changer(),
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
      await Provider.of<UserData>(context, listen: false)
          .setUserData(_user?.displayName, _user?.email, _user!.uid);
    }
  }

  Widget getScreen(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasData) {
      getRole();
      if (role == 'customer') {
        return const MainUserScreen();
      } else if (role == 'driver') {
        return const MainDriverScreen();
      } else {
        Future.delayed(Duration(seconds: 1), () {});

        return AdminHomeScreen();
      }
    } else {
      return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return getScreen(snapshot);
      },
    );
  }
}
