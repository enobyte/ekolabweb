import 'dart:convert';
import 'dart:typed_data';
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
  String _corpCategory = "";
  String _businessCategory = "";
  String _isRadioSelected = "";

  PickedFile? _image;
  final picker = ImagePicker();
  Uint8List? _prevImage;

  @override
  void initState() {
    super.initState();
    _getData();
    user.bloc.updateUser.listen((event) {
      showErrorMessage(context, "Profil", event.message);
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
                          title: "Nama pemilik usaha"),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(
                          _addressController,
                          title: "Alamat",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _cityController,
                        title: "Kota",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: TextFieldTitleWidget(
                          _addrCompanyController,
                          title: "Alamat usaha/Alamat kantor",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _phoneController,
                        title: "No. Handphone",
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
                        padding: const EdgeInsets.only(top: 21, bottom: 21),
                        child: DropDownTitle(
                          onChange: (value) =>
                              setState(() => _corpCategory = value!),
                          hint: "Bidang Usaha",
                          data: [
                            "Kuliner",
                            "Fashion",
                            "Peralatan sekolah/kantor",
                            "Kerajinan tangan",
                            "Buah-buahan",
                            "Tanaman hias",
                            "Jasa service/perbaikan",
                            "Peralatan elektronik",
                            "Event organizer",
                            "Salon/rias",
                            "Catering",
                            "Group kesenian",
                            "Bidang lainnya",
                          ],
                          chooseValue: _corpCategory,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 40),
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
                        title: "Nama Badan Hukum",
                        hint: "CV, Inteligi",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, bottom: 55),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: TextWidget(txt: "Logo usaha"),
                            ),
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: _prevImage != null
                                  ? GestureDetector(
                                      child: Image.memory(
                                        _prevImage!,
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
                                          icon: Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                            )
                          ],
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
                                width: 0.0,
                                btnColor: Colors.red,
                                onClick: () => Navigator.of(context).pop(),
                                borderRedius: 4.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: ButtonWidget(
                                txt: TextWidget(txt: "Update"),
                                height: 40.0,
                                width: 0.0,
                                btnColor: Colors.blue,
                                onClick: () => _saveData(),
                                borderRedius: 4.0,
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
    _prevImage = await pickedFile!.readAsBytes();
    setState(() {
      if (_prevImage != null) {
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
      _corpCategory = userData.data!.data!["corp_category"];
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
            ? file.data!["url"]
            : userData.data!.data!["image"],
        "address": _addressController.text,
        "address_corp": _addrCompanyController.text,
        "city": _cityController.text,
        "phone": _phoneController.text,
        "buss_category": _businessCategory,
        "under_law": _isRadioSelected,
        "name_law": _nameLawDepartment.text,
        "corp_category": _corpCategory
      }
    };
    user.bloc.updateProfile(newData);
  }
}
