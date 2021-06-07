import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTime();
  }

  _startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, _navigationPage);
  }

  _navigationPage() async {
    Navigator.of(context).pushReplacementNamed("/login_menu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Colors.blue));
  }
}
