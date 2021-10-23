import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/screens/OTPController.dart';
import 'package:lottie/lottie.dart';

class LoginScreen1 extends StatefulWidget {
  const LoginScreen1({key}) : super(key: key);

  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  countrypicker() {
    return CountryCodePicker(
      onChanged: (country) {
        setState(() {
          dialCodeDigits = country.dialCode;
        });
      },
      initialSelection: "",
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      favorite: ["+1", "US", "+91", "IND"],
    );
  }

  String number = "";
  String dialCodeDigits = "+00";
  TextEditingController _controller = TextEditingController();
  bool changestate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text("Login to keep Ordering best quality of fuel! ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                  "Add your phone number. we'll send you a otp verification code so we know your 're real ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 17, color: Colors.grey)),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: Lottie.network(
                    'https://assets6.lottiefiles.com/packages/lf20_xy6jshlz.json',
                    height: 250)),
            Container(
              margin: EdgeInsets.only(top: 10),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              child: TextFormField(
                onChanged: (value) {
                  number = value;
                  setState(() {});
                  changestate = true;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    fillColor: Colors.grey,
                    hintText: "Phone Number",
                    suffixIcon: changestate
                        ? Image.network(
                            'https://img.icons8.com/ios-glyphs/20/000000/checked--v2.png',
                            color: Colors.green,
                          )
                        : null,
                    prefixIcon: countrypicker(),
                    prefix: Padding(
                      padding: EdgeInsets.all(4),
                    )),
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: _controller,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
                    primary: Color(0xffc00021),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => OtpControllerScreen(
                            phone: _controller.text,
                            codeDigits: dialCodeDigits,
                          )));
                },
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
