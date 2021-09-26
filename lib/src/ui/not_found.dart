import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class NotFound extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotFoundState();
  }
}

class NotFoundState extends State<NotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: TextWidget(
            txt: "Not found",
          ),
        ),
      ),
    );
  }
}
