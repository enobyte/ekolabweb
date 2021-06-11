import 'package:ekolabweb/src/widget/scroll_snap_list.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class WaralabaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WaralabaListState();
  }
}

class _WaralabaListState extends State<WaralabaList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 120),
              child: RichText(
                  text: TextSpan(
                text: "🛍 Waralaba",
                style: TextStyle(fontSize: 21),
                children: [
                  WidgetSpan(
                      child: TextWidget(
                        txt: "  Lihat Semua",
                        color: Colors.red,
                      ),
                      alignment: PlaceholderAlignment.middle)
                ],
              ))),
          ScrollSnapList([
            {
              "name": "Waralaba Kosmetik",
              "image":
                  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
            }
          ]),
        ],
      ),
    );
  }
}
