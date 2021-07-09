import 'dart:html';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart' as uploadFile;
import 'package:mime/mime.dart';

class KonsinyorService extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _KonsinyorServiceState();
  }

  KonsinyorService(this.idUser);
}

class _KonsinyorServiceState extends State<KonsinyorService> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startendController = TextEditingController();
  final _priceController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  final _uploadDocController = TextEditingController();

  late Uint8List? uploadedImage;
  late Uint8List? uploadedDoc;
  String? extensionImage;
  String? extensionDoc;
  final titleInvest = TextEditingController();
  final valueInvest = TextEditingController();

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
                      TextFieldTitleWidget(_nameController,
                          hint: "Nama Produk"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(_descriptionController,
                            hint: "Deskripsi"),
                      ),
                      TextFieldTitleWidget(_priceController, hint: "Harga"),
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
                      TextFieldTitleWidget(_startendController,
                          hint: "Lama Konsinyasi"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(
                          _uploadPhotoController,
                          hint: "Foto",
                          readOnly: true,
                          prefixIcon: IconButton(
                              onPressed: () => _startFilePicker('image'),
                              icon: Icon(Icons.add_a_photo)),
                        ),
                      ),
                      TextFieldTitleWidget(
                        _uploadDocController,
                        hint: "Document",
                        readOnly: true,
                        prefixIcon: IconButton(
                            onPressed: () => _startFilePicker("doc"),
                            icon: Icon(Icons.note_add_rounded)),
                      ),
                      Padding(
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

    final reqFile = FormData.fromMap({
      "image": MultipartFile.fromBytes(uploadedImage!.toList(),
          filename:
              '${DateTime.now().millisecondsSinceEpoch}.' + extensionImage!)
    });

    final reqFileDoc = FormData.fromMap({
      "image": MultipartFile.fromBytes(uploadedDoc!.toList(),
          filename: '${DateTime.now().millisecondsSinceEpoch}.' + extensionDoc!)
    });

    file = await uploadFile.bloc.fetchPostGeneralFile(reqFile);
    fileDoc = await uploadFile.bloc.fetchPostGeneralFile(reqFileDoc);

    if (file.data != null && fileDoc.data != null) {
      _attemptSave(file.data!["url"], fileDoc.data!["url"]);
    }
  }

  _attemptSave(String imageUrl, String docUrl) async {
    final req = {
      "id_user": widget.idUser,
      "data": {
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": _priceController.text,
        "start_end": _startendController.text,
        "image": "",
        "doc": ""
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
