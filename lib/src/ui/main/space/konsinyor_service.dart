import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:mime/mime.dart';

class KonsinyorService extends StatefulWidget {
  final String idUser;
  final Map<String, dynamic>? productModel;
  final bool isUser;

  @override
  State<StatefulWidget> createState() {
    return _KonsinyorServiceState();
  }

  KonsinyorService(this.idUser, this.productModel, this.isUser);
}

class _KonsinyorServiceState extends State<KonsinyorService> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startendController = TextEditingController();
  final _priceController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  final _uploadDocController = TextEditingController();

  Uint8List? uploadedImage;
  Uint8List? uploadedDoc;
  String? extensionImage;
  String? extensionDoc;
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();
  String _idProduct = "";
  String _docTitle = "";

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _idProduct = widget.productModel!["id"];
      _nameController.text = widget.productModel!["data"]["name"];
      _descriptionController.text = widget.productModel!["data"]["description"];
      _startendController.text = widget.productModel!["data"]["start_end"];
      _priceController.text = widget.productModel!["data"]["price"];
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
    _nameController.dispose();
    _descriptionController.dispose();
    _startendController.dispose();
    _priceController.dispose();
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
          txt: "Konsinyasi",
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
                      TextFieldTitleWidget(
                        _nameController,
                        title: "Nama Produk *",
                        readOnly: widget.isUser ? false : true,
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
                        _priceController,
                        title: "Harga *",
                        readOnly: widget.isUser ? false : true,
                      ),
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
                      TextFieldTitleWidget(
                        _startendController,
                        title: "Lama Konsinyasi *",
                        readOnly: widget.isUser ? false : true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextWidget(txt: "Foto *"),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: widget.productModel != null
                                  ? widget.productModel!["data"]["image"]
                                          .toString()
                                          .isEmpty
                                      ? Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.black12,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () =>
                                                  _startFilePicker('image'),
                                              icon: Icon(
                                                Icons.add_a_photo,
                                                color: colorBase,
                                              ),
                                            ),
                                          ),
                                        )
                                      : uploadedImage != null
                                          ? GestureDetector(
                                              child: Image.memory(
                                                uploadedImage!,
                                                fit: BoxFit.fill,
                                              ),
                                              onTap: () =>
                                                  _startFilePicker('image'),
                                            )
                                          : GestureDetector(
                                              onTap: () => widget.isUser
                                                  ? _startFilePicker('image')
                                                  : null,
                                              child: Image.network(
                                                widget.productModel!["data"]
                                                    ["image"],
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                  : uploadedImage != null
                                      ? GestureDetector(
                                          child: Image.memory(
                                            uploadedImage!,
                                            fit: BoxFit.fill,
                                          ),
                                          onTap: () =>
                                              _startFilePicker('image'),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          color: Colors.black12,
                                          child: Center(
                                            child: IconButton(
                                              onPressed: () =>
                                                  _startFilePicker('image'),
                                              icon: Icon(
                                                Icons.add_a_photo,
                                                color: colorBase,
                                              ),
                                            ),
                                          ),
                                        ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextWidget(txt: "Dokumen *"),
                                IconButton(
                                    onPressed: () => widget.isUser
                                        ? _startFilePicker("doc")
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
    FileModel? file;
    FileModel? fileDoc;

    if (uploadedImage != null) {
      final reqFile = FormData.fromMap({
        "image": MultipartFile.fromBytes(uploadedImage!.toList(),
            filename:
                '${DateTime.now().millisecondsSinceEpoch}.' + extensionImage!)
      });
      file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
    }

    if (uploadedDoc != null) {
      final reqFileDoc = FormData.fromMap({
        "image": MultipartFile.fromBytes(uploadedDoc!.toList(),
            filename:
                '${DateTime.now().millisecondsSinceEpoch}.' + extensionDoc!)
      });
      fileDoc = await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);
    }
    _verifySubmit(file?.data!["url"], fileDoc?.data!["url"]);
  }

  _verifySubmit(String? imageUrl, String? docUrl) {
    if (_nameController.text.isEmpty) {
      showErrorMessage(
          context, "Konsinyasi", "Nama Produk tidak boleh kosong");
    } else if (_descriptionController.text.isEmpty) {
      showErrorMessage(
          context, "Konsinyasi", "Deskripsi tidak boleh kosong");
    } else if (_priceController.text.isEmpty) {
      showErrorMessage(context, "Produk dan Jasa", "Harga tidak boleh kosong");
    } else if (_startendController.text.isEmpty) {
      showErrorMessage(
          context, "Konsinyasi", "Lama Konsinyasi tidak boleh kosong");
    } else if (imageUrl == null) {
      showErrorMessage(context, "Konsinyasi", "Foto tidak boleh kosong");
    } else if (docUrl == null) {
      showErrorMessage(
          context, "Konsinyasi", "Dokumen tidak boleh kosong");
    } else {
      _attemptSave(imageUrl, docUrl);
    }
  }

  _attemptSave(String? imageUrl, String? docUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": _priceController.text,
        "start_end": _startendController.text,
        "image": imageUrl ?? widget.productModel!["data"]["image"] ?? "",
        "doc": docUrl ?? widget.productModel!["data"]["doc"] ?? "",
      }
    };
    bloc.createProductList(req);
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
            if (type == "image") {
              uploadedImage = reader.result as Uint8List;
              final mime = lookupMimeType('', headerBytes: uploadedImage);
              extensionImage = mime?.split("/")[1];
            } else {
              uploadedDoc = reader.result as Uint8List;
              final mime = lookupMimeType('', headerBytes: uploadedDoc);
              _docTitle = file.name;
              extensionDoc = mime?.split("/")[1];
            }
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
}
