// ignore: import_of_legacy_library_into_null_safe
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/home_service/licence_list.dart';
import 'package:ekolabweb/src/ui/main/home_service/waralaba_list.dart';
import 'package:ekolabweb/src/ui/main/message/listchating.dart';
import 'package:ekolabweb/src/ui/main/profile.dart';
import 'package:ekolabweb/src/ui/main/search_main.dart';
import 'package:ekolabweb/src/ui/main/space/list_product.dart';
import 'package:ekolabweb/src/ui/main/notification/notification_sub.dart';
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
  int kindUser = 0;

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
              ? routeToWidget(context, NotificationSubmission(idUser, kindUser))
              : Container(),
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
              onClick: () => routeToWidget(context, ListChatingForm(idUser)),
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
                  child: ImageCircle(true, image, 50),
                  onTap: () => routeToWidget(context, Profile()),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return ["Produk Saya", "Pencarian", "Keluar"]
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
                case "Pencarian":
                  showSearch(
                      context: context, delegate: SearchMain(idUser));
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            // Align(
            //   alignment: AlignmentDirectional.centerEnd,
            //   child: IconButton(
            //       padding: EdgeInsets.only(top: 10, right: 10),
            //       onPressed: () => {
            //             showSearch(
            //                 context: context, delegate: SearchMain(idUser))
            //           },
            //       icon: Icon(
            //         Icons.search,
            //         color: Colors.black87,
            //       )),
            // ),
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
      image = userData.data!.data!["image"];
      idUser = userData.data!.id!;
      kindUser = userData.data!.kind!;
    });
    bloc.fetchAllUser({"id": idUser});
  }
}
