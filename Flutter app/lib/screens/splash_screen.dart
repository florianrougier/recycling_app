import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycling_app/screens/input_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              // TODO: invert this condition, don't have the disconnect option for now so i decided to login all the time, no cookies
              if (currentUser != null) // ignore: sdk_version_ui_as_code
                // TODO: See why this warning is showing
                {Navigator.pushReplacementNamed(context, "/login")}
              else // ignore: sdk_version_ui_as_code
                {
                  Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .get()
                      .then((DocumentSnapshot result) =>
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InputScreen())))
                      .catchError((err) => print(err))
                }
            })
        .catchError((err) => print(err));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Container(
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 36.0),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          // TODO: Replace with a spinner
          child: Text('Loading...'),
        )
      ],
    ));
  }
}
