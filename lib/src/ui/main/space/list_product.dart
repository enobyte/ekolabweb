import 'dart:convert';

import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/product_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/space/waralaba.dart';
import 'package:ekolabweb/src/ui/main/submission/ukm_submission.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.red,
        title: TextWidget(
          txt: "List Product",
        ),
      ),
      floatingActionButton: widget.isUser && kindUser != 0
          ? FloatingActionButton(
              onPressed: () => _navigationUser(),
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            )
          : SizedBox(),
      body: StreamBuilder<ProductModel>(
          stream: bloc.getProduct,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.data!.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 200,
                      child: Card(
                        margin: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
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
                                txt: snapshot.data!.data![index]["data"]
                                    ["name"],
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
                                          btnColor: Colors.redAccent,
                                          onClick: () => _showMessage(
                                              snapshot.data!.data![index]["id"],
                                              snapshot.data!.data![index]
                                                  ["kind"]),
                                          borderRedius: 4,
                                        ),
                                ],
                              ),
                            )
                          ],
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
        routeToWidget(context, Waralaba());
        break;
      case 3:
        routeToWidget(context, ProductService(idUserLogin));
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
