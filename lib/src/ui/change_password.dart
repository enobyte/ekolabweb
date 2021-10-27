import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class ChangePassword extends StatefulWidget {
  final String idUser;

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordState();
  }

  ChangePassword(this.idUser);
}

class _ChangePasswordState extends State<ChangePassword> {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final verifyNewPassController = TextEditingController();
  bool _hideOldPass = true;
  bool _hideNewPass = true;

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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 21),
                    child: TextWidget(
                      txt: "Ganti Password",
                      txtSize: 24,
                    ),
                  ),
                  TextFieldWidget(
                    oldPassController,
                    hint: "Password lama",
                    obscureText: _hideOldPass ? true : false,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hideOldPass = !_hideOldPass;
                          });
                        },
                        icon: _hideOldPass
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    newPassController,
                    hint: "Password baru",
                    obscureText: _hideNewPass ? true : false,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hideNewPass = !_hideNewPass;
                          });
                        },
                        icon: _hideNewPass
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWidget(
                    verifyNewPassController,
                    hint: "Ulangi password baru",
                    obscureText: _hideNewPass ? true : false,
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hideNewPass = !_hideNewPass;
                          });
                        },
                        icon: _hideNewPass
                            ? Icon(Icons.remove_red_eye_outlined)
                            : Icon(Icons.remove_red_eye)),
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
                    borderRedius: 4,
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
      showErrorMessage(
          context, "Ganti Password", "Password tidak boleh kosong");
    } else if (newPassController.text.trim() !=
        verifyNewPassController.text.trim()) {
      showErrorMessage(context, "Ganti Password", "Password baru tidak sama");
    } else {
      var data = await bloc.actionChangePass({
        "id": widget.idUser,
        "password": newPassController.text.trim(),
        "old_pass": oldPassController.text.trim()
      });
      showErrorMessage(context, "Ganti Password", data.message);
    }
  }
}
