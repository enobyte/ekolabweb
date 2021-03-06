import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/service_list_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/scroll_snap_list.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class KonsinyasiList extends StatefulWidget {
  final Function onClickMenu;

  @override
  State<StatefulWidget> createState() {
    return _KonsinyasiListState();
  }

  KonsinyasiList(this.onClickMenu);
}

class _KonsinyasiListState extends State<KonsinyasiList>
    with TickerProviderStateMixin {
  ScrollController? scrollController;
  late AnimationController animationController;
  late CurvedAnimation curvedAnimation;
  var cardIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: colorBase,
        title: TextWidget(
          txt: "KONSINYOR",
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
                  .where((element) => element!.kind == 2)
                  .toList();
              return ScrollSnapList(listData.map((e) => e!.toJson()).toList(),
                  (id) => routeToWidget(context, ListProduct(false, id)));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
