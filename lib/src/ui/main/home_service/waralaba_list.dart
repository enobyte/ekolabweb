import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/scroll_snap_list.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class WaralabaList extends StatefulWidget {
  final Function onClickMenu;
  @override
  State<StatefulWidget> createState() {
    return _WaralabaListState();
  }

  WaralabaList(this.onClickMenu);
}

class _WaralabaListState extends State<WaralabaList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: colorBase,
          title: TextWidget(
            txt: "PEWARALABA",
          ),
          leading: IconButton(
              onPressed: () => widget.onClickMenu(),
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ),
      body: StreamBuilder<UserMultipleModel>(
          stream: bloc.doGetAllUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<UserDataModel?> listData = snapshot.data!.data!
                  .where((element) => element!.kind == 1)
                  .toList();
              return ScrollSnapList(
                  listData.map((e) => e!.toJson()).toList(),
                      (id) => routeToWidget(context, ListProduct(false, id)));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
    );
  }
}
