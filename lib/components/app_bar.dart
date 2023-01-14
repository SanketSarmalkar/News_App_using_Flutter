import 'package:flutter/material.dart';

class AppBarMode extends StatefulWidget with PreferredSizeWidget {
  final String title;
  AppBarMode({Key? key, required this.title}) : super(key: key);

  @override
  State<AppBarMode> createState() => _AppBarModeState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarModeState extends State<AppBarMode> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue[900],
      title: Text(
        widget.title,
        style: TextStyle(
          color: Colors.blue[300],
          fontFamily: 'avenir',
          fontSize: 40,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
