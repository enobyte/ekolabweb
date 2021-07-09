import 'dart:convert';

import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/invest_service.dart';
import 'package:ekolabweb/src/ui/main/space/licence_service.dart';
import 'package:ekolabweb/src/ui/main/space/network_organization_service.dart';
import 'package:ekolabweb/src/ui/main/space/waralaba_service.dart';
import 'package:ekolabweb/src/ui/main/submission/ukm_submission.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'konsinyor_service.dart';
import 'product_service.dart';

class ListProduct extends StatefulWidget {
  final bool isUser;
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _ListProductState();
  }

  ListProduct(this.isUser, this.idUser);
}

class _ListProductState extends State<ListProduct> {
  int kindUser = 0;
  String idUserLogin = "";
  String nameUserLogin = "";

  @override
  void initState() {
    super.initState();
    _getDataUser();
    bloc.submissionProduct.listen((event) {
      showErrorMessage(context, "Submission", event.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorBase,
        title: TextWidget(
          txt: "List Product",
        ),
      ),
      floatingActionButton: widget.isUser && kindUser != 0
          ? FloatingActionButton(
              onPressed: () => _navigationUser(),
              child: Icon(Icons.add),
              backgroundColor: colorBase,
            )
          : SizedBox(),
      body: StreamBuilder<ProductModel>(
          stream: bloc.getProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                return Wrap(
                  children: snapshot.data!.data!
                      .map((e) => Container(
                            height: 300,
                            width: 300,
                            child: Card(
                              margin: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    child: Image.asset(
                                      myProduct,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    child: TextWidget(
                                      txt: e["data"]["name"],
                                      maxLine: 2,
                                      txtSize: 18,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    padding: EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          txt: "🤝 0",
                                          txtSize: 16,
                                        ),
                                        widget.isUser
                                            ? SizedBox()
                                            : ButtonWidget(
                                                txt: TextWidget(txt: "Ajukan"),
                                                height: 40.0,
                                                width: 100,
                                                btnColor: colorBase!,
                                                onClick: () => _showMessage(
                                                    e["id"], e["kind"]),
                                                borderRedius: 4,
                                              ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                );
              } else {
                return Center(child: Image.asset(imgNoData));
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  _getDataUser() async {
    final userPref = await SharedPreferencesHelper.getStringPref(
        SharedPreferencesHelper.user);
    final userData = UserModel.fromJson(json.decode(userPref));
    await bloc.getProductList(
        {"id_user": widget.isUser ? userData.data!.id! : widget.idUser});
    setState(() {
      kindUser = userData.data!.kind!;
      idUserLogin = userData.data!.id!;
      nameUserLogin = userData.data!.data!["name"];
    });
  }

  _navigationUser() {
    switch (kindUser) {
      case 1:
        routeToWidget(context, WaralabaService(idUserLogin));
        break;
      case 2:
        routeToWidget(context, KonsinyorService(idUserLogin));
        break;
      case 3:
        routeToWidget(context, ProductService(idUserLogin));
        break;
      case 4:
        routeToWidget(context, InvestService(idUserLogin));
        break;
      case 6:
        routeToWidget(context, LicenceService(idUserLogin));
        break;
      case 7:
        routeToWidget(context, NetWorkOrganizationService(idUserLogin));
        break;
      default:
        showErrorMessage(context, "Product", "User Not Authorize");
        break;
    }
  }

  _showMessage(String idProduct, int kindProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return kindProduct == 1
              ? Container()
              : UkmSubmission(
                  idProduct, idUserLogin, dataKind(kindUser), nameUserLogin);
        });
  }
}
