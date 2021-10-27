import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/labeled_radio.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class SubmissionProcess extends StatefulWidget {
  final SubmissionModel data;
  final int idxSub;
  final String idUserSub;

  @override
  State<StatefulWidget> createState() {
    return _SubmissionProcessState();
  }

  SubmissionProcess(this.data, this.idxSub, this.idUserSub);
}

class _SubmissionProcessState extends State<SubmissionProcess> {
  final _nameResponder = TextEditingController();
  final _addressResponder = TextEditingController();
  final _noteResponder = TextEditingController();
  final _reasonReject = TextEditingController();
  String? _docResponder = "";
  var category = ["diskusi", "diterima", "ditolak"];
  String _isRadioSelected = "";

  @override
  void initState() {
    super.initState();
    _nameResponder.text =
        widget.data.data![widget.idxSub]["data"]?["name_user_sub"] ?? "";
    _addressResponder.text =
        widget.data.data![widget.idxSub]["data"]?["address_user_sub"] ?? "";
    _noteResponder.text =
        widget.data.data![widget.idxSub]["data"]["submission"]?["note"] ?? "";
    _docResponder =
        widget.data.data![widget.idxSub]["data"]["submission"]?["doc"] ?? "";
    bloc.submissionProc.listen((event) {
      showErrorMessage(context, "Proses Pengajuan", event.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Proses Pengajuan",
        ),
      ),
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFieldTitleWidget(
                      _nameResponder,
                      title: "Nama Perespon",
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 21),
                      child: TextFieldTitleWidget(
                        _addressResponder,
                        title: "Alamat Perespon",
                        readOnly: true,
                      ),
                    ),
                    TextFieldTitleWidget(
                      _noteResponder,
                      title: "Keterangan Perespon",
                      readOnly: true,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextWidget(
                      txt: "Dokumen Pendukung",
                      align: TextAlign.start,
                    ),
                    _docResponder!.isNotEmpty
                        ? Card(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    txt: "data.pdf",
                                    color: Colors.black54,
                                    align: TextAlign.start,
                                  ),
                                  IconButton(
                                      onPressed: () => html.window
                                          .open(_docResponder!, "_blank"),
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black54,
                                      ))
                                ],
                              ),
                            ),
                          )
                        : TextWidget(txt: "Kosong"),
                    // TextFieldTitleWidget(
                    //   _docResponder,
                    //   hint: "Dokumen Pendukung",
                    //   readOnly: true,
                    //   suffixIcon: IconButton(
                    //       onPressed: () => {},
                    //       icon: Icon(Icons.remove_red_eye_sharp)),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 21, bottom: 10),
                      child: TextWidget(
                        txt: "Status Proses",
                        align: TextAlign.start,
                      ),
                    ),
                    LabeledRadio(
                      label: "Diskusi",
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      value: category[0],
                      groupValue: _isRadioSelected,
                      onChanged: (String newValue) {
                        setState(() {
                          _isRadioSelected = newValue;
                        });
                      },
                    ),
                    LabeledRadio(
                      label: "Diterima",
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      value: category[1],
                      groupValue: _isRadioSelected,
                      onChanged: (String newValue) {
                        setState(() {
                          _isRadioSelected = newValue;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: _isRadioSelected == "ditolak" ? 8 : 16),
                      child: LabeledRadio(
                        label: "Ditolak",
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        value: category[2],
                        groupValue: _isRadioSelected,
                        onChanged: (String newValue) {
                          setState(() {
                            _isRadioSelected = newValue;
                          });
                        },
                      ),
                    ),
                    _isRadioSelected == "ditolak"
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TextFieldTitleWidget(_reasonReject,
                                title: "Alasan Penolakan"),
                          )
                        : SizedBox(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: ButtonWidget(
                            txt: TextWidget(txt: "Batal"),
                            height: 40.0,
                            isFlatBtn: true,
                            width: 200,
                            btnColor: Colors.blue,
                            onClick: () => Navigator.of(context).pop(),
                            borderRedius: 8,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: ButtonWidget(
                            txt: TextWidget(txt: "Proses"),
                            height: 40.0,
                            width: 200,
                            btnColor: Colors.blue,
                            onClick: () => _submitProcess(
                                widget.data.data![widget.idxSub]["id_product"]),
                            //_uploadImage(),
                            borderRedius: 8,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _submitProcess(String idProduct) {
    bloc.submissionProcess({
      "id_product": idProduct,
      "id_user": widget.idUserSub,
      "data": {
        "status": _isRadioSelected,
        "id_user_sub": widget.idUserSub,
        "reason": _reasonReject.text
      }
    });
  }
}
