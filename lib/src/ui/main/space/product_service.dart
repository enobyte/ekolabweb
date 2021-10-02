import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
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

  int minPrice = 0;
  int maxPrice = 0;
  String? _productCategory;
  String? _priceCategory;
  PickedFile? _image;
  final picker = ImagePicker();
  Uint8List? uploadedImage;
  String _idProduct = "";

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
      _productCategory = widget.productModel!["data"]["category"];
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
      body: SingleChildScrollView(
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
                  title: "Deskripsi *", readOnly: widget.isUser ? false : true),
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
                          data: ["SATUAN", "LUSINAN", "LAINNYA"],
                          chooseValue: _priceCategory,
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
                  data: [
                    "Kesehatan",
                    "Pendidikan",
                    "Kesenian",
                    "Olahraga",
                    "ATK",
                    "Otomotif",
                    "Lainnya"
                  ],
                  chooseValue: _productCategory,
                ),
              ),
              _productCategory?.equalIgnoreCase("lainnya") ?? false
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
                                    onPressed: () => _getImage(),
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
                                    onTap: () => _getImage(),
                                  )
                                : GestureDetector(
                                    onTap: () =>
                                        widget.isUser ? _getImage() : null,
                                    child: Image.network(
                                      widget.productModel!["data"]["image"],
                                      fit: BoxFit.fill,
                                    ),
                                  )
                        : uploadedImage != null
                            ? GestureDetector(
                                child: Image.memory(
                                  uploadedImage!,
                                  fit: BoxFit.fill,
                                ),
                                onTap: () => _getImage(),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                color: Colors.black12,
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => _getImage(),
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
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    uploadedImage = await pickedFile?.readAsBytes();
    setState(() {
      if (pickedFile != null) {
        _image = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _uploadImage() async {
    FileModel? file;
    final bytes = await _image?.readAsBytes();
    if (bytes != null) {
      final reqFile = FormData.fromMap({
        "image": MultipartFile.fromBytes(bytes,
            filename: '${DateTime.now().millisecondsSinceEpoch}.png')
      });
      file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
      if (file.data != null) {
        _verifySendData(file.data!["url"]);
      }
    } else {
      _verifySendData(null);
    }
  }

  _verifySendData(String? imageUrl) {
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
    } else if (_othersController.text.isNotEmpty) {
      if (_othersController.text.isEmpty) {
        showErrorMessage(
            context, "Produk dan Jasa", "Kategori lainnya tidak boleh kosong");
      } else if (_productCategory?.isEmpty ?? true) {
        showErrorMessage(
            context, "Produk dan Jasa", "Kategori produk tidak boleh kosong");
      }
    } else if (_notedController.text.isEmpty) {
      showErrorMessage(
          context, "Produk dan Jasa", "Keterangan tidak boleh kosong");
    } else if (imageUrl == null &&
        widget.productModel!["data"]["image"].toString().isEmpty) {
      showErrorMessage(context, "Produk dan Jasa", "Foto tidak boleh kosong");
    } else {
      _attemptSave(imageUrl);
    }
  }

  _attemptSave(String? imageUrl) async {
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
        "image": imageUrl ?? widget.productModel!["data"]["image"] ?? ""
      }
    };
    bloc.createProductList(req);
  }
}
