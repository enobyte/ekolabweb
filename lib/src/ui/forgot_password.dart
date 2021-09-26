import 'package:ekolabweb/src/bloc/user_bloc.dart';
import 'package:ekolabweb/src/utilities/string.dart';
import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPassState();
  }
}

class _ForgotPassState extends State<ForgotPass> {
  final _userController = TextEditingController();

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
                  Image.asset(
                    icForgotPass,
                    height: 200,
                    width: 200,
                  ),
                  TextFieldWidget(
                    _userController,
                    hint: "email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    txt: TextWidget(txt: "Kirim"),
                    height: 40.0,
                    width: MediaQuery.of(context).size.width,
                    btnColor: Colors.redAccent,
                    onClick: () => _actionPreforgotPass(),
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

  _actionPreforgotPass() async {
    if (_userController.text.isNotEmpty) {
      var data = await bloc.preForgotPass({"email": _userController.text});
      showErrorMessage(context, "Lupa Password", data.message);
    } else
      showErrorMessage(context, "Lupa Password", "Email tidak boleh kosong");
  }
}
