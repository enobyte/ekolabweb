import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/ProgressDialog.dart';
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
  List<dynamic> _docTitle = [];
  String _idProduct = "";
  List<InvestPrice> listInvestPrice = [];

  List<dynamic>? uploadedImage = [];
  List<dynamic>? uploadedDoc = [];
  List<dynamic>? extensionImage = [];
  List<dynamic>? extensionDoc = [];
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();

  bool _isLoading = false;

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

      uploadedImage = widget.productModel?["data"]["image"] as List<dynamic>;
      extensionImage!.addAll(
          (widget.productModel?["data"]["image"] as List<dynamic>)
              .map((e) => e.toString().split(".").last));

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
                    child: Column(
                      children: [
                        TextFieldTitleWidget(
                          _nameController,
                          title: "Nama Produk atau Jasa *",
                          readOnly: widget.isUser ? false : true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 21, bottom: 21),
                          child: TextFieldTitleWidget(_descriptionController,
                              title: "Deskripsi *",
                              readOnly: widget.isUser ? false : true),
                        ),
                        TextFieldTitleWidget(_locationController,
                            title: "Lokasi ditawarkan *",
                            readOnly: widget.isUser ? false : true),
                        Padding(
                          padding: const EdgeInsets.only(top: 21),
                          child: TextFieldTitleWidget(_termController,
                              title: "Persyaratan *",
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
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: TextWidget(txt: "Foto *"),
                                ),
                                widget.isUser
                                    ? IconButton(
                                        padding: EdgeInsets.zero,
                                        alignment: FractionalOffset.topCenter,
                                        onPressed: () =>
                                            _startFilePicker('image'),
                                        icon: Icon(
                                          Icons.add_box_rounded,
                                          color: colorBase,
                                        ))
                                    : SizedBox()
                              ],
                            ),
                            Wrap(
                              children: uploadedImage!
                                  .map((e) => SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              e.toString().startsWith("http") ||
                                                      e
                                                          .toString()
                                                          .startsWith("https")
                                                  ? Image.network(
                                                      e,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.memory(
                                                      e,
                                                      fit: BoxFit.fill,
                                                    ),
                                              widget.isUser
                                                  ? Positioned(
                                                      top: -2,
                                                      right: -2,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            var idx =
                                                                uploadedImage!
                                                                    .indexOf(e);
                                                            uploadedImage!
                                                                .removeAt(idx);
                                                            extensionImage!
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
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
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
                                          onPressed: () => widget.isUser
                                              ? _startFilePicker("doc")
                                              : null,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              TextWidget(
                                txt: "Harga Investasi * :",
                              ),
                              widget.isUser
                                  ? IconButton(
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
                                  : SizedBox()
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                        widget.isUser
                                            ? Positioned(
                                                top: -2,
                                                right: -2,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (widget.isUser) {
                                                      setState(() {
                                                        listInvestPrice
                                                            .removeAt(i);
                                                      });
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.cancel,
                                                    color: Colors.black54,
                                                    size: 21,
                                                  ),
                                                ))
                                            : SizedBox()
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
    List<dynamic> listImage = [];
    List<dynamic> listDoc = [];
    for (int i = 0; i < uploadedImage!.length; i++) {
      if (!uploadedImage![i].toString().startsWith("http") &&
          !uploadedImage![i].toString().startsWith("https")) {
        final reqFile = FormData.fromMap({
          "image": MultipartFile.fromBytes(uploadedImage![i],
              filename: '${DateTime.now().millisecondsSinceEpoch}.' +
                  extensionImage![i])
        });
        FileModel file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
        listImage.add(file.data!["url"]);
      } else {
        listImage.add(uploadedImage![i]);
      }
    }

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

    _attemptSave(listImage, listDoc);
  }

  _verifySubmit() {
    if (_nameController.text.isEmpty) {
      showErrorMessage(context, "Waralaba", "Nama Produk tidak boleh kosong");
    } else if (_descriptionController.text.isEmpty) {
      showErrorMessage(context, "Waralaba", "Deskripsi tidak boleh kosong");
    } else if (_locationController.text.isEmpty) {
      showErrorMessage(
          context, "Waralaba", "Lokasi ditawarkan tidak boleh kosong");
    } else if (_termController.text.isEmpty) {
      showErrorMessage(context, "Waralaba", "Persyaratan tidak boleh kosong");
    } else if (listInvestPrice.isEmpty) {
      showErrorMessage(
          context, "Waralaba", "Harga Investasi tidak boleh kosong");
    } else if (uploadedImage!.length < 1) {
      showErrorMessage(context, "Waralaba", "Foto tidak boleh kosong");
    } else if (uploadedDoc!.length < 1) {
      showErrorMessage(context, "Waralaba", "Dokumen tidak boleh kosong");
    } else {
      _setLoading(true);
      _uploadImage();
    }
  }

  _attemptSave(List<dynamic>? imageUrl, List<dynamic>? docUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "location": _locationController.text,
        "term": _termController.text,
        "image":
            imageUrl ?? widget.productModel!["data"]["image"] as List<dynamic>,
        "doc": docUrl ?? widget.productModel!["data"]["doc"] as List<dynamic>,
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
              var img = reader.result as Uint8List;
              extensionImage!.add(file.name.split(".").last);
              uploadedImage!.add(img);
            } else {
              var doc = reader.result as Uint8List;
              _docTitle.add(file.name);
              extensionDoc!.add(file.name.split(".").last);
              uploadedDoc!.add(doc);
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
