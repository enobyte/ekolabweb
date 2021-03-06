import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/ui/main/admin/main_admin.dart';
import 'package:ekolabweb/src/ui/main/main_menu.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
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
  final bloc = UserBloc();
  bool _isHidePass = true;

  @override
  void dispose() {
    bloc.disposeLogin();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    bloc.doLogin.listen((event) {
      if (event.status ?? false) {
        if (event.data!.kind != 5) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/main_menu", (route) => false);
        } else {
          Navigator.of(context)
              .pushNamedAndRemoveUntil("/main_admin", (route) => false);
        }
      } else {
        showErrorMessage(context, "Login", event.message);
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
              height: double.infinity,
              color: Colors.red,
              child: Image.asset(logo),
            )),
        Flexible(
            flex: 6,
            child: Container(
              alignment: AlignmentDirectional.center,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10,
                    right: MediaQuery.of(context).size.width / 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
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
                      obscureText: _isHidePass ? true : false,
                      hint: "password",
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isHidePass = !_isHidePass;
                            });
                          },
                          icon: _isHidePass
                              ? Icon(Icons.remove_red_eye_outlined)
                              : Icon(Icons.remove_red_eye)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25, bottom: 20),
                      child: ButtonWidget(
                        txt: TextWidget(txt: "Login"),
                        height: 40.0,
                        width: MediaQuery.of(context).size.width,
                        btnColor: Colors.redAccent,
                        onClick: () => _actionLogin(),
                        borderRedius: 4.0,
                      ),
                    ),
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Belum punya akun? ",
                          style: TextStyle(color: Colors.black),
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
                        )),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, "/forgot_pass"),
                        child: TextWidget(
                          txt: "Lupa Password?",
                        ))
                  ],
                ),
              ),
            )),
      ],
    ));
  }

  _actionLogin() {
    bloc.fetchLogin(
        {"email": _userController.text, "password": _passwordController.text});
  }
}
