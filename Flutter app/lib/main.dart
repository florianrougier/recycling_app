import 'package:flutter/material.dart';

import 'utils/extractor.dart';

import 'package:recycling_app/screens/splash_screen.dart';
import 'package:recycling_app/screens/register_screen.dart';
import 'package:recycling_app/screens/login_screen.dart';
import 'package:recycling_app/screens/input_screen.dart';
import 'package:recycling_app/screens/prediction_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Provide a function to handle named routes. Use this function to
      // identify the named route being pushed, and create the correct
      // Screen.
      // ignore: missing_return
      onGenerateRoute: (settings) {
        // If you push the PassArguments route
        if (settings.name == '/predict') {
          // Cast the arguments to the correct type: ScreenArguments.
          final ScreenArguments args = settings.arguments;

          // Then, extract the required data from the arguments and
          // pass the data to the correct screen.
          return MaterialPageRoute(
            builder: (context) {
              return PredictionScreen(
                imageDisplay: args.imageFile,
                imageClass: args.imageClass,
                interpretation: args.interpretation,
              );
            },
          );
        }
      },
      title: 'Reycling App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/input': (context) => InputScreen(),
        '/extractArguments': (context) => ExtractArgumentsScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
