// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/about.dart';
import 'package:ekolabweb/src/ui/main/home_service/licence_list.dart';
import 'package:ekolabweb/src/ui/main/home_service/waralaba_list.dart';
import 'package:ekolabweb/src/ui/main/message/listchating.dart';
import 'package:ekolabweb/src/ui/main/profile.dart';
import 'package:ekolabweb/src/ui/main/search_main.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/ui/main/notification/notification_sub.dart';
import 'package:ekolabweb/src/ui/new_password.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/image_circle.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../change_password.dart';
import 'home_service/kerjasama_list.dart';
import 'home_service/konsinyasi_list.dart';
import 'home_service/network_list.dart';
import 'home_service/service_product_list.dart';

final List<String> imgList = [
  'http://ekolab.id/file/thumb_1628684978_banner-web-hari-umkm-01_230555579.png',
  'http://ekolab.id/file/thumb_1623930046_bantua-pemerintah-baner_829741534.jpeg',
  'http://ekolab.id/file/thumb_1623131196_Hoax-455_705879973.jpeg',
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
  String image = "";
  String idUser = "";
  String bussCategory = "";
  String nameCorp = "";
  int kindUser = 0;
  bool _isLoading = true;
  late Widget _child;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    //_child = ListProduct(true, "null");
    _getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _child = ServiceProductList(() => _handleDrawer());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: [
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.only(bottom: 24),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ImageCircle(true, image, 80),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //TextWidget(txt: dataKind(kindUser), txtSize: 18),
                          TextWidget(
                            txt: nameCorp,
                            fontFamily: 'Bold',
                            txtSize: 18,
                          ),
                          TextWidget(txt: bussCategory, txtSize: 18),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // InkWell(
            //   onTap: () => _onClickMenu(0),
            //   onHover: (value) {
            //     setState(() {});
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(4)),
            //         color: Colors.white),
            //     margin: const EdgeInsets.symmetric(vertical: 12),
            //     width: double.infinity,
            //     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            //     child: TextWidget(
            //       txt: "Produk Saya",
            //       fontFamily: 'Bold',
            //       txtSize: 24,
            //       align: TextAlign.start,
            //     ),
            //   ),
            // ),
            InkWell(
              onTap: () {
                _onClickMenu(1);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icUkm,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "UKM/UMK",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _onClickMenu(2);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icPewaralaba,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "Pewaralaba",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _onClickMenu(3);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icKonsinyor,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "Konsinyor",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _onClickMenu(4);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icKerjasama,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "Kerjasama",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _onClickMenu(5);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icPersetujuan,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "Perizinan",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _onClickMenu(6);
                _handleCloseDrawer();
              },
              onHover: (value) {
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Image.asset(
                      icJejaring,
                      height: 25,
                    ),
                    SizedBox(width: 6),
                    TextWidget(
                      txt: "‍‍Jejaring",
                      fontFamily: 'Regular',
                      txtSize: 24,
                      align: TextAlign.start,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40),
          child: FloatingActionButton.extended(
            onPressed: () => idUser.isNotEmpty
                ? routeToWidget(
                    context, NotificationSubmission(idUser, kindUser))
                : Container(),
            icon: Icon(Icons.notification_important_rounded),
            label: TextWidget(
              txt: "Notifikasi",
            ),
            backgroundColor: Colors.blue[700],
          ),
        ),
        appBar: AppBar(
          leading: Image.asset(logo),
          elevation: 0.0,
          backgroundColor: Colors.blue[700],
          title: TextWidget(txt: "E-KOLAB"),
          centerTitle: false,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, bottom: 12.0, right: 20.0),
              child: ButtonWidget(
                txt: TextWidget(
                  txt: "Chat",
                  fontFamily: 'Bold',
                ),
                height: 0,
                width: 60,
                btnColor: Colors.green,
                onClick: () => routeToWidget(context, ListChatingForm(idUser)),
                borderRedius: 15,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextWidget(
                        txt: name,
                        txtSize: 12,
                      ),
                      TextWidget(
                        txt: email,
                        txtSize: 12,
                      ),
                      Container(
                        child: TextWidget(
                          txt: dataKind(kindUser),
                          txtSize: 10,
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green),
                      )
                    ],
                  ),
                ),
                InkWell(
                  child: ImageCircle(true, image, 50),
                  onTap: () => routeToWidget(context, Profile()),
                ),
              ],
            ),
            PopupMenuButton<String>(
              itemBuilder: (context) {
                return ["Profil", "Produk Saya", "Ganti Password", "Pencarian", "Keluar"]
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
                  case "Profil":
                    routeToWidget(context, Profile());
                    break;
                  case "Produk Saya":
                    routeToWidget(context, ListProduct(true, "null"));
                    break;
                  case "Ganti Password":
                    routeToWidget(context, ChangePassword(idUser));
                    break;
                  case "Pencarian":
                    showSearch(context: context, delegate: SearchMain(idUser));
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
        body: _child);
  }

  _onClickMenu(int idx) {
    switch (idx) {
      case 0:
        _child = ListProduct(true, "null");
        break;
      case 1:
        _child = ServiceProductList(() => _handleDrawer());
        break;
      case 2:
        _child = WaralabaList(() => _handleDrawer());
        break;
      case 3:
        _child = KonsinyasiList(() => _handleDrawer());
        break;
      case 4:
        _child = KerjasamaList(() => _handleDrawer());
        break;
      case 5:
        _child = LicenceList(() => _handleDrawer());
        break;
      case 6:
        _child = NetworkList(() => _handleDrawer());
        break;
    }
    setState(() {});
  }

  _doLogout(context) {
    SharedPreferencesHelper.clearAllPreference();
    Navigator.pushNamedAndRemoveUntil(context, '/prelogin', (_) => false);
  }

  _getData() async {
    final userPref = await SharedPreferencesHelper.getStringPref(
        SharedPreferencesHelper.user);
    final userData = UserModel.fromJson(json.decode(userPref));
    setState(() {
      email = userData.data!.data!["email"];
      name = userData.data!.data!["name"];
      bussCategory = userData.data!.data?["buss_category"] ?? "";
      nameCorp = userData.data!.data?["name_law"] ?? "";
      image = userData.data!.data!["image"];
      idUser = userData.data!.id!;
      kindUser = userData.data!.kind!;
    });
    bloc.fetchAllUser({"id": idUser});
  }

  _handleDrawer() {
    _key.currentState!.openDrawer();
    setState(() {});
  }

  _handleCloseDrawer() {
    Navigator.of(context).pop();
  }
}
