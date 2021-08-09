import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String icProvider = "icons/ic_provider.png";
final String imgNoData = "images/nodata.png";
final String myProduct = "images/myproduct.png";
final String logo = "images/logo.png";

final Color? colorBase = Colors.blue[700];

String dataKind(int kind) {
  String value = "";
  switch (kind) {
    case 1:
      value = "Pewaralaba";
      break;
    case 2:
      value = "Konsinyor";
      break;
    case 3:
      value = "UKM/UMK";
      break;
    case 4:
      value = "Investor";
      break;
    case 5:
      value = "Admin IWAPI";
      break;
    case 6:
      value = "Perijinan";
      break;
    case 7:
      value = "Jejaring Organisasi";
      break;
  }
  return value;
}
