// This file is used to extracted arguments to a named route
// => Send an image, a prediction, a confidence score and an interpretation to
// the prediction screen
import 'dart:io';
import 'package:flutter/material.dart';

// You can pass any object to the arguments parameter. In this example,
// create a class that contains both a customizable title and message.
class ScreenArguments {
  final File imageFile;
  final String imageClass;
  final String interpretation;

  ScreenArguments(
      {@required this.imageFile,
      @required this.imageClass,
      @required this.interpretation});
}

// A widget that extracts the necessary arguments from the ModalRoute.
class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Image.file(args.imageFile),
          Text(args.imageClass),
          Text(args.interpretation),
        ],
      ),
    );
  }
}
