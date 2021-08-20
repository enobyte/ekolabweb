import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';
import 'dart:html' as html;

class RekapAdmin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RekapAdminState();
  }
}

class _RekapAdminState extends State<RekapAdmin> {
  var pdf = pw.Document();
  var anchor;
  final _getUserByKindBloc = UserBloc();
  final List<Map<String, dynamic>> listRekap = [
    {"kind": 3, "name": "Rekap UKM/UMK", "alias": "ukm"},
    {"kind": 1, "name": "Rekap Waralaba", "alias": "waralaba"},
    {"kind": 2, "name": "Rekap Konsinyasi", "alias": "konsinyasi"},
    {"kind": 6, "name": "Rekap Perijinan", "alias": "perijinan"},
    {"kind": 7, "name": "Rekap Jejaring", "alias": "jejaring"},
    {"kind": 4, "name": "Rekap Investor", "alias": "investor"},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Rekap Member",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 11),
              ),
              Column(
                children: listRekap
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 21),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextWidget(
                                  txt: e["name"],
                                  txtSize: 21,
                                ),
                                ButtonWidget(
                                  txt: TextWidget(txt: "Download"),
                                  height: 40.0,
                                  width: 100,
                                  btnColor: Colors.redAccent,
                                  onClick: () async {
                                    await createPDF(e["kind"], e["alias"]);
                                    anchor.click();
                                    pdf = new pw.Document();
                                  },
                                  borderRedius: 4,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 11),
                              child: Divider(),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  savePDF(String alias) async {
    Uint8List pdfInBytes = await pdf.save();
    final blob = html.Blob([pdfInBytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '$alias.pdf';
    html.document.body!.children.add(anchor);
  }

  createPDF(int kind, String alias) async {
    final data = await _getUserByKindBloc.fetchUserByKind({"kind": kind});
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          children: data.data!
              .map((e) => pw.Row(children: [
                    pw.Text(e?.data?["name"],
                        style: pw.TextStyle(fontSize: 11)),
                    pw.Text(e?.data?["email"],
                        style: pw.TextStyle(fontSize: 11)),
                    pw.Text(e?.data?["address"],
                        style: pw.TextStyle(fontSize: 11)),
                  ], mainAxisAlignment: pw.MainAxisAlignment.spaceBetween))
              .toList(),
        ),
      ),
    );
    await savePDF(alias);
  }
}