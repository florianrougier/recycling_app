//TODO: Not used for now, use this component in imagePick

import 'dart:io';
import 'package:flutter/material.dart';

class ImageComponent extends StatefulWidget {
  final File imageToPredict;

  ImageComponent({Key key, this.imageToPredict}) : super(key: key);

  File getImageFile() => imageToPredict;

  @override
  _ImageComponentState createState() => _ImageComponentState();
}

class _ImageComponentState extends State<ImageComponent> {
  File _imageToPredict;

  @override
  void initState() {
    _imageToPredict =
        widget.imageToPredict; // Getting the value from the ImageComponent
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return getImage();
  }

  Widget getImage() =>
      _imageToPredict == null ? Text('No image.') : Image.file(_imageToPredict);
}
