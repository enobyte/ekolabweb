import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/drop_down_title.dart';
import 'package:ekolabweb/src/widget/labeled_radio.dart';
import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  String _isRadioSelected = "";

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
        backgroundColor: Colors.red,
        title: TextWidget(
          txt: "Profile",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 18, left: 16, right: 16),
          child: Row(
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
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DropDownTitle(
                        onChange: (value) => {},
                        hint: "Kategori Usaha",
                        data: ["Manufactur", "IT", "Otomotif"],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 46, bottom: 46),
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 21),
                        child: TextFieldTitleWidget(
                          _nameLawDepartment,
                          hint: "Nama Badan Hukum",
                        ),
                      ),
                      TextFieldTitleWidget(
                        _uploadPhotoController,
                        hint: "Foto",
                        readOnly: true,
                        prefixIcon: IconButton(
                            onPressed: () => {}, icon: Icon(Icons.add_a_photo)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 55, right: 16),
                              child: ButtonWidget(
                                txt: TextWidget(txt: "Batal"),
                                height: 40.0,
                                isFlatBtn: true,
                                width: 0,
                                btnColor: Colors.blue,
                                onClick: () => {},
                                borderRedius: 4,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 55, left: 16),
                              child: ButtonWidget(
                                txt: TextWidget(txt: "Simpan"),
                                height: 40.0,
                                width: 0,
                                btnColor: Colors.blue,
                                onClick: () => {},
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
}
