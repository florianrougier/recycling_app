import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycling_app/screens/input_screen.dart';
import 'package:recycling_app/utils/constants.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController usernameInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  initState() {
    emailInputController = TextEditingController();
    usernameInputController = TextEditingController();
    pwdInputController = TextEditingController();
    confirmPwdInputController = TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'Password must be longer than 6 characters';
    } else {
      return null;
    }
  }

  String usernameValidator(String value) {
    if (value.length < 6) {
      return 'Username must be longer than 6 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                  child: Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        'Fill in the form below to get started',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailInputController,
                        keyboardType: TextInputType.emailAddress,
                        validator: emailValidator,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Email *',
                          filled: true,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: usernameInputController,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        validator: usernameValidator,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          hintText: 'Username *',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: pwdInputController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: pwdValidator,
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: 'Password *',
                          filled: true,
                          fillColor: Colors.black,
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: confirmPwdInputController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: pwdValidator,
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.black,
                          hintText: 'Confirm Password *',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32.0)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: MaterialButton(
                        minWidth: 200.0,
                        height: 40.0,
                        color: Colors.lightBlue,
                        child: Text('Register',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            if (pwdInputController.text ==
                                confirmPwdInputController.text) {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: emailInputController.text,
                                      password: pwdInputController.text)
                                  .then((currentUser) => Firestore.instance
                                      .collection("users")
                                      .document(currentUser.user.uid)
                                      .setData({
                                        "uid": currentUser.user.uid,
                                        "email": emailInputController.text,
                                      })
                                      .then((result) => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      InputScreen(),
                                                ),
                                                (_) => false),
                                            emailInputController.clear(),
                                            usernameInputController.clear(),
                                            pwdInputController.clear(),
                                            confirmPwdInputController.clear()
                                          })
                                      .catchError((err) => print(err)))
                                  .catchError((err) => print(err));
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("The passwords do not match"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Close"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Text("Already have an account?"),
                    ),
                    FlatButton(
                      child: Text("Login here!"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              )),
            )));
  }
}
