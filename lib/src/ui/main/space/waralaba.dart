import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class Waralaba extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WaralabaState();
  }
}

class WaralabaState extends State<Waralaba> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _termController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  final _uploadDocController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _termController.dispose();
    _uploadPhotoController.dispose();
    _uploadDocController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextWidget(
          txt: "Waralaba",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFieldTitleWidget(_nameController,
                          hint: "Nama Produk atau Jasa"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_descriptionController,
                            hint: "Deskripsi"),
                      ),
                      TextFieldTitleWidget(_locationController,
                          hint: "Lokasi ditawarkan"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21),
                        child: TextFieldTitleWidget(_termController,
                            hint: "Persyaratan"),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 46),
                        child: TextWidget(
                          txt: "Harga Investasi:",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _uploadPhotoController,
                        hint: "Foto",
                        readOnly: true,
                        prefixIcon: IconButton(
                            onPressed: () => {}, icon: Icon(Icons.add_a_photo)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 55),
                        child: TextFieldTitleWidget(
                          _uploadDocController,
                          hint: "Document",
                          readOnly: true,
                          prefixIcon: IconButton(
                              onPressed: () => {},
                              icon: Icon(Icons.note_add_rounded)),
                        ),
                      ),
                      Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
