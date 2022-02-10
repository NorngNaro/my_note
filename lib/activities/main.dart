import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_note/activities/my_note.dart';
import 'package:platform_device_id/platform_device_id.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    name: 'MyNote',
    options: FirebaseOptions(
      apiKey: "AIzaSyDt8ZkbQbqStLFPlt4OuxkkpLX54Fg16v0",
      appId: "com.naro.my_note",
      messagingSenderId: "",
      projectId: "naro-my-note",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      title: "My Notes",
    );
  }


}

class SplashScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 2),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => MyNotes())));

    return Scaffold(
      body: Center(
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
  
}


