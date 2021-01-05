import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  void _doAuthorization (String email, String userPass, String userName, bool islogin) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: userPass);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: userPass);
      }

      await FirebaseFirestore.instance.collection('users').doc(userCredential.user.uid).set({
        'username': userName,
        'email': email
      });
    } on PlatformException catch ( e ) {
      var message = "An error occured while login";
      if( e.message != null ) {
        message = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch ( e ) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_doAuthorization, _isLoading),
    );
  }
}
