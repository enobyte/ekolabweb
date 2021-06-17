import 'package:ekolabweb/src/bloc/product_bloc.dart';
import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_field.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class UkmSubmission extends StatefulWidget {
  final String idProduct;
  final String idUserSub;
  final String kindUserSub;
  final String nameUserSub;

  @override
  State<StatefulWidget> createState() {
    return UkmSubmissionState();
  }

  UkmSubmission(
      this.idProduct, this.idUserSub, this.kindUserSub, this.nameUserSub);
}

class UkmSubmissionState extends State<UkmSubmission> {
  final submissionComment = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFieldWidget(
                    submissionComment,
                    hint: "Komentar",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ButtonWidget(
                    txt: TextWidget(txt: "Kirim"),
                    height: 40.0,
                    width: 100,
                    btnColor: Colors.redAccent,
                    onClick: () {
                      bloc.submissionRequest({
                        "id_product": widget.idProduct,
                        "data": {
                          "id_user_sub": widget.idUserSub,
                          "kind": widget.kindUserSub,
                          "name_user_sub": widget.nameUserSub,
                          "comment": submissionComment.text
                        }
                      });
                      Navigator.of(context).pop();
                    },
                    borderRedius: 4,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
