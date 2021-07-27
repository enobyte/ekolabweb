import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/bloc/product_bloc.dart';

class KonsinyasiSubmission extends StatefulWidget {
  final String idProduct;
  final String idUserSub;
  final String kindUserSub;
  final String nameUserSub;
  final String existDesc;

  @override
  State<StatefulWidget> createState() {
    return _KonsinyasiSubmissionState();
  }

  KonsinyasiSubmission(this.idProduct, this.idUserSub, this.kindUserSub,
      this.nameUserSub, this.existDesc);
}

class _KonsinyasiSubmissionState extends State<KonsinyasiSubmission> {
  final _descriptionController = TextEditingController();
  final _termController = TextEditingController();
  final _noteController = TextEditingController();
  final _dateController = TextEditingController();
  final _uploadDocController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late Uint8List? uploadedDoc;
  String? extensionDoc;

  @override
  void initState() {
    super.initState();
    _descriptionController.text = widget.existDesc;
  }

  @override
  void dispose() {
    super.dispose();
    _termController.dispose();
    _descriptionController.dispose();
    _noteController.dispose();
    _termController.dispose();
    _uploadDocController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Pengajuan Konsinyasi",
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
                    _descriptionController,
                    hint: "Deskripsi Konsinyasi",
                    readOnly: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 21, bottom: 21),
                    child: TextFieldTitleWidget(
                      _termController,
                      hint: "Persyaratan",
                    ),
                  ),
                  TextFieldTitleWidget(_noteController, hint: "Keterangan"),
                ],
              ),
            )),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFieldTitleWidget(_dateController,
                      hint: "Tanggal Pelaksanaan",
                      readOnly: true,
                      prefixIcon: IconButton(
                          onPressed: () => _selectDate(context),
                          icon: Icon(Icons.date_range_rounded))),
                  Padding(
                    padding: const EdgeInsets.only(top: 21, bottom: 55),
                    child: TextFieldTitleWidget(
                      _uploadDocController,
                      hint: "Document Pendukung",
                      readOnly: true,
                      prefixIcon: IconButton(
                          onPressed: () => _startFilePicker("doc"),
                          icon: Icon(Icons.note_add_rounded)),
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
                          txt: TextWidget(txt: "Ajukan"),
                          height: 40.0,
                          width: 200,
                          btnColor: Colors.blue,
                          onClick: () => _uploadImage(),
                          //_uploadImage(),
                          borderRedius: 8,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat("dd MMMM yyyy").format(picked);
      });
  }

  _startFilePicker(String type) async {
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedDoc = reader.result as Uint8List;
            final mime = lookupMimeType('', headerBytes: uploadedDoc);
            extensionDoc = mime?.split("/")[1];
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            //option1Text = "Some Error occured while reading the file";
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  _uploadImage() async {
    FileModel? fileDoc;

    final reqFileDoc = FormData.fromMap({
      "image": MultipartFile.fromBytes(uploadedDoc!.toList(),
          filename: '${DateTime.now().millisecondsSinceEpoch}.' + extensionDoc!)
    });

    fileDoc = await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);

    if (fileDoc.data != null) {
      _submitSubmission(fileDoc.data!["url"]);
    }
  }

  _submitSubmission(String docUrl) {
    bloc.submissionRequest({
      "id_product": widget.idProduct,
      "data": {
        "id_user_sub": widget.idUserSub,
        "kind": widget.kindUserSub,
        "name_user_sub": widget.nameUserSub,
        "submission": {
          "note": _noteController.text,
          "term": _termController.text,
          "implement_date": selectedDate.toString(),
          "doc": ""
        }
      }
    });
  }
}