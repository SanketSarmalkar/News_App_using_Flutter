import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_app/init/app_route.dart';
import 'package:news_app/models/user.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:news_app/services/auth.dart';
import 'package:provider/provider.dart';

//    ./gradlew signingReport

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open the box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
  // ignore: no_leading_underscores_for_local_identifiers
  final _myBox = Hive.box("mybox");
  if (_myBox.get("Theme") != null) _myBox.put("Theme", "light");
  if (_myBox.get("Country") != null) _myBox.put("Country", "in");
  //print(_myBox.get("Theme"));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final ThemeData _darkTheme = ThemeData(
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    if (FirebaseAuth.instance.currentUser == null) {
      GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      FirebaseAuth.instance.signOut();
    }
    super.initState();
  }

  //final _myBox = Hive.box('myBox');
  // //write data
  // void writeData() {
  //   //_myBox.put(1,'sanket');
  //   _myBox.put(4, 'mohan');
  //   print(_myBox.get(1));
  //   print(_myBox.values);
  // }

  // //read Data
  // void readData() {
  //   print(_myBox.get(1));
  // }

  @override
  Widget build(BuildContext context) {
    //if(FirebaseAuth.instance.currentUser!.uid==null)AuthService().signOut();
    return StreamProvider<UserUid?>.value(
      value: AuthService().user,
      initialData: null,
      builder: (context, snapshot) {
        return GetMaterialApp(
          // theme: _lightTheme,
          // darkTheme: _darkTheme,
          // themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initial,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
