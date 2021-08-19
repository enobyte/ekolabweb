import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/model/submisson_proc_model.dart';
import 'package:ekolabweb/src/ui/main/notification/detail_response_notif.dart';
import 'package:ekolabweb/src/ui/main/submission/process_sub/submission_proc.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class NotificationSubmission extends StatefulWidget {
  final String idUser;
  final int kindUser;

  @override
  State<StatefulWidget> createState() {
    return NotificationSubmissionState();
  }

  NotificationSubmission(this.idUser, this.kindUser);
}

class NotificationSubmissionState extends State<NotificationSubmission> {
  @override
  void initState() {
    super.initState();
    _getData();
    _getSubmissionProc();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.blue[700],
            title: TextWidget(
              txt: "Notifikasi",
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Permintaan Kerjasama"),
                Tab(text: "Respon Kerjasama"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StreamBuilder<SubmissionModel>(
                  stream: bloc.getSubmissionProduct,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.data!.isNotEmpty) {
                        return _requestSubmissionView(snapshot);
                      } else {
                        return Center(child: Image.asset(imgNoData));
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              StreamBuilder<SubmissionProcModel>(
                stream: bloc.getSubmissionProcess,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.data!.isNotEmpty) {
                      return _responseProcessView(snapshot);
                    } else {
                      return Center(child: Image.asset(imgNoData));
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              )
            ],
          )),
    );
  }

  // _onClick(int kind, SubmissionModel data, int indexSub) {
  //   switch (kind) {
  //     case 1:
  //       routeToWidget(context, SubmissionProcess(data, indexSub));
  //       break;
  //     default:
  //       showErrorMessage(context, "Notification", "User Not Authorize");
  //       break;
  //   }
  // }

  Widget _requestSubmissionView(AsyncSnapshot<SubmissionModel> snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => routeToWidget(
              context,
              SubmissionProcess(snapshot.data!, index,
                  snapshot.data!.data![index]["data"]["id_user_sub"])),
          child: Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                                text: snapshot.data!.data![index]["data"]
                                    ["name_user_sub"],
                                style: TextStyle(fontSize: 21),
                                children: [
                              WidgetSpan(
                                  child: TextWidget(
                                    txt: " ~ " +
                                        dataKind(snapshot.data!.data![index]
                                            ["data"]["kind"]),
                                  ),
                                  alignment: PlaceholderAlignment.middle)
                            ])),
                        SizedBox(
                          height: 8,
                        ),
                        TextWidget(
                            txt: snapshot.data!.data![index]["data"]
                                ["submission"]["note"])
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 32,
                        color: colorBase,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: snapshot.data!.data!.length,
    );
  }

  Widget _responseProcessView(AsyncSnapshot<SubmissionProcModel> snapshot) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _detailProcessSubmission(snapshot.data!, index),
          child: Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 10),
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
                                text: snapshot.data!.data![index]["product"]
                                    ["name"],
                                style: TextStyle(fontSize: 21),
                                children: [
                              // WidgetSpan(
                              //     child: TextWidget(
                              //       txt: " ~ " +
                              //           dataKind(snapshot.data!.data![index]
                              //           ["data"]["kind"]),
                              //     ),
                              //     alignment: PlaceholderAlignment.middle)
                            ])),
                        SizedBox(
                          height: 8,
                        ),
                        TextWidget(
                            txt: snapshot
                                .data!.data![index]["response"]["status"]
                                .toString()
                                .toUpperCase())
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 32,
                        color: colorBase,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
      itemCount: snapshot.data!.data!.length,
    );
  }

  _getData() {
    bloc.getSubmissionRequest({"id_user": widget.idUser});
  }

  _getSubmissionProc() {
    bloc.getSubmissionProc({"id_user": widget.idUser});
  }

  _detailProcessSubmission(SubmissionProcModel snapshot, int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DetailResponseNotif(
              snapshot.data![index]["product"]["name"],
              snapshot.data![index]["product"]["description"],
              snapshot.data![index]["response"]["status"]);
        });
  }
}
