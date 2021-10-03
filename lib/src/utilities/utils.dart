import 'dart:core';
import 'dart:math';

import 'package:ekolabweb/src/bloc/bloc-provider.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<dynamic> routeToWidget(BuildContext context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return BlocProvider(
        bloc: null,
        child: widget,
      );
    }),
  );
}

showErrorMessage(BuildContext context, String title, String? message,
    {bool isDismiss = true}) {
  return showModalBottomSheet(
    context: context,
    elevation: 4,
    isDismissible: isDismiss,
    backgroundColor: Colors.white,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height / 5,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              txt: title,
              fontFamily: 'Bold',
              txtSize: 21,
              align: TextAlign.start,
              color: Colors.black54,
            ),
            TextWidget(
              txt: message ?? "Unknown Error",
              txtSize: 14,
              align: TextAlign.start,
              color: Colors.black54,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: IconButton(
                    icon: Icon(Icons.cancel_outlined),
                    color: Colors.black45,
                    iconSize: 30,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

extension IgnoreCase on String {
  bool equalIgnoreCase(String right) {
    return this.toLowerCase() == right.toLowerCase();
  }
}

String formatDefaultDate(String value, String format) {
  var datetime = DateTime.parse(value);
  return DateFormat(format).format(datetime);
}

Future<String> randomString(int length) async {
  const chars =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < length; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result.toUpperCase();
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

showMessage(BuildContext context, Widget child) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return child;
      });
}
