import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recycling_app/components/bottom_button.dart';
import 'package:recycling_app/utils/extractor.dart';
import 'package:recycling_app/utils/brain.dart';
import 'package:recycling_app/components/round_icon_button.dart';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePick> {
  File imageToPredict;
  String _prediction = 'None';

  Brain brain = Brain();

  @override
  void initState() {
    brain.init();
    super.initState();
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    var prediction = await brain.makePrediction(image);

    setState(() {
      imageToPredict = image;
      _prediction = prediction;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    var prediction = await brain.makePrediction(image);

    setState(() {
      imageToPredict = image;
      _prediction = prediction;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: imageToPredict == null
                  ? Text('No image selected.')
                  : Image.file(imageToPredict),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RoundIconButton(
                icon: Icons.photo_library,
                onPressed: getImageFromGallery,
              ),
              RoundIconButton(
                icon: Icons.add_a_photo,
                onPressed: getImageFromCamera,
              ),
            ],
          ),
        ),
        Visibility(
          visible: this.imageToPredict == null ? false : true,
          child: BottomButton(
            buttonTitle: 'Predict',
            onTap: () {
              Navigator.pushNamed(
                context,
                '/predict',
                arguments: ScreenArguments(
                  imageFile: this.imageToPredict,
                  imageClass: _prediction,
                  interpretation: brain.getInterpretation(_prediction),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
