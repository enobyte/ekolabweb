// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/home_service/licence_list.dart';
import 'package:ekolabweb/src/ui/main/home_service/waralaba_list.dart';
import 'package:ekolabweb/src/ui/main/profile.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/ui/main/submission/notification_sub.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/image_circle.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'home_service/kerjasama_list.dart';
import 'home_service/konsinyasi_list.dart';
import 'home_service/network_list.dart';
import 'home_service/service_product_list.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class MainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainMenuState();
  }
}

class _MainMenuState extends State<MainMenu> {
  String email = "";
  String name = "";
  String idUser = "";

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(32.0),
        child: FloatingActionButton(
          onPressed: () => idUser.isNotEmpty
              ? routeToWidget(context, NotificationSubmission(idUser))
              : null,
          child: Icon(Icons.notification_important_rounded),
          backgroundColor: Colors.blue[700],
        ),
      ),
      appBar: AppBar(
        leading: Image.asset(logo),
        backgroundColor: Colors.blue[700],
        title: TextWidget(txt: "E-KOLAB"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 20.0),
            child: ButtonWidget(
              txt: TextWidget(
                txt: "Komunikasi",
              ),
              height: 0,
              width: 100,
              btnColor: Colors.green,
              onClick: () => {},
              borderRedius: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [TextWidget(txt: name), TextWidget(txt: email)],
                  ),
                ),
                InkWell(
                  child: ImageCircle(false, icProvider, 50),
                  onTap: () => routeToWidget(context, Profile()),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return ["Produk Saya", "Keluar"]
                  .map((e) => PopupMenuItem<String>(
                        value: e,
                        child: TextWidget(
                          txt: e,
                        ),
                      ))
                  .toList();
            },
            onSelected: (value) {
              switch (value) {
                case "Produk Saya":
                  routeToWidget(context, ListProduct(true, "null"));
                  break;
                case "Keluar":
                  _doLogout(context);
                  break;
              }
            },
            icon: Icon(Icons.keyboard_arrow_down),
          )
          // IconButton(
          //     onPressed: () => _paddingPopup(), icon: Icon(Icons.keyboard_arrow_down)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 4,
                  onPageChanged: (index, reason) {
                    setState(() {});
                  }),
            ),
            StreamBuilder<UserMultipleModel>(
                stream: bloc.doGetAllUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        snapshot.data!.data!
                                .any((element) => element!.kind == 3)
                            ? ServiceProductList()
                            : SizedBox(),
                        snapshot.data!.data!
                                .any((element) => element!.kind == 1)
                            ? WaralabaList()
                            : SizedBox(),
                        snapshot.data!.data!
                                .any((element) => element!.kind == 2)
                            ? KonsinyasiList()
                            : SizedBox(),
                        snapshot.data!.data!
                                .any((element) => element!.kind == 4)
                            ? KerjasamaList()
                            : SizedBox(),
                        snapshot.data!.data!
                                .any((element) => element!.kind == 6)
                            ? LicenceList()
                            : SizedBox(),
                        snapshot.data!.data!
                                .any((element) => element!.kind == 7)
                            ? NetworkList()
                            : SizedBox(),
                      ],
                    );
                  } else {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 3),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                })

            // Expanded(
            //   child: ServiceProduct(),
            // )
          ],
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList
      .map((item) => Container(
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(item,
                          fit: BoxFit.cover, width: double.infinity),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ))
      .toList();

  _doLogout(context) {
    SharedPreferencesHelper.clearAllPreference();
    Navigator.pushNamedAndRemoveUntil(context, '/login_menu', (_) => false);
  }

  _getData() async {
    final userPref = await SharedPreferencesHelper.getStringPref(
        SharedPreferencesHelper.user);
    final userData = UserModel.fromJson(json.decode(userPref));
    setState(() {
      email = userData.data!.data!["email"];
      name = userData.data!.data!["name"];
      idUser = userData.data!.id!;
    });
    bloc.fetchAllUser({"id": userData.data!.id});
  }
}
