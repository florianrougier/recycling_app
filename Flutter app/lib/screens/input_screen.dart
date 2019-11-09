import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recycling_app/utils/image_pick.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ImagePick(),
          ),
        ],
      ),
    );
  }
}
