import 'exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: const ConfirmDetails(),
    );
  }
}
