import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class ProductService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductServiceState();
  }
}

class _ProductServiceState extends State<ProductService> {
  final _nameProductController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _notedController = TextEditingController();
  final _uploadPhotoController = TextEditingController();

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
                child: TextFieldTitleWidget(_costController, hint: "Harga"),
              ),
              TextFieldTitleWidget(_notedController, hint: "Keterangan"),
              Padding(
                padding: const EdgeInsets.only(top: 21, bottom: 21),
                child: TextFieldTitleWidget(
                  _uploadPhotoController,
                  hint: "Foto",
                  readOnly: true,
                  prefixIcon: IconButton(
                      onPressed: () => {}, icon: Icon(Icons.add_a_photo)),
                ),
              ),
              Row(
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
                      onClick: () => {},
                      borderRedius: 8,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
