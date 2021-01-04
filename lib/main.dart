import 'package:flutter/material.dart';
import 'package:simple_chat_app/screen/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: non_constant_identifier_names
// bool USE_FIRESTORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}
