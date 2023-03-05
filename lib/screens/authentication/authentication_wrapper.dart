import 'package:flutter/material.dart';
import 'package:news_app/screens/authentication/login.dart';
import 'package:news_app/screens/authentication/signup.dart';

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  bool k = true;
  void changeK() {
    //print("hell");
    setState(() => k = !k);
  }

  @override
  Widget build(BuildContext context) {
    return (k) ? Login(changeK: changeK) : SignUp(changeK: changeK);
  }
}
