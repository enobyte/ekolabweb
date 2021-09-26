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
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _notedController = TextEditingController();
  final _othersController = TextEditingController();

  RangeValues _priceRangeValues = RangeValues(100, 1000);
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
                    hint: "Nama Produk atau Jasa",
                    readOnly: widget.isUser ? false : true),
              ),
              TextFieldTitleWidget(_descriptionController,
                  hint: "Deskripsi", readOnly: widget.isUser ? false : true),
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 21),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 2,
                      child: TextFieldTitleWidget(
                        _costController,
                        hint: "Harga",
                        readOnly: true,
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: AbsorbPointer(
                        absorbing: widget.isUser ? false : true,
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: SliderTheme(
                            data: SliderThemeData(
                              thumbColor: Colors.green.shade900,
                              activeTrackColor: Colors.red.shade900,
                              inactiveTrackColor: Colors.grey,
                            ),
                            child: RangeSlider(
                              values: _priceRangeValues,
                              min: 100,
                              max: 1000,
                              divisions: 100,
                              labels: RangeLabels(
                                '${_priceRangeValues.start.round().toString()} k',
                                '${_priceRangeValues.end.round().toString()} k',
                              ),
                              onChanged: (RangeValues values) {
                                setState(() {
                                  print(
                                      'price ${_priceRangeValues.start.round()}, ${_priceRangeValues.end.round()}');
                                  _priceRangeValues = values;
                                  minPrice = values.start.round();
                                  maxPrice = values.end.round();
                                  _costController.text =
                                      '${_priceRangeValues.start.round()}k s/d ${_priceRangeValues.end.round()}k';
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: AbsorbPointer(
                        absorbing: widget.isUser ? false : true,
                        child: DropDownTitle(
                          onChange: (value) =>
                              setState(() => _priceCategory = value),
                          hint: "Kategori Harga",
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
                  hint: "Kategori Produk",
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
                        hint: "Kategori Lainnya",
                        readOnly: widget.isUser ? false : true,
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 21),
                child: TextFieldTitleWidget(_notedController,
                    hint: "Keterangan", readOnly: widget.isUser ? false : true),
              ),
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
        _attemptSave(file.data!["url"]);
      }
    } else {
      _attemptSave(null);
    }
  }

  _attemptSave(String? imageUrl) async {
    final req = {
      "id": widget.productModel != null ? _idProduct : "",
      "id_user": widget.idUser,
      "data": {
        "name": _nameProductController.text,
        "description": _descriptionController.text,
        "price":
            '${_priceRangeValues.start.round()}-${_priceRangeValues.end.round()}',
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
