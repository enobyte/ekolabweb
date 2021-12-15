import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class NewPassword extends StatefulWidget {
  final String token;

  @override
  State<StatefulWidget> createState() {
    return _NewPasswordState();
  }

  NewPassword(this.token);
}

class _NewPasswordState extends State<NewPassword> {
  Map<String, dynamic> payload = {};
  final newPassController = TextEditingController();
  final verifyNewPassController = TextEditingController();

  @override
  void initState() {
    super.initState();
    payload = Jwt.parseJwt(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: FractionalOffset.center,
        child: SizedBox(
          height: 400,
          width: 400,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFieldWidget(
                    newPassController,
                    hint: "Password baru",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    verifyNewPassController,
                    hint: "Ulangi password baru",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonWidget(
                    txt: TextWidget(txt: "Kirim"),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    btnColor: Colors.redAccent,
                    onClick: () => _actionNewPassword(),
                    borderRedius: 4.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _actionNewPassword() async {
    if (newPassController.text.trim().isEmpty ||
        verifyNewPassController.text.trim().isEmpty) {
      showErrorMessage(context, "Lupa Password", "Password tidak boleh kosong");
    } else if (newPassController.text.trim() !=
        verifyNewPassController.text.trim()) {
      showErrorMessage(context, "Lupa Password", "Password tidak sama");
    } else {
      var data = await bloc.actionForgotPass({
        "email": payload["email"],
        "password": newPassController.text.trim()
      });
      if (data.status ?? false) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/login_menu', (route) => false);
      }
    }
  }
}
