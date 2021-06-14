import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class ScrollSnapList extends StatefulWidget {
  final List<dynamic> listData;

  @override
  State<StatefulWidget> createState() {
    return _ScrollSnapListState();
  }

  ScrollSnapList(this.listData);
}

class _ScrollSnapListState extends State<ScrollSnapList>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  var cardIndex = 0;

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
    return Container(
      height: 350.0,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.listData.length,
        padding: EdgeInsets.only(right: 120, left: 120),
        shrinkWrap: true,
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, position) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Container(
                  width: 250.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                        child: Image.network(
                          widget.listData[position]["image"],
                          fit: BoxFit.fitHeight,
                          height: 250,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: TextWidget(
                                txt: widget.listData[position]["name"],
                                txtSize: 16.0,
                                maxLine: 2,
                                align: TextAlign.justify,
                              ),
                            ),
                            Align(
                              child: ButtonWidget(
                                txt: TextWidget(txt: "Detail"),
                                height: 32.0,
                                width: MediaQuery.of(context).size.width,
                                btnColor: Colors.redAccent,
                                onClick: () => {},
                                borderRedius: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            onHorizontalDragEnd: (details) {
              animationController = AnimationController(
                  vsync: this, duration: Duration(milliseconds: 500));
              curvedAnimation = CurvedAnimation(
                  parent: animationController, curve: Curves.fastOutSlowIn);

              if (details.velocity.pixelsPerSecond.dx > 0) {
                if (cardIndex > 0) {
                  cardIndex--;
                }
              } else {
                if (cardIndex < widget.listData.length) {
                  cardIndex++;
                }
              }
              setState(() {
                scrollController?.animateTo((cardIndex) * 256.0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn);
              });

              animationController.forward();
            },
          );
        },
      ),
    );
  }
}
