import 'package:ekolabweb/src/model/service_list_model.dart';
import 'package:ekolabweb/src/widget/scroll_snap_list.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class KonsinyasiList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _KonsinyasiListState();
  }
}

class _KonsinyasiListState extends State<KonsinyasiList>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  var cardIndex = 0;

  var cardsList = [
    ServiceList("Personal", Icons.account_circle, 9, 0.83),
    ServiceList("Work", Icons.work, 12, 0.24),
    ServiceList("Home", Icons.home, 7, 0.32),
    ServiceList("Home2", Icons.home, 7, 0.32),
    ServiceList("Home3", Icons.home, 7, 0.32),
    ServiceList("Home4", Icons.home, 7, 0.32),
  ];

  var currentColor = Color.fromRGBO(231, 129, 109, 1.0);

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    animationController.dispose();
    super.dispose();
  }

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
                text: "🤝 Konsinyasi",
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
              "name": "Produk Kecantikan",
              "image":
                  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
            },
            {
              "name": "Produk Kesehatan",
              "image":
                  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
            },
            {
              "name": "Produk Kebugaran",
              "image":
                  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
            },
            {
              "name": "Waralaba Keimanan",
              "image":
                  "https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80"
            }
          ]),
        ],
      ),
    );
  }
}
