import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/screens/locationscreen.dart';
import 'package:fuelapp/screens/splashscreen.dart';
import 'package:fuelapp/userdetail.dart';

import 'loginscreen.dart';

class otpverification extends StatefulWidget {
  @override
  State<otpverification> createState() => _otpverificationState();
}

class _otpverificationState extends State<otpverification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 100,
        ),
        Image.asset("assets/images/undraw_editable_dywm.png"),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Text(
            "Congratulations you have verified your phone number succesfully",
            style: TextStyle(
                fontSize: 25,
                color: Colors.pinkAccent,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => SignupPage()));
            },
            style: ButtonStyle(),
            child: Text("go to next page")),

        // Container(
        //   margin: EdgeInsets.all(65),
        //   width: double.infinity,
        //   child: ElevatedButton(
        //   style: ElevatedButton.styleFrom(
        //     primary: Colors.red,
        //   ),
        //   onPressed: (){
        //     FirebaseAuth.instance.signOut();
        //     Navigator.of(context).push(MaterialPageRoute(builder: (c) => LoginScreen1()));
        //   },
        //   child: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
        //   ),
        // ),
      ],
    ));
  }
}
