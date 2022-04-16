import 'package:bus_ticket_app/models/driver_list.dart';
import 'package:bus_ticket_app/screens/admin/assign_driver_screen.dart';
import 'package:bus_ticket_app/screens/available_tickets.dart';
import 'package:bus_ticket_app/screens/loader_screen.dart';
import 'package:bus_ticket_app/screens/booking_screen.dart';
import 'package:bus_ticket_app/screens/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/bus_route_bag.dart';
import 'models/currently_booked_seats.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51Kk8BvGxayrTC90rVekDk4YfDfJVvfIInlQLTAUBLt2YeubUzMqPyud0gxLayPZ5SjbC864ibtXyoGLkLXQY4Prl00L6sCLqkT";
  await Stripe.instance.applySettings();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserData()),
    ChangeNotifierProvider.value(value: DriverList()),
    ChangeNotifierProvider.value(value: BusRouteBag()),
    ChangeNotifierProvider.value(value: DriverData()),
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
        EditRoute.routeName: (context) => EditRoute(),
        SettingScreen.routeName: (context) => const SettingScreen(),
        ViewBooking.routeName: (context) => ViewBooking(),
        AssignDriverScreen.routeName: (context) => const AssignDriverScreen(),
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
          .setUserData(_user?.displayName, _user?.email, _user!.uid, role);
    }
  }

  Widget getScreen(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasData) {
      getRole();
      if (role == 'customer') {
        return const MainUserScreen();
      } else if (role == 'driver') {
        return const MainDriverScreen();
      } else if (role == 'admin') {
        Future.delayed(const Duration(seconds: 1), () {});

        return const AdminHomeScreen();
      } else {
        return const LoaderScreen();
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
