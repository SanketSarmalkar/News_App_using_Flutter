import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/email_info_controller.dart';
import 'package:news_app/screens/authentication/authentication_wrapper.dart';
import 'package:news_app/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../models/user.dart';
// ignore: unused_import
import 'authentication/login.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  EmailInfoController emailInfoController = Get.put(EmailInfoController());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);
    //print(user);
    if (user != null && FirebaseAuth.instance.currentUser!.emailVerified) {
      return HomePage();
    } else {
      return const AuthenticationWrapper();
    }
  }
}
