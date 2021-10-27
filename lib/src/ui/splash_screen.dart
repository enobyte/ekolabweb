import 'dart:async';
import 'dart:convert';

import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
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
    final isLogin =
        await SharedPreferencesHelper.checkKey(SharedPreferencesHelper.user);
    if (isLogin) {
      final userPref = await SharedPreferencesHelper.getStringPref(
          SharedPreferencesHelper.user);
      final userData = UserModel.fromJson(json.decode(userPref));
      if (userData.data!.kind != 5) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/main_menu", (route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/main_admin", (route) => false);
      }
    } else {
      Navigator.of(context)
          .pushNamedAndRemoveUntil("/prelogin", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: Center(
          child: Image.asset(
        logo,
        height: MediaQuery.of(context).size.height / 4,
      )),
    ));
  }
}
