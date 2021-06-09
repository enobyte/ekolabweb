import 'dart:async';

import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/image_circle.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainMenuState();
  }
}

class _MainMenuState extends State<MainMenu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(Icons.ac_unit),
        backgroundColor: Colors.red,
        title: TextWidget(txt: "Dashboard"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0),
            child: ButtonWidget(
              txt: TextWidget(
                txt: "Komunikasi",
              ),
              height: 0,
              width: 100,
              btnColor: Colors.green,
              onClick: () => {},
              borderRedius: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextWidget(txt: "Eno"),
                      TextWidget(txt: "enoraden@gmail.com")
                    ],
                  ),
                ),
                ImageCircle(false, icProvider, 50),
              ],
            ),
          ),
          IconButton(
              onPressed: () => {}, icon: Icon(Icons.keyboard_arrow_down)),
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.red,
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
