import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/scroll_snap_list.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class LicenceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LicenceListState();
  }
}

class _LicenceListState extends State<LicenceList>
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
    return Padding(
      padding: const EdgeInsets.only(top: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 120),
              child: RichText(
                  text: TextSpan(
                text: "‍📉 Perijinan",
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
          StreamBuilder<UserMultipleModel>(
              stream: bloc.doGetAllUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<UserDataModel?> listData = snapshot.data!.data!
                      .where((element) => element!.kind == 6)
                      .toList();
                  return ScrollSnapList(
                      listData.map((e) => e!.toJson()).toList(), (id) => routeToWidget(context, ListProduct(false)));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}