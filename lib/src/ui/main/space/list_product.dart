import 'dart:convert';

import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/invest_service.dart';
import 'package:ekolabweb/src/ui/main/space/licence_service.dart';
import 'package:ekolabweb/src/ui/main/space/network_organization_service.dart';
import 'package:ekolabweb/src/ui/main/space/waralaba_service.dart';
import 'package:ekolabweb/src/ui/main/submission/jejaring_submission.dart';
import 'package:ekolabweb/src/ui/main/submission/kerjasama_submission.dart';
import 'package:ekolabweb/src/ui/main/submission/konsinyasi_submission.dart';
import 'package:ekolabweb/src/ui/main/submission/perijinan_submission.dart';
import 'package:ekolabweb/src/ui/main/submission/ukm_submission.dart';
import 'package:ekolabweb/src/ui/main/submission/waralaba_submission.dart';
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
  ProductModel? _productModel;

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
          ? FloatingActionButton.extended(
              onPressed: () => _navigationUser(),
              label: TextWidget(
                txt: "Tambah Produk",
              ),
              icon: Icon(Icons.add),
              backgroundColor: colorBase,
            )
          : SizedBox(),
      body: StreamBuilder<ProductModel>(
          stream: bloc.getProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                _productModel = snapshot.data;
                return Wrap(
                  children: snapshot.data!.data!
                      .asMap()
                      .map((i, e) => MapEntry(
                          i,
                          GestureDetector(
                            onTap: () => !widget.isUser
                                ? _navDetailProduct(i, false, e["kind"])
                                : null,
                            child: Container(
                              width: 300,
                              child: Card(
                                margin: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Image.network(
                                        e["data"]["image"] != null
                                            ? e["data"]["image"]
                                            : "http://ekolab.id/file/myproduct_398872551.png",
                                        fit: BoxFit.cover,
                                        height: 300,
                                        width: 300,
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
                                              ? ButtonWidget(
                                                  txt:
                                                      TextWidget(txt: "Detail"),
                                                  height: 40.0,
                                                  width: 100,
                                                  btnColor: colorBase!,
                                                  onClick: () =>
                                                      _navDetailProduct(
                                                          i, true, 0),
                                                  borderRedius: 4,
                                                )
                                              : ButtonWidget(
                                                  txt:
                                                      TextWidget(txt: "Ajukan"),
                                                  height: 40.0,
                                                  width: 100,
                                                  btnColor: colorBase!,
                                                  onClick: () =>
                                                      _actionSubmission(e),
                                                  borderRedius: 4,
                                                ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )))
                      .values
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
        routeToWidget(context, WaralabaService(idUserLogin, null, true));
        break;
      case 2:
        routeToWidget(context, KonsinyorService(idUserLogin, null, true));
        break;
      case 3:
        routeToWidget(context, ProductService(idUserLogin, null, true));
        break;
      case 4:
        routeToWidget(context, InvestService(idUserLogin, null, true));
        break;
      case 6:
        routeToWidget(context, LicenceService(idUserLogin, null, true));
        break;
      case 7:
        routeToWidget(
            context, NetWorkOrganizationService(idUserLogin, null, true));
        break;
      default:
        showErrorMessage(context, "Product", "User Not Authorize");
        break;
    }
  }

  _navDetailProduct(int index, bool isUser, int intKindConsumer) {
    switch (!isUser ? intKindConsumer : kindUser) {
      case 1:
        routeToWidget(context,
            WaralabaService(idUserLogin, _productModel!.data![index], isUser));
        break;
      case 2:
        routeToWidget(context,
            KonsinyorService(idUserLogin, _productModel!.data![index], isUser));
        break;
      case 3:
        routeToWidget(context,
            ProductService(idUserLogin, _productModel!.data![index], isUser));
        break;
      case 4:
        routeToWidget(context,
            InvestService(idUserLogin, _productModel!.data![index], isUser));
        break;
      case 6:
        routeToWidget(context,
            LicenceService(idUserLogin, _productModel!.data![index], isUser));
        break;
      case 7:
        routeToWidget(
            context,
            NetWorkOrganizationService(
                idUserLogin, _productModel!.data![index], isUser));
        break;
      default:
        showErrorMessage(context, "Product", "User Not Authorize");
        break;
    }
  }

  _actionSubmission(Map<String, dynamic> data) {
    switch (data["kind"]) {
      case 1:
        routeToWidget(
            context,
            WaralabaSub(
              data["id"],
              idUserLogin,
              kindUser,
              nameUserLogin,
              data["data"]["description"],
              data["data"]["term"],
            ));
        break;
      case 2:
        routeToWidget(
            context,
            KonsinyasiSubmission(
              data["id"],
              idUserLogin,
              kindUser,
              nameUserLogin,
              data["data"]["description"],
            ));
        break;
      case 3:
        _showMessage(data["id"], data["kind"]);
        break;
      case 4:
        routeToWidget(
            context,
            KerjaSamaSubmission(
              data["id"],
              idUserLogin,
              kindUser,
              nameUserLogin,
              data["data"]["description"],
            ));
        break;
      case 6:
        routeToWidget(
            context,
            PerijinanSubmission(
              data["id"],
              idUserLogin,
              kindUser,
              nameUserLogin,
              data["data"]["description"],
              data["data"]["term"],
            ));
        break;
      case 7:
        routeToWidget(
            context,
            JejaringSubmission(
              data["id"],
              idUserLogin,
              kindUser,
              nameUserLogin,
              data["data"]["description"],
              data["data"]["term"],
            ));
        break;
    }
  }

  _showMessage(String idProduct, int kindProduct) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return UkmSubmission(idProduct, idUserLogin, kindUser, nameUserLogin);
        });
  }
}
