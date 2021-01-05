import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthForm extends StatefulWidget {
  AuthForm( this.submitFn, this.isLoading );

  final bool isLoading;
  final void Function(String email, String pass, String uname, bool isLogin) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPass = '';

  void _doSubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if( isValid ) {
      _formKey.currentState.save();
      widget.submitFn(_userEmail.trim(), _userPass.trim(), _userName.trim(), _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('Email'),
                    validator: (value) {
                      if( value.isEmpty || !value.contains('@') ) {
                        return 'Please Enter Valid Email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email'
                    ),
                    onSaved: (val) {
                      _userEmail = val;
                    },
                  ),
                  if( !_isLogin )
                  TextFormField(
                    key: ValueKey('Username'),
                    validator: (value) {
                      if( value.isEmpty ) {
                        return "Enter Username";
                      }
                      return null;
                    },
                    decoration: InputDecoration( labelText: 'Username'),
                    onSaved: (val) {
                      _userName = val;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('Userpass'),
                    validator: (value) {
                      if( value.isEmpty ) {
                        return 'Enter Password';
                      } else if( value.length < 7 ) {
                        return 'Password Should be at least 7 Character long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration( labelText: 'Password'),
                    obscureText: true,
                    onSaved: (val) {
                      _userPass = val;
                    },
                  ),
                  SizedBox(height: 12,),
                  if(widget.isLoading)
                    CircularProgressIndicator(),
                  if(!widget.isLoading)
                    RaisedButton(
                      child: Text( _isLogin ? 'Sign up': 'Login' ),
                      onPressed: _doSubmit,
                    ),
                  if(!widget.isLoading)
                    FlatButton(
                      child: Text( _isLogin ? 'Login' : 'Sign up' ),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
