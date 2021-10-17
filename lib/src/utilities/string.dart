import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final String icProvider = "icons/ic_provider.png";
final String icForgotPass = "icons/ic_forgotpass.png";
final String imgNoData = "images/nodata.png";
final String myProduct = "images/myproduct.png";
final String logo = "images/logo.png";
final String about =
    "Situs e-kolab bertujuan untuk memfasilitasi Waralaba, Konsinyasi, Kerja sama, Jejaring Organisasi dan penawaran legalitas UMKM";
final String descPerawalaba =
    "Pihak yang ingin memberi izin untuk pemakaian merk, produk, dan sistem operasional";
final String descKonsiyor = "Pihak yang ingin menyerahkan barang(pemilik)";
final String descUKM = "Pihak yang ingin memiliki usaha";
final String descInvestor = "Pihak yang ingin memberi modal";
final String descJejaring =
    "Pihak yang ingin membangun hubungan dengan semua pihak";
final String descPerizinan = "Pihak yang ingin memberi izin secara legalitas";
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
      value = "Perizinan";
      break;
    case 7:
      value = "Jejaring Organisasi";
      break;
  }
  return value;
}
