import 'dart:convert';

import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/ui/main/admin/list_penawaran_admin.dart';
import 'package:ekolabweb/src/ui/main/admin/profile_admin.dart';
import 'package:ekolabweb/src/ui/main/admin/rekap_admin.dart';
import 'package:ekolabweb/src/ui/main/admin/rekap_kat_product.dart';
import 'package:ekolabweb/src/ui/main/admin/rekap_penawaran.dart';
import 'package:ekolabweb/src/ui/main/admin/rekap_response.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/image_circle.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class MainAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAdminState();
  }
}

class MainAdminState extends State<MainAdmin> {
  String email = "";
  String name = "";
  String idUser = "";

  final List<ItemGrid> listMenu = [
    ItemGrid("REKAP MEMBER", Icons.pie_chart),
    ItemGrid("REKAP PENAWARAN", Icons.pie_chart),
    ItemGrid("REKAP RESPON PENAWARAN", Icons.pie_chart),
    ItemGrid("REKAP KATEGORI PRODUK", Icons.pie_chart),
    ItemGrid("LIST PENAWARAN", Icons.insert_chart)
  ];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(logo),
        backgroundColor: Colors.blue[700],
        title: TextWidget(txt: "E-KOLAB"),
        centerTitle: false,
        actions: [
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
                  onTap: () => routeToWidget(context, ProfileAdmin()),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) {
              return ["Keluar"]
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
      body: GridView.count(
        crossAxisCount: 3,
        children: listMenu
            .map((e) => GestureDetector(
                  onTap: () => _onClick(e.name),
                  child: Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          e.icon,
                          size: MediaQuery.of(context).size.width / 8,
                          color: colorBase,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextWidget(
                            txt: e.name,
                            txtSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
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
  }

  _doLogout(context) {
    SharedPreferencesHelper.clearAllPreference();
    Navigator.pushNamedAndRemoveUntil(context, '/login_menu', (_) => false);
  }

  _onClick(String item) {
    switch (item) {
      case "REKAP MEMBER":
        routeToWidget(context, RekapAdmin());
        break;
      case "REKAP PENAWARAN":
        routeToWidget(context, RekapPenawaran());
        break;
      case "REKAP RESPON PENAWARAN":
        routeToWidget(context, RekapResponse());
        break;
      case "REKAP KATEGORI PRODUK":
        routeToWidget(context, RekapKategoriProduct());
        break;
      case "LIST PENAWARAN":
        routeToWidget(context, ListPenawaranAdmin());
        break;
    }
  }
}

class ItemGrid {
  String name;
  IconData icon;

  ItemGrid(this.name, this.icon);
}
