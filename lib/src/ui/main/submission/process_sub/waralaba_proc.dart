import 'package:ekolabweb/src/model/submission_model.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/labeled_radio.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class WaralabaProcess extends StatefulWidget {
  final SubmissionModel data;
  final int idxSub;

  @override
  State<StatefulWidget> createState() {
    return _WaralabaProcessState();
  }

  WaralabaProcess(this.data, this.idxSub);
}

class _WaralabaProcessState extends State<WaralabaProcess> {
  final _nameResponder = TextEditingController();
  final _addressResponder = TextEditingController();
  final _noteResponder = TextEditingController();
  final _docResponder = TextEditingController();
  var category = ["diskusi", "diterima", "ditolak"];
  String _isRadioSelected = "";

  @override
  void initState() {
    super.initState();
    _nameResponder.text = widget.data.data![widget.idxSub]["user"]["name"];
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
                      hint: "Nama Perespon",
                      readOnly: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 21),
                      child: TextFieldTitleWidget(
                        _addressResponder,
                        hint: "Alamat Perespon",
                        readOnly: true,
                      ),
                    ),
                    TextFieldTitleWidget(
                      _noteResponder,
                      hint: "Keterangan Perespon",
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
                    TextFieldTitleWidget(
                      _docResponder,
                      hint: "Dokumen Pendukung",
                      readOnly: true,
                      suffixIcon: IconButton(
                          onPressed: () => {},
                          icon: Icon(Icons.remove_red_eye_sharp)),
                    ),
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
                      padding: const EdgeInsets.only(bottom: 18),
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
                            onClick: () => {},
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
}
