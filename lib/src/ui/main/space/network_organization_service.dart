import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/ProgressDialog.dart';
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

  List<dynamic>? uploadedDoc = [];
  List<dynamic>? extensionDoc = [];
  List<dynamic> _docTitle = [];
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();
  String? _productCategory;
  DateTime selectedDate = DateTime.now();
  String _idProduct = "";
  bool _isLoading = false;

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

      uploadedDoc = widget.productModel?["data"]["doc"] as List<dynamic>;
      extensionDoc!.addAll(
          (widget.productModel?["data"]["doc"] as List<dynamic>)
              .map((e) => e.toString().split(".").last));
      _docTitle.addAll((widget.productModel?["data"]["doc"] as List<dynamic>)
          .map((e) => e.toString().split("/").last));
    }
    bloc.createProduct.listen((event) {
      if (event.status!) {
        Navigator.of(context).pop();
      }
    }, onError: (msg) {
      showErrorMessage(context, "Product", msg);
    });

    bloc.delProduct.listen((event) {
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
      bottomSheet: widget.isUser && _idProduct.isNotEmpty
          ? ButtonWidget(
              txt: TextWidget(txt: "Hapus"),
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              btnColor: Colors.redAccent,
              onClick: () => _verifyDel(),
              borderRedius: 4,
            )
          : SizedBox(),
      body: ProgressDialog(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40),
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
                            hint: "Kategori *",
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
                              title: "Deskripsi *",
                              readOnly: widget.isUser ? false : true,
                            ),
                          ),
                          TextFieldTitleWidget(
                            _termController,
                            title: "Persyaratan *",
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
                          title: "Lokasi *",
                          readOnly: widget.isUser ? false : true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 21, bottom: 21),
                          child: TextFieldTitleWidget(_dateController,
                              title: "Tanggal Pelaksanaan *",
                              readOnly: true,
                              prefixIcon: IconButton(
                                  onPressed: () => widget.isUser
                                      ? _selectDate(context)
                                      : null,
                                  icon: Icon(Icons.date_range_rounded))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 21, bottom: 21),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextWidget(txt: "Dokumen *"),
                                  widget.isUser
                                      ? IconButton(
                                          onPressed: () => _startFilePicker(),
                                          icon: Icon(
                                            Icons.note_add_rounded,
                                            color: colorBase,
                                          ))
                                      : SizedBox(),
                                ],
                              ),
                              Wrap(
                                children: uploadedDoc!
                                    .map((e) => Container(
                                          height: 50,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Stack(
                                            children: [
                                              Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: !e
                                                              .toString()
                                                              .startsWith(
                                                                  "http") &&
                                                          !e
                                                              .toString()
                                                              .startsWith(
                                                                  "https")
                                                      ? TextWidget(
                                                          txt: _docTitle[
                                                              uploadedDoc!
                                                                  .indexOf(e)],
                                                          align:
                                                              TextAlign.start,
                                                        )
                                                      : GestureDetector(
                                                          onTap: () =>
                                                              window.open(
                                                                  e, "_blank"),
                                                          child: TextWidget(
                                                              txt: e
                                                                  .toString()
                                                                  .split("/")
                                                                  .last),
                                                        ),
                                                ),
                                              ),
                                              widget.isUser
                                                  ? Positioned(
                                                      top: -2,
                                                      right: -2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            var idx =
                                                                uploadedDoc!
                                                                    .indexOf(e);
                                                            extensionDoc
                                                                ?.removeAt(idx);
                                                            _docTitle
                                                                .removeAt(idx);
                                                            uploadedDoc!
                                                                .removeAt(idx);
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: colorBase,
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
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
                                        onClick: () => _verifySubmit(),
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
      ),
    );
  }

  _uploadImage() async {
    List<dynamic> listDoc = [];
    for (int i = 0; i < uploadedDoc!.length; i++) {
      if (!uploadedDoc![i].toString().startsWith("http") &&
          !uploadedDoc![i].toString().startsWith("https")) {
        final reqFileDoc = FormData.fromMap({
          "image": MultipartFile.fromBytes(uploadedDoc![i],
              filename: '${DateTime.now().millisecondsSinceEpoch}.' +
                  extensionDoc![i])
        });
        FileModel fileDoc =
            await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);
        listDoc.add(fileDoc.data!["url"]);
      } else {
        listDoc.add(uploadedDoc![i]);
      }
    }
    _attemptSave(listDoc);
  }

  _verifySubmit() {
    if (_productCategory?.isEmpty ?? true) {
      showErrorMessage(context, "Jejaring", "Kategori tidak boleh kosong");
    } else if (_descriptionController.text.isEmpty) {
      showErrorMessage(context, "Jejaring", "Deskripsi tidak boleh kosong");
    } else if (_termController.text.isEmpty) {
      showErrorMessage(context, "Jejaring", "Persyaratan tidak boleh kosong");
    } else if (_locationController.text.isEmpty) {
      showErrorMessage(context, "Jejaring", "Lokasi tidak boleh kosong");
    } else if (_dateController.text.isEmpty) {
      showErrorMessage(
          context, "Jejaring", "Tanggal Pelaksanaan tidak boleh kosong");
    } else if (uploadedDoc!.length < 1) {
      showErrorMessage(context, "Jejaring", "Dokumen tidak boleh kosong");
    } else {
      _setLoading(true);
      _uploadImage();
    }
  }

  _attemptSave(List<dynamic>? docUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _productCategory,
        "description": _descriptionController.text,
        "term": _termController.text,
        "location": _locationController.text,
        "date": "${selectedDate.toLocal()}".split(' ')[0],
        "doc": docUrl ?? widget.productModel!["data"]["doc"] ?? "",
        "image": ["http://ekolab.id/file/network_803307003.png"]
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
            var doc = reader.result as Uint8List;
            _docTitle.add(file.name);
            extensionDoc!.add(file.name.split(".").last);
            uploadedDoc!.add(doc);
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

  _verifyDel() {
    showMessage(
        context,
        AlertDialog(
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextWidget(
                      txt: "Apakah anda yakin ingin menghapus produk ini?"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ButtonWidget(
                      txt: TextWidget(txt: "iya"),
                      height: 30.0,
                      width: 60,
                      btnColor: Colors.redAccent,
                      onClick: () {
                        _attemptDel();
                        Navigator.of(context).pop();
                      },
                      borderRedius: 4,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    ButtonWidget(
                      txt: TextWidget(txt: "tidak"),
                      height: 30.0,
                      width: 60,
                      btnColor: Colors.redAccent,
                      onClick: () => Navigator.of(context).pop(),
                      borderRedius: 4,
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _attemptDel() {
    final req = {"id": _idProduct};
    bloc.deleteProduct(req);
  }

  _setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
