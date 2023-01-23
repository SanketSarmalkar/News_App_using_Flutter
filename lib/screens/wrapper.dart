import 'package:flutter/material.dart';
import 'package:news_app/screens/home/home.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import 'authentication/login.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserUid?>(context);
    print(user);
    if(user==null){
      return Login();
    }else{
      return HomePage();
    }
  }
}

