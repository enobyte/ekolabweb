import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/ProgressDialog.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/drop_down_title.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ekolabweb/src/utilities/utils.dart';

class ProductService extends StatefulWidget {
  final String idUser;
  final Map<String, dynamic>? productModel;
  final bool isUser;

  @override
  State<StatefulWidget> createState() {
    return _ProductServiceState();
  }

  ProductService(this.idUser, this.productModel, this.isUser);
}

class _ProductServiceState extends State<ProductService> {
  final _nameProductController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _notedController = TextEditingController();
  final _othersController = TextEditingController();
  final _catProductList = [
    "Kesehatan",
    "Pendidikan",
    "Kesenian",
    "Olahraga",
    "ATK",
    "Otomotif",
    "Lainnya"
  ];
  final _catPrice = ["SATUAN", "LUSINAN", "LAINNYA"];

  int minPrice = 0;
  int maxPrice = 0;
  String? _productCategory;
  String? _priceCategory;

  final picker = ImagePicker();
  List<dynamic>? uploadedImage = [];
  String _idProduct = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.productModel != null) {
      _idProduct = widget.productModel!["id"];
      _nameProductController.text = widget.productModel!["data"]["name"];
      _descriptionController.text = widget.productModel!["data"]["description"];
      _costController.text = widget.productModel!["data"]["price"];
      _notedController.text = widget.productModel!["data"]["note"];
      _priceCategory = widget.productModel!["data"]["category_price"];
      _priceController.text = widget.productModel!["data"]["price"];
      _productCategory = widget.productModel?["data"]?["category"] ?? "";
      _othersController.text = _productCategory!;
      uploadedImage = widget.productModel?["data"]["image"] as List<dynamic>;
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
    _nameProductController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _notedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Produk dan Jasa",
        ),
        backgroundColor: colorBase,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 21, right: 21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21, bottom: 21),
                  child: TextFieldTitleWidget(_nameProductController,
                      title: "Nama Produk atau Jasa *",
                      readOnly: widget.isUser ? false : true),
                ),
                TextFieldTitleWidget(_descriptionController,
                    title: "Deskripsi *",
                    readOnly: widget.isUser ? false : true),
                Padding(
                  padding: const EdgeInsets.only(top: 21, bottom: 21),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 5,
                        child: TextFieldTitleWidget(_priceController,
                            title: "Harga *",
                            textInputFormat:
                                FilteringTextInputFormatter.digitsOnly,
                            readOnly: widget.isUser ? false : true),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      Flexible(
                        flex: 5,
                        child: AbsorbPointer(
                          absorbing: widget.isUser ? false : true,
                          child: DropDownTitle(
                            onChange: (value) =>
                                setState(() => _priceCategory = value),
                            hint: "Kategori Harga *",
                            data: _catPrice,
                            chooseValue: _catPrice.contains(_priceCategory)
                                ? _priceCategory
                                : _catPrice.last,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                AbsorbPointer(
                  absorbing: widget.isUser ? false : true,
                  child: DropDownTitle(
                      onChange: (value) => setState(() {
                            _productCategory = value;
                            _othersController.clear();
                          }),
                      hint: "Kategori Produk *",
                      data: _catProductList,
                      chooseValue: _catProductList.contains(_productCategory)
                          ? _productCategory
                          : _catProductList.last),
                ),
                (_productCategory?.equalIgnoreCase("lainnya") ?? false) ||
                        !_catProductList.contains(_productCategory)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: TextFieldTitleWidget(
                          _othersController,
                          title: "Kategori Lainnya *",
                          readOnly: widget.isUser ? false : true,
                        ),
                      )
                    : SizedBox(),
                Padding(
                  padding: const EdgeInsets.only(top: 21, bottom: 21),
                  child: TextFieldTitleWidget(_notedController,
                      title: "Keterangan *",
                      readOnly: widget.isUser ? false : true),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextWidget(txt: "Foto *"),
                        ),
                        widget.isUser
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                alignment: FractionalOffset.topCenter,
                                onPressed: () => _getImage(),
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
                                              e.toString().startsWith("https")
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
                                                    uploadedImage!.removeAt(
                                                        uploadedImage!
                                                            .indexOf(e));
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
                widget.isUser
                    ? Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
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
                                onClick: () => _verifySendData(),
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
        ),
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    var img = await pickedFile?.readAsBytes();
    setState(() {
      if (pickedFile != null) {
        //_image = PickedFile(pickedFile.path);
        uploadedImage?.add(img!);
      } else {
        print('No image selected.');
      }
    });
  }

  _verifySendData() async {
    if (_nameProductController.text.isEmpty) {
      showErrorMessage(
          context, "Produk dan Jasa", "Nama Produk tidak boleh kosong");
    } else if (_descriptionController.text.isEmpty) {
      showErrorMessage(
          context, "Produk dan Jasa", "Deskripsi tidak boleh kosong");
    } else if (_priceController.text.isEmpty) {
      showErrorMessage(context, "Produk dan Jasa", "Harga tidak boleh kosong");
    } else if (_priceCategory?.isEmpty ?? true) {
      showErrorMessage(
          context, "Produk dan Jasa", "Kategori harga tidak boleh kosong");
    } else if (_productCategory?.isEmpty ?? true) {
      showErrorMessage(
          context, "Produk dan Jasa", "Kategori produk tidak boleh kosong");
    } else if (_productCategory!.equalIgnoreCase("lainnya") &&
        _othersController.text.isEmpty) {
      showErrorMessage(
          context, "Produk dan Jasa", "Kategori lainnya tidak boleh kosong");
    } else if (_notedController.text.isEmpty) {
      showErrorMessage(
          context, "Produk dan Jasa", "Keterangan tidak boleh kosong");
    } else if (uploadedImage!.length < 1) {
      showErrorMessage(context, "Produk dan Jasa", "Foto tidak boleh kosong");
    } else {
      _setLoading(true);
      List<dynamic> imageUrl = [];
      for (int i = 0; i < uploadedImage!.length; i++) {
        if (!uploadedImage![i].toString().startsWith("http") &&
            !uploadedImage![i].toString().startsWith("https")) {
          final reqFile = FormData.fromMap({
            "image": MultipartFile.fromBytes(uploadedImage![i],
                filename: '${DateTime.now().millisecondsSinceEpoch}.png')
          });
          FileModel file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
          imageUrl.add(file.data!["url"]);
        } else {
          imageUrl.add(uploadedImage![i]);
        }
      }
      _attemptSave(imageUrl);
    }
  }

  _attemptSave(List<dynamic>? imageUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _nameProductController.text,
        "description": _descriptionController.text,
        "price": _priceController.text,
        "category": _othersController.text.isNotEmpty
            ? _othersController.text
            : _productCategory,
        "note": _notedController.text,
        "category_price": _priceCategory,
        "image":
            imageUrl ?? widget.productModel!["data"]["image"] as List<dynamic>
      }
    };
    bloc.createProductList(req);
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
