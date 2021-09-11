import 'package:countries/SharedPreferences.dart';
import 'package:flutter/material.dart';
import 'Screens/HomePage.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 5,
        navigateAfterSeconds: new HomePage(),
        title: new Text(
          'Countries!',
          style: new TextStyle(
              fontFamily: 'ProximaNova',
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 30.0),
        ),
        image: new Image.asset(
          "assets/icons/icons8-america-100.png",
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        photoSize: 100.0,
        loaderColor: Colors.white);
  }
}
