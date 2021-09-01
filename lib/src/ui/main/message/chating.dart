import 'package:ekolabweb/src/bloc/message_bloc.dart';
import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ChatingForm extends StatefulWidget {
  final String idUser, idResponder, idProduct;

  @override
  State<StatefulWidget> createState() {
    return ChatingFormState();
  }

  ChatingForm(this.idUser, this.idResponder, this.idProduct);
}

class ChatingFormState extends State<ChatingForm>
    with TickerProviderStateMixin {
  final _messageController = TextEditingController();
  String messageId = "";
  late StandardMapListModels listMessaging =
      StandardMapListModels("", false, [], 0);
  late AnimationController _controller;
  static const List<IconData> icons = const [Icons.file_copy, Icons.image];

  @override
  void initState() {
    super.initState();
    bloc.fetchMessage({
      "from": widget.idUser,
      "to": widget.idResponder,
      "id_product": widget.idProduct
    });
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: TextWidget(txt: "Komunikasi")),
      body: Stack(
        fit: StackFit.expand,
        children: [
          StreamBuilder<StandardMapListModels>(
              stream: bloc.chatingBloc,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.data!.length > 0) {
                    messageId = snapshot.data!.data!.first["id"];
                    listMessaging.data!.addAll(snapshot.data!.data!);
                    listMessaging.data!
                      ..sort((a, b) =>
                          b["data"]['date'].compareTo(a["data"]['date']));
                  }
                }
                return Container(
                  margin: EdgeInsets.only(bottom: 80),
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                        left: 20, top: 20, right: 20, bottom: 0),
                    reverse: true,
                    itemBuilder: (context, index) {
                      return listMessaging.data?[index]["data"]['from'] ==
                              widget.idUser
                          ? Align(
                              alignment: FractionalOffset.centerRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        (MediaQuery.of(context).size.width ~/
                                                1.5)
                                            .toDouble(),
                                    minWidth: 10),
                                child: Container(
                                  margin: EdgeInsets.all(8),
                                  padding: EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)),
                                        child: listMessaging.data![index]
                                                    ["data"]['doc']
                                                .toString()
                                                .isNotEmpty
                                            ? listMessaging.data![index]["data"]
                                                        ["type"] ==
                                                    "image"
                                                ? Image.network(
                                                    listMessaging.data![index]
                                                        ["data"]['doc'],
                                                    fit: BoxFit.cover,
                                                    height:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width ~/
                                                                2.5)
                                                            .toDouble(),
                                                  )
                                                : listMessaging.data![index]
                                                            ["data"]["type"] ==
                                                        "doc"
                                                    ? Card(
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Icon(
                                                                  Icons.book,
                                                                  color: Colors
                                                                      .cyan),
                                                            ),
                                                            Expanded(
                                                              child: TextWidget(
                                                                align: TextAlign
                                                                    .start,
                                                                txt: listMessaging
                                                                    .data![
                                                                        index]
                                                                        ["data"]
                                                                        ['doc']
                                                                    .toString()
                                                                    .split("/")
                                                                    .last,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox()
                                            : SizedBox(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 4, right: 8),
                                        child: TextWidget(
                                          txt: listMessaging.data![index]
                                              ["data"]['msg'],
                                          align: TextAlign.justify,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 4, bottom: 4),
                                        child: Container(
                                          alignment:
                                              FractionalOffset.bottomRight,
                                          child: TextWidget(
                                            txt: formatDefaultDate(
                                                listMessaging.data![index]
                                                    ["data"]['date'],
                                                'dd MMM yyyy hh:mm'),
                                            txtSize: 8,
                                            fontFamily: 'Light',
                                          ),
                                          padding: EdgeInsets.only(right: 4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Align(
                              alignment: FractionalOffset.centerLeft,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        (MediaQuery.of(context).size.width ~/
                                                1.5)
                                            .toDouble(),
                                    minWidth: 80),
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[350],
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8)),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      TextWidget(
                                        txt: listMessaging.data![index]["data"]
                                            ['msg'],
                                        align: TextAlign.justify,
                                      ),
                                      Container(
                                        alignment: FractionalOffset.bottomRight,
                                        child: TextWidget(
                                          txt: formatDefaultDate(
                                              listMessaging.data![index]["data"]
                                                  ['date'],
                                              'dd MMM yyyy hh:mm'),
                                          txtSize: 8,
                                          fontFamily: 'Light',
                                        ),
                                        padding: EdgeInsets.only(left: 4),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                    shrinkWrap: true,
                    itemCount: listMessaging.data?.length ?? 0,
                  ),
                );
              }),
          Positioned(
            bottom: 0,
            right: 10,
            left: 10,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Column(
                  //   children: List.generate(icons.length, (index) {
                  //     Widget child = Container(
                  //       height: 50.0,
                  //       width: 50.0,
                  //       alignment: FractionalOffset.topCenter,
                  //       child: ScaleTransition(
                  //         scale: new CurvedAnimation(
                  //           parent: _controller,
                  //           curve: new Interval(
                  //               0.0, 1.0 - index / icons.length / 2.0,
                  //               curve: Curves.easeOut),
                  //         ),
                  //         child: new FloatingActionButton(
                  //           heroTag: null,
                  //           backgroundColor: Colors.transparent,
                  //           splashColor: Colors.white,
                  //           hoverColor: Colors.white,
                  //           focusColor: Colors.white,
                  //           foregroundColor: Colors.white,
                  //           hoverElevation: 0.0,
                  //           highlightElevation: 0.0,
                  //           autofocus: false,
                  //           elevation: 0.0,
                  //           mini: true,
                  //           child: new Icon(
                  //             icons[index],
                  //             color: Colors.red,
                  //             size: 30,
                  //           ),
                  //           onPressed: () {
                  //             _controller.reset();
                  //             switch (index) {
                  //               case 0:
                  //                 //_getDocuments();
                  //                 break;
                  //               case 1:
                  //                 //_getImages();
                  //                 break;
                  //             }
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //     return child;
                  //   }).toList()
                  //     ..add(
                  //       SizedBox(
                  //         width: 50,
                  //         height: 50,
                  //         child: FloatingActionButton(
                  //           backgroundColor: Colors.white,
                  //           elevation: 0.0,
                  //           heroTag: null,
                  //           onPressed: () {
                  //             if (_controller.isDismissed) {
                  //               _controller.forward();
                  //             } else {
                  //               _controller.reverse();
                  //             }
                  //           },
                  //           child: AnimatedBuilder(
                  //             animation: _controller,
                  //             builder: (BuildContext context, Widget? child) {
                  //               return Transform(
                  //                 transform: new Matrix4.rotationZ(
                  //                     _controller.value * 0.5 * math.pi),
                  //                 alignment: FractionalOffset.center,
                  //                 child: new Icon(
                  //                   _controller.isDismissed
                  //                       ? Icons.attachment
                  //                       : Icons.close,
                  //                   size: 40,
                  //                   color: Colors.black45,
                  //                 ),
                  //               );
                  //             },
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  // ),
                  Expanded(
                    child: StreamBuilder<bool>(
                        stream: bloc.saveChatingBloc,
                        builder: (context, snapshot) {
                          // if (snapshot.hasError) {
                          //   showErrorMessage(
                          //       context, "Message", snapshot.error.toString());
                          // }
                          return Container(
                            padding: EdgeInsets.only(
                                bottom: 0.0, left: 0.0, right: 0.0, top: 12),
                            child: TextFieldWidget(_messageController,
                                keyboardType: TextInputType.text,
                                fillColor: Colors.white,
                                suffixIcon: snapshot.data ?? false
                                    ? Container(
                                        alignment: FractionalOffset.centerRight,
                                        padding: EdgeInsets.only(right: 20),
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.black45),
                                          ),
                                        ),
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.send_rounded),
                                        color: Colors.black45,
                                        onPressed: () => _saveMessage())),
                          );
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _saveMessage() async {
    if (messageId.isEmpty) {
      messageId = await randomString(8);
    }

    var req = {
      "id": messageId,
      "data": {
        "from": widget.idUser,
        "to": widget.idResponder,
        "msg": _messageController.text,
        "date": DateTime.now().toString(),
        "type": "text",
        "id_product": widget.idProduct
      }
    };
    bloc.saveMessage(req);
    _listenSaveMessage(req);
  }

  _listenSaveMessage(Map<String, dynamic> data) {
    bloc.saveChatingBloc.listen((event) {
      if (!event) {
        bloc.getMessageSave(data);
        _messageController.clear();
      }
    });
  }
}
