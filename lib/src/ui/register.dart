import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/labeled_radio.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterState();
  }
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  var category = ["1", "2", "3", "4", "5", "6", "7"];
  String _isRadioSelected = "";
  final _bloc = UserBloc();

  @override
  void initState() {
    super.initState();
    _bloc.doRegister.listen((event) {
      if (event.status ?? false) {
        Navigator.of(context).pop();
      } else {
        showErrorMessage(context, "Register", event.message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Flexible(
            flex: 4,
            child: Container(
              color: Colors.red,
            )),
        Flexible(
            flex: 6,
            child: Container(
              alignment: AlignmentDirectional.center,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 8,
                    right: MediaQuery.of(context).size.width / 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextWidget(
                      txt: "Register",
                      align: TextAlign.start,
                      txtSize: 32,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, top: 40),
                      child: TextFieldWidget(
                        _nameController,
                        hint: "name",
                      ),
                    ),
                    TextFieldWidget(
                      _emailController,
                      hint: "email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                      child: TextFieldWidget(
                        _passwordController,
                        obscureText: true,
                        hint: "password",
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: TextWidget(txt: "Daftar sebagai"),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <LabeledRadio>[
                              LabeledRadio(
                                label: dataKind(int.parse(category[0])),
                                padding: EdgeInsets.zero,
                                value: category[0],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: dataKind(int.parse(category[1])),
                                padding: EdgeInsets.zero,
                                value: category[1],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: dataKind(int.parse(category[2])),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                value: category[2],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: dataKind(int.parse(category[6])),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                value: category[6],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LabeledRadio(
                                label: dataKind(int.parse(category[3])),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                value: category[3],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: dataKind(int.parse(category[4])),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                value: category[4],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                              LabeledRadio(
                                label: dataKind(int.parse(category[5])),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                value: category[5],
                                groupValue: _isRadioSelected,
                                onChanged: (String newValue) {
                                  setState(() {
                                    _isRadioSelected = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 25),
                      child: ButtonWidget(
                        txt: TextWidget(txt: "Register"),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        btnColor: Colors.redAccent,
                        onClick: () => _actionRegister(),
                        borderRedius: 4,
                      ),
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Sudah punya akun?",
                          children: [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: TextWidget(
                                      txt: "Login",
                                      color: Colors.red,
                                    )))
                          ],
                        ))
                  ],
                ),
              ),
            )),
      ],
    ));
  }

  _actionRegister() {
    _bloc.fetchRegister({
      "kind": int.parse(_isRadioSelected),
      "data": {
        "email": _emailController.text,
        "name": _nameController.text,
        "active": true,
        "password": _passwordController.text,
        "image":
            "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80"
      }
    });
  }
}
