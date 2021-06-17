import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/drop_down_title.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductService extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _ProductServiceState();
  }

  ProductService(this.idUser);
}

class _ProductServiceState extends State<ProductService> {
  final _nameProductController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _notedController = TextEditingController();
  final _uploadPhotoController = TextEditingController();

  RangeValues _priceRangeValues = RangeValues(100, 1000);
  int minPrice = 0;
  int maxPrice = 0;
  String? _productCategory;
  PickedFile? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    bloc.createProduct.listen((event) {
      if (event.status!) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    _nameProductController.dispose();
    _descriptionController.dispose();
    _costController.dispose();
    _notedController.dispose();
    _uploadPhotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          txt: "Produk dan Jasa",
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 21, right: 21),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 21),
                child: TextFieldTitleWidget(_nameProductController,
                    hint: "Nama Produk atau Jasa"),
              ),
              TextFieldTitleWidget(_descriptionController, hint: "Deskripsi"),
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
                      flex: 8,
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
                                    'price ${_priceRangeValues.start
                                        .round()}, ${_priceRangeValues.end
                                        .round()}');
                                _priceRangeValues = values;
                                minPrice = values.start.round();
                                maxPrice = values.end.round();
                                _costController.text =
                                '${_priceRangeValues.start
                                    .round()}k s/d ${_priceRangeValues.end
                                    .round()}k';
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              DropDownTitle(
                onChange: (value) => setState(() => _productCategory = value!),
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
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 21),
                child:
                TextFieldTitleWidget(_notedController, hint: "Keterangan"),
              ),
              TextFieldTitleWidget(
                _uploadPhotoController,
                hint: "Foto",
                readOnly: true,
                prefixIcon: IconButton(
                  onPressed: () => _getImage(),
                  icon: Icon(Icons.add_a_photo),
                ),
              ),
              Padding(
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
                        onClick: () => {},
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
      ),
    );
  }

  Future _getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _uploadPhotoController.text = pickedFile.path;
        _image = PickedFile(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _uploadImage() async {
    FileModel? file;
    final bytes = await _image!.readAsBytes();
    final reqFile = FormData.fromMap({
      "image": MultipartFile.fromBytes(bytes,
          filename: '${DateTime
              .now()
              .millisecondsSinceEpoch}.png')
    });
    file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
    if (file.data != null) {
      _attemptSave(file.data!["url"]);
    }
  }

  _attemptSave(String imageUrl) async {
    final req = {
      "id_user": widget.idUser,
      "data": {
        "name": _nameProductController.text,
        "description": _descriptionController.text,
        "price":
        '${_priceRangeValues.start.round()}-${_priceRangeValues.end.round()}',
        "category": _productCategory,
        "note": _notedController.text,
        "image": imageUrl
      }
    };
    bloc.createProductList(req);
  }
}
