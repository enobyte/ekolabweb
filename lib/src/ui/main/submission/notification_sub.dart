import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class NotificationSubmission extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return NotificationSubmissionState();
  }

  NotificationSubmission(this.idUser);
}

class NotificationSubmissionState extends State<NotificationSubmission> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: TextWidget(
          txt: "Notifikasi",
        ),
      ),
      body: StreamBuilder<ProductModel>(
          stream: bloc.getSubmissionProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 8.0,
                      margin: EdgeInsets.all(32),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: snapshot.data!.data![index]
                                              ["data"]["name_user_sub"],
                                          style: TextStyle(fontSize: 21),
                                          children: [
                                        WidgetSpan(
                                            child: TextWidget(
                                              txt: " ~ " +
                                                  snapshot.data!.data![index]
                                                      ["data"]["kind"],
                                            ),
                                            alignment:
                                                PlaceholderAlignment.middle)
                                      ])),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  TextWidget(
                                      txt: snapshot.data!.data![index]["data"]
                                          ["comment"])
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 18),
                                child: Icon(
                                  Icons.notifications_active_rounded,
                                  size: 32,
                                  color: Colors.redAccent,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.data!.length,
                );
              } else {
                return Center(child: Image.asset(imgNoData));
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _getData() {
    bloc.getSubmissionRequest({"id_user": widget.idUser});
  }
}
