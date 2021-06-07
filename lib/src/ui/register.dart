import 'package:ekolabweb/src/widget/button_widget.dart';
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
  var category = ["pewaralaba", "ukmumk", "konsinyasi", "investor"];
  String _isRadioSelected = "";

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
                      _passwordController,
                      obscureText: true,
                      hint: "password",
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                      child: TextFieldWidget(
                        _emailController,
                        hint: "email",
                        keyboardType: TextInputType.emailAddress,
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
                                label: 'Pewaralaba',
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
                                label: 'UKM/UMK',
                                padding: EdgeInsets.zero,
                                value: category[1],
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
                                label: 'Konsinyasi',
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
                                label: 'Investor',
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
                        onClick: () => {},
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
}

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    Key? key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final String groupValue;
  final String value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value,
              onChanged: (String? newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
