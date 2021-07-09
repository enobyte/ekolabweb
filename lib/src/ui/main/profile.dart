import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ekolabweb/src/bloc/uploadfile_bloc.dart';
import 'package:ekolabweb/src/bloc/user_bloc.dart' as user;
import 'package:ekolabweb/src/model/file_model.dart';
import 'package:ekolabweb/src/model/user_model.dart';
import 'package:ekolabweb/src/utilities/sharedpreferences.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/drop_down_title.dart';
import 'package:ekolabweb/src/widget/labeled_radio.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _addrCompanyController = TextEditingController();
  final _nameLawDepartment = TextEditingController();
  final _phoneController = TextEditingController();
  final _uploadPhotoController = TextEditingController();
  String _businessCategory = "";
  String _isRadioSelected = "";

  PickedFile? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _getData();
    user.bloc.updateUser.listen((event) {
      showErrorMessage(context, "Profile", event.message);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _addrCompanyController.dispose();
    _nameLawDepartment.dispose();
    _phoneController.dispose();
    _uploadPhotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBase,
        title: TextWidget(
          txt: "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 21, left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextFieldTitleWidget(_nameController,
                          hint: "Nama Lengkap"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(
                          _addressController,
                          hint: "Alamat",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _cityController,
                        hint: "Kota",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(
                          _addrCompanyController,
                          hint: "Alamat usaha",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _phoneController,
                        hint: "No. Handphone",
                        textInputFormat: FilteringTextInputFormatter.digitsOnly,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropDownTitle(
                        onChange: (value) =>
                            setState(() => _businessCategory = value!),
                        hint: "Kategori Usaha",
                        data: ["Usaha Kecil", "Usaha Menengah", "Usaha Besar"],
                        chooseValue: _businessCategory,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, bottom: 40),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: TextWidget(
                              txt: "Badan Hukum :",
                              align: TextAlign.start,
                            )),
                            Flexible(
                              fit: FlexFit.loose,
                              child: LabeledRadio(
                                label: 'Ada',
                                padding: EdgeInsets.zero,
                                value: "Y",
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                            ),
                            Flexible(
                              fit: FlexFit.loose,
                              child: LabeledRadio(
                                label: 'Tidak',
                                padding: EdgeInsets.zero,
                                value: "N",
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFieldTitleWidget(
                        _nameLawDepartment,
                        hint: "Nama Badan Hukum",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 55),
                        child: TextFieldTitleWidget(
                          _uploadPhotoController,
                          hint: "Foto",
                          readOnly: true,
                          prefixIcon: IconButton(
                              onPressed: () => _getImage(),
                              icon: Icon(Icons.add_a_photo)),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: ButtonWidget(
                                txt: TextWidget(
                                  txt: "Batal",
                                  color: Colors.red,
                                ),
                                height: 40.0,
                                isFlatBtn: true,
                                width: 0,
                                btnColor: Colors.red,
                                onClick: () => {},
                                borderRedius: 4,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: ButtonWidget(
                                txt: TextWidget(txt: "Simpan"),
                                height: 40.0,
                                width: 0,
                                btnColor: Colors.blue,
                                onClick: () => _saveData(),
                                borderRedius: 4,
                              ),
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

  _getData() async {
    final userPref = await SharedPreferencesHelper.getStringPref(
        SharedPreferencesHelper.user);
    final userData = UserModel.fromJson(json.decode(userPref));
    setState(() {
      _nameController.text = userData.data!.data!["name"];
      _addressController.text = userData.data!.data!["address"];
      _cityController.text = userData.data!.data!["city"];
      _addrCompanyController.text = userData.data!.data!["address_corp"];
      _phoneController.text = userData.data!.data!["phone"];
      _businessCategory = userData.data!.data!["buss_category"];
      _isRadioSelected = userData.data!.data!["under_law"];
      _nameLawDepartment.text = userData.data!.data!["name_law"];
    });
  }

  _saveData() async {
    FileModel? file;

    if (_image != null) {
      final bytes = await _image!.readAsBytes();
      final reqFile = FormData.fromMap({
        "image": MultipartFile.fromBytes(bytes,
            filename: '${DateTime.now().millisecondsSinceEpoch}.png')
      });
      file = await bloc.fetchPostGeneralFile(reqFile);
    }

    final userPref = await SharedPreferencesHelper.getStringPref(
        SharedPreferencesHelper.user);
    final userData = UserModel.fromJson(json.decode(userPref));
    var newData = {
      "id": userData.data!.id,
      "data": {
        "name": _nameController.text,
        "email": userData.data!.data!["email"],
        "active": userData.data!.data!["active"],
        "password": userData.data!.data!["password"],
        "image": _image != null && file != null
            ? "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80" //file.data!["url"]
            : userData.data!.data!["image"],
        "address": _addressController.text,
        "address_corp": _addrCompanyController.text,
        "city": _cityController.text,
        "phone": _phoneController.text,
        "buss_category": _businessCategory,
        "under_law": _isRadioSelected,
        "name_law": _nameLawDepartment.text
      }
    };
    user.bloc.updateProfile(newData);
  }
}
