import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:torch_mobile/torch_mobile.dart';

class Brain {
  void init() {
    try {
      TorchMobile.loadModel(
          model: 'assets/model.pt', labels: 'assets/labels.txt');
    } on PlatformException {}
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<String> makePrediction(File file) async {
    String prediction;
    try {
      prediction =
          await TorchMobile.getPrediction(file, maxWidth: 400, maxHeight: 400);
    } on PlatformException {
      prediction = 'Failed to get prediction.';
    }

    return prediction;
  }

  String getInterpretation(String prediction) {
    switch (prediction) {
      case 'glass':
        return 'This is glass';
      case 'cardboard':
        return 'This is cardboard';
      case 'plastic':
        return 'This is plastic';
      case 'metal':
        return 'This is metal';
      case 'paper':
        return 'This is paper';
      default:
        return 'None';
    }
  }
}
