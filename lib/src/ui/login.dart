import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                      txt: "Login",
                      align: TextAlign.start,
                      txtSize: 32,
                      color: Colors.red,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25, top: 40),
                      child: TextFieldWidget(
                        _userController,
                        hint: "email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    TextFieldWidget(
                      _passwordController,
                      obscureText: true,
                      hint: "password",
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 25),
                      child: ButtonWidget(
                        txt: TextWidget(txt: "Login"),
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
                          text: "Belum punya akun? ",
                          children: [
                            WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, "/register_menu"),
                                    child: TextWidget(
                                      txt: "Daftar sekarang",
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
