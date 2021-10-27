import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';
import 'responsive_grid.dart';

class ScrollSnapList extends StatefulWidget {
  final List<dynamic> listData;
  final Function(String) id;

  @override
  State<StatefulWidget> createState() {
    return _ScrollSnapListState();
  }

  ScrollSnapList(this.listData, this.id);
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
    return ResponsiveGridList(
        desiredItemWidth: 250,//MediaQuery.of(context).size.width / 3,
        minSpacing: 10,
        children: widget.listData.map((i) {
          return InkWell(
            onTap: () => widget.id(i["id"]),
            onHover: (value) {
              setState(() {});
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                child: Container(
                  width: 250.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0)),
                            child: Image.network(
                              i["data"]["image"],
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    txt: i?["data"]?["name_law"] ?? "",
                                    txtSize: 16.0,
                                    maxLine: 2,
                                    align: TextAlign.left,
                                  ),
                                  TextWidget(
                                    txt: i["data"]?["name"] ?? "",
                                    txtSize: 12.0,
                                    maxLine: 2,
                                    fontFamily: 'Italic',
                                    align: TextAlign.justify,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, bottom: 4, left: 4, right: 4),
                        child: TextWidget(
                            txt: i["data"]["email"], align: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                            txt: i["data"]["phone"] ?? "",
                            align: TextAlign.start),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextWidget(
                          txt: i["data"]["address_corp"] ?? "",
                          align: TextAlign.start,
                        ),
                      ),
                      // Align(
                      //   child: ButtonWidget(
                      //     txt: TextWidget(txt: "Detail"),
                      //     height: 32.0,
                      //     width: MediaQuery.of(context).size.width,
                      //     btnColor: colorBase!,
                      //     onClick: () => widget
                      //         .id(widget.listData[position]["id"]),
                      //     borderRedius: 4,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          );
        }).toList());

    //   GridView.builder(
    //   itemCount: widget.listData.length,
    //   padding: EdgeInsets.only(right: 120, left: 120),
    //   controller: scrollController,
    //   itemBuilder: (context, position) {
    //     return InkWell(
    //       onTap: () => widget.id(widget.listData[position]["id"]),
    //       onHover: (value) {
    //         setState(() {});
    //       },
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Card(
    //           elevation: 4,
    //           child: Container(
    //             width: 250.0,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Row(
    //                   children: [
    //                     ClipRRect(
    //                       borderRadius: BorderRadius.only(
    //                           topLeft: Radius.circular(8.0),
    //                           bottomLeft: Radius.circular(8.0)),
    //                       child: Image.network(
    //                         widget.listData[position]["data"]["image"],
    //                         fit: BoxFit.fill,
    //                         height: 100,
    //                         width: 100,
    //                       ),
    //                     ),
    //                     Expanded(
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(
    //                             horizontal: 8.0, vertical: 8.0),
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             TextWidget(
    //                               txt: widget.listData[position]["data"]
    //                                   ["name"],
    //                               txtSize: 16.0,
    //                               maxLine: 2,
    //                               align: TextAlign.left,
    //                             ),
    //                             TextWidget(
    //                               txt: widget.listData[position]["data"]
    //                                       ?["iumk"] ??
    //                                   "",
    //                               txtSize: 12.0,
    //                               maxLine: 2,
    //                               fontFamily: 'Italic',
    //                               align: TextAlign.justify,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                       top: 16, bottom: 4, left: 4, right: 4),
    //                   child: TextWidget(
    //                       txt: widget.listData[position]["data"]["email"],
    //                       align: TextAlign.start),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(4.0),
    //                   child: TextWidget(
    //                       txt: widget.listData[position]["data"]["phone"] ?? "",
    //                       align: TextAlign.start),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(4.0),
    //                   child: TextWidget(
    //                     txt: widget.listData[position]["data"]
    //                             ["address_corp"] ??
    //                         "",
    //                     align: TextAlign.start,
    //                   ),
    //                 ),
    //                 // Align(
    //                 //   child: ButtonWidget(
    //                 //     txt: TextWidget(txt: "Detail"),
    //                 //     height: 32.0,
    //                 //     width: MediaQuery.of(context).size.width,
    //                 //     btnColor: colorBase!,
    //                 //     onClick: () => widget
    //                 //         .id(widget.listData[position]["id"]),
    //                 //     borderRedius: 4,
    //                 //   ),
    //                 // ),
    //               ],
    //             ),
    //           ),
    //           shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(10.0)),
    //         ),
    //       ),
    //     );
    //   },
    //   gridDelegate:
    //       const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    // );
  }
}
