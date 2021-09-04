import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';

class WaralabaService extends StatefulWidget {
  final String idUser;
  final Map<String, dynamic>? productModel;
  final bool isUser;

  @override
  State<StatefulWidget> createState() {
    return WaralabaServiceState();
  }

  WaralabaService(this.idUser, this.productModel, this.isUser);
}

class WaralabaServiceState extends State<WaralabaService> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _termController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  String _docTitle = "";
  String _idProduct = "";
  List<InvestPrice> listInvestPrice = [];

  Uint8List? uploadedImage;
  Uint8List? uploadedDoc;
  String? extensionImage;
  String? extensionDoc;
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _idProduct = widget.productModel!["id"];
      _nameController.text = widget.productModel!["data"]["name"];
      _descriptionController.text = widget.productModel!["data"]["description"];
      _locationController.text = widget.productModel!["data"]["location"];
      _termController.text = widget.productModel!["data"]["term"];
      listInvestPrice.addAll((widget.productModel!["data"]["price"] as List)
          .map((e) => InvestPrice(e["title"], e["value"])));
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
    _locationController.dispose();
    _termController.dispose();
    _uploadPhotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBase,
        title: TextWidget(
          txt: "Waralaba",
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
                        hint: "Nama Produk atau Jasa",
                        readOnly: widget.isUser ? false : true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_descriptionController,
                            hint: "Deskripsi",
                            readOnly: widget.isUser ? false : true),
                      ),
                      TextFieldTitleWidget(_locationController,
                          hint: "Lokasi ditawarkan",
                          readOnly: widget.isUser ? false : true),
                      Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: TextFieldTitleWidget(_termController,
                            hint: "Persyaratan",
                            readOnly: widget.isUser ? false : true),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: TextWidget(txt: "Foto"),
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
                                        onTap: () => _startFilePicker('image'),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            TextWidget(
                              txt: "Harga Investasi:",
                            ),
                            IconButton(
                                onPressed: () {
                                  if (widget.isUser) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return _addPriceInvest();
                                        });
                                  }
                                },
                                icon: Icon(
                                  Icons.add_box,
                                  color: colorBase,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 21),
                        child: Wrap(
                          children: listInvestPrice
                              .asMap()
                              .map((i, e) => MapEntry(
                                  i,
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          color: Colors.black12,
                                        ),
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 15,
                                          top: 4,
                                          bottom: 4,
                                        ),
                                        margin: EdgeInsets.all(4.0),
                                        child: RichText(
                                            text: TextSpan(
                                                text: "${e.title}\n",
                                                style: TextStyle(
                                                    color: Colors.black54),
                                                children: [
                                              TextSpan(
                                                  text: e.value,
                                                  style: TextStyle(
                                                      color: Colors.black54))
                                            ])),
                                      ),
                                      Positioned(
                                          top: -2,
                                          right: -2,
                                          child: GestureDetector(
                                            onTap: () {
                                              if (widget.isUser) {
                                                setState(() {
                                                  listInvestPrice.removeAt(i);
                                                });
                                              }
                                            },
                                            child: Icon(
                                              Icons.cancel,
                                              color: Colors.black54,
                                              size: 21,
                                            ),
                                          ))
                                    ],
                                  )))
                              .values
                              .toList(),
                        ),
                      ),
                      widget.isUser
                          ? Row(
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

  Widget _addPriceInvest() {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -40.0,
            top: -40.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFieldWidget(
                  titleInvest,
                  hint: "title",
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: TextFieldWidget(
                  valueInvest,
                  hint: "value",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonWidget(
                  txt: TextWidget(txt: "simpan"),
                  height: 40.0,
                  width: 100,
                  btnColor: Colors.redAccent,
                  onClick: () {
                    if (titleInvest.text.isNotEmpty &&
                        valueInvest.text.isNotEmpty) {
                      _saveInvestPrice();
                      titleInvest.clear();
                      valueInvest.clear();
                      Navigator.of(context).pop();
                    }
                  },
                  borderRedius: 4,
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  _saveInvestPrice() {
    setState(() {
      listInvestPrice.add(InvestPrice(titleInvest.text, valueInvest.text));
    });
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
    _attemptSave(file?.data!["url"], fileDoc?.data!["url"]);
  }

  _attemptSave(String? imageUrl, String? docUrl) async {
    final req = {
      "id": widget.productModel != null ? widget.productModel!["id"] : "",
      "id_user": widget.idUser,
      "data": {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "location": _locationController.text,
        "term": _termController.text,
        "image": imageUrl ?? widget.productModel!["data"]["image"] ?? "",
        "doc": docUrl ?? widget.productModel!["data"]["doc"] ?? "",
        "price": listInvestPrice.map((e) => e.toJson()).toList()
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

class InvestPrice {
  String? title;
  String? value;

  InvestPrice(this.title, this.value);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'value': value,
    };
  }
}
