import 'package:flutter/material.dart';
import 'package:fuelapp/screens/fueldetailsscreen.dart';
import 'package:fuelapp/screens/locationscreen.dart';
import 'package:fuelapp/screens/loginscreen.dart';
import 'package:fuelapp/screens/onboarding.dart';
import 'package:fuelapp/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fuelapp/userdetail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FuelApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
