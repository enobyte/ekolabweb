import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/drop_down_title.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

class NetWorkOrganizationService extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _NetWorkOrganizationServiceState();
  }

  NetWorkOrganizationService(this.idUser);
}

class _NetWorkOrganizationServiceState
    extends State<NetWorkOrganizationService> {
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _termController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  final _uploadDocController = TextEditingController();

  late Uint8List? uploadedDoc;
  String? extensionDoc;
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();
  String? _productCategory;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    bloc.createProduct.listen((event) {
      if (event.status!) {
        Navigator.of(context).pop();
      }
    }, onError: (msg) {
      showErrorMessage(context, "Product", msg);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _termController.dispose();
    _uploadPhotoController.dispose();
    _uploadDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBase,
        title: TextWidget(
          txt: "Jejaring Organisasi",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      DropDownTitle(
                        onChange: (value) =>
                            setState(() => _productCategory = value!),
                        hint: "Kategori",
                        data: [
                          "PELATIHAN",
                          "URUSAH IJIN",
                          "ARISAN",
                          "BIKER",
                          "EO"
                        ],
                        chooseValue: _productCategory,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_descriptionController,
                            hint: "Deskripsi"),
                      ),
                      TextFieldTitleWidget(_termController, hint: "Syarat"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldTitleWidget(_locationController, hint: "Lokasi"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_dateController,
                            hint: "Tanggal Pelaksanaan",
                            readOnly: true,
                            prefixIcon: IconButton(
                                onPressed: () => _selectDate(context),
                                icon: Icon(Icons.date_range_rounded))),
                      ),
                      TextFieldTitleWidget(
                        _uploadDocController,
                        hint: "Document",
                        readOnly: true,
                        prefixIcon: IconButton(
                            onPressed: () => _startFilePicker(),
                            icon: Icon(Icons.note_add_rounded)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Row(
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
                                txt: TextWidget(txt: "Simpan"),
                                height: 40.0,
                                width: 200,
                                btnColor: Colors.blue,
                                onClick: () => _uploadImage(),
                                borderRedius: 8,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _uploadImage() async {
    FileModel? fileDoc;

    final reqFileDoc = FormData.fromMap({
      "image": MultipartFile.fromBytes(uploadedDoc!.toList(),
          filename: '${DateTime.now().millisecondsSinceEpoch}.' + extensionDoc!)
    });

    fileDoc = await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);

    if (fileDoc.data != null) {
      _attemptSave(fileDoc.data!["url"]);
    }
  }

  _attemptSave(String docUrl) async {
    final req = {
      "id_user": widget.idUser,
      "data": {
        "name": _productCategory,
        "description": _descriptionController.text,
        "term": _termController.text,
        "location": _locationController.text,
        "date": "${selectedDate.toLocal()}".split(' ')[0],
        "doc": docUrl
      }
    };
    bloc.createProductList(req);
  }

  _startFilePicker() async {
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
}
