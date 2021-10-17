import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutState();
  }
}

class AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Tentang",
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: TextWidget(txt: about),
      ),
    );
  }
}
