import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final String icProvider =
    kIsWeb ? "icons/ic_provider.png" : "assets/icons/ic_provider.png";
final String icForgotPass =
    kIsWeb ? "icons/ic_forgotpass.png" : "assets/icons/ic_forgotpass.png";
final String icInvestor =
    kIsWeb ? "icons/ic_investor.png" : "assets/icons/ic_investor.png";
final String icJejaring =
    kIsWeb ? "icons/ic_jejaring.png" : "assets/icons/ic_jejaring.png";
final String icKerjasama =
    kIsWeb ? "icons/ic_kerjasama.png" : "assets/icons/ic_kerjasama.png";
final String icKonsinyor =
    kIsWeb ? "icons/ic_konsinyor.png" : "assets/icons/ic_konsinyor.png";
final String icPersetujuan =
    kIsWeb ? "icons/ic_persetujuan.png" : "assets/icons/ic_persetujuan.png";
final String icPewaralaba =
    kIsWeb ? "icons/ic_pewaralaba.png" : "assets/icons/ic_pewaralaba.png";
final String icUkm = kIsWeb ? "icons/ic_ukm.png" : "assets/icons/ic_ukm.png";
final String imgNoData =
    kIsWeb ? "images/nodata.png" : "assets/images/nodata.png";
final String myProduct =
    kIsWeb ? "images/myproduct.png" : "assets/images/myproduct.png";
final String logo = kIsWeb ? "images/logo.png" : "assets/images/logo.png";
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
