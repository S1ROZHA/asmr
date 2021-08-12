import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:asmr/screens/AsmrHome.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      body: Container(
          color: Color.fromRGBO(90, 30, 163, 1.0),
            child: Column(
              children: [
                Spacer(),
                Text(
                  "WELCOME TO",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 2,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "ASMR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1,
                    fontSize: 130,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  "Freedom talk any person of your \nmother language.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Spacer(flex: 3),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: MaterialButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AsmrHome(),
                        ),
                      ),
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0, // insert your font size here
                        ),
                      ),
                      minWidth: 20.0,
                      height: 45.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}