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
  final Map<String, dynamic>? productModel;
  final bool isUser;

  @override
  State<StatefulWidget> createState() {
    return _NetWorkOrganizationServiceState();
  }

  NetWorkOrganizationService(this.idUser, this.productModel, this.isUser);
}

class _NetWorkOrganizationServiceState
    extends State<NetWorkOrganizationService> {
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _termController = TextEditingController();
  final _uploadDocController = TextEditingController();

  Uint8List? uploadedDoc;
  String? extensionDoc;
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();
  String? _productCategory;
  DateTime selectedDate = DateTime.now();
  String _idProduct = "";
  String _docTitle = "";

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _idProduct = widget.productModel!["id"];
      _productCategory = widget.productModel!["data"]["name"];
      _descriptionController.text = widget.productModel!["data"]["description"];
      _locationController.text = widget.productModel!["data"]["location"];
      _termController.text = widget.productModel!["data"]["term"];
      _dateController.text = widget.productModel!["data"]["date"];
    }
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
                  child: AbsorbPointer(
                    absorbing: widget.isUser ? false : true,
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
                          child: TextFieldTitleWidget(
                            _descriptionController,
                            hint: "Deskripsi",
                            readOnly: widget.isUser ? false : true,
                          ),
                        ),
                        TextFieldTitleWidget(
                          _termController,
                          hint: "Syarat",
                          readOnly: widget.isUser ? false : true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldTitleWidget(
                        _locationController,
                        hint: "Lokasi",
                        readOnly: widget.isUser ? false : true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_dateController,
                            hint: "Tanggal Pelaksanaan",
                            readOnly: true,
                            prefixIcon: IconButton(
                                onPressed: () =>
                                    widget.isUser ? _selectDate(context) : null,
                                icon: Icon(Icons.date_range_rounded))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextWidget(txt: "Dokumen"),
                                IconButton(
                                    onPressed: () => widget.isUser
                                        ? _startFilePicker()
                                        : null,
                                    icon: Icon(
                                      Icons.note_add_rounded,
                                      color: colorBase,
                                    )),
                              ],
                            ),
                            widget.productModel != null
                                ? widget.productModel!["data"]["doc"]
                                        .toString()
                                        .isNotEmpty
                                    ? GestureDetector(
                                        onTap: () => window.open(
                                            widget.productModel!["data"]["doc"],
                                            "_blank"),
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextWidget(
                                              txt: _docTitle.isNotEmpty
                                                  ? _docTitle
                                                  : widget.productModel!["data"]
                                                          ["doc"]
                                                      .toString()
                                                      .split("/")
                                                      .last,
                                              align: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                                : _docTitle.isNotEmpty
                                    ? Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextWidget(
                                            txt: _docTitle,
                                            align: TextAlign.start,
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                          ],
                        ),
                      ),
                      widget.isUser
                          ? Padding(
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
                                      onClick: () =>
                                          Navigator.of(context).pop(),
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
                          : SizedBox()
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

    if (uploadedDoc != null) {
      final reqFileDoc = FormData.fromMap({
        "image": MultipartFile.fromBytes(uploadedDoc!.toList(),
            filename:
                '${DateTime.now().millisecondsSinceEpoch}.' + extensionDoc!)
      });

      fileDoc = await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);
    }

    _attemptSave(fileDoc?.data?["url"]);
  }

  _attemptSave(String? docUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _productCategory,
        "description": _descriptionController.text,
        "term": _termController.text,
        "location": _locationController.text,
        "date": "${selectedDate.toLocal()}".split(' ')[0],
        "doc": docUrl ?? widget.productModel!["data"]["doc"] ?? ""
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
            _docTitle = file.name;
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
