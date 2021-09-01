import 'package:ekolabweb/src/bloc/message_bloc.dart';
import 'package:ekolabweb/src/model/standard_maplist_model.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'chating.dart';

class ListChatingForm extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _ListChatingFormState();
  }

  ListChatingForm(this.idUser);
}

class _ListChatingFormState extends State<ListChatingForm> {
  @override
  void initState() {
    super.initState();
    bloc.fetchMessageList({"to": widget.idUser});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "List Message",
        ),
      ),
      body: StreamBuilder<StandardMapListModels>(
          stream: bloc.chatingListBloc,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => routeToWidget(
                          context,
                          ChatingForm(
                              widget.idUser,
                              snapshot.data!.data![index]["data"]["from"],
                              snapshot.data!.data![index]["data"]
                                  ["id_product"])),
                      child: Card(
                          margin: EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextWidget(
                                  txt: snapshot.data!.data![index]["product"]
                                      ["name"],
                                  txtSize: 18,
                                  align: TextAlign.start,
                                ),
                                TextWidget(
                                  txt: snapshot.data!.data![index]["data"]
                                      ["msg"],
                                  align: TextAlign.start,
                                  txtSize: 10,
                                )
                              ],
                            ),
                          )),
                    );
                  },
                  itemCount: snapshot.data?.data?.length ?? 0,
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
