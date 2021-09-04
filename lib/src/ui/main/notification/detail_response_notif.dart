import 'package:ekolabweb/src/widget/button_widget.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:ekolabweb/src/utilities/utils.dart';

import '../message/chating.dart';

class DetailResponseNotif extends StatelessWidget {
  final String idProduct,
      nameProduct,
      description,
      status,
      idUser,
      idResponder,
      reasonReject;

  DetailResponseNotif(this.idProduct, this.nameProduct, this.description,
      this.status, this.idUser, this.idResponder, this.reasonReject);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _nameProductView(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: _descProductView(),
          ),
          _statusProductView(),
          status.equalIgnoreCase("ditolak")
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: _reasonRejectProductView(),
                )
              : SizedBox(),
          status.equalIgnoreCase("diterima") ||
                  status.equalIgnoreCase("diskusi")
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ButtonWidget(
                    txt: TextWidget(
                      txt: "Komunikasi",
                    ),
                    height: 25,
                    width: 0,
                    btnColor: Colors.green,
                    onClick: () {
                      Navigator.of(context).pop();
                      routeToWidget(
                          context, ChatingForm(idUser, idResponder, idProduct));
                    },
                    borderRedius: 20,
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  _nameProductView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          txt: "Nama Product",
          txtSize: 21,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 4),
          child: TextWidget(
            txt: nameProduct,
            txtSize: 11,
          ),
        ),
      ],
    );
  }

  _descProductView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          txt: "Deskripsi",
          txtSize: 21,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 4),
          child: TextWidget(
            txt: description,
            txtSize: 11,
          ),
        ),
      ],
    );
  }

  _statusProductView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          txt: "Status",
          txtSize: 21,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 4),
          child: TextWidget(
            txt: status.toUpperCase(),
            txtSize: 11,
          ),
        ),
      ],
    );
  }

  _reasonRejectProductView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          txt: "Alasan Ditolak",
          txtSize: 21,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 4),
          child: TextWidget(
            txt: reasonReject,
            txtSize: 11,
          ),
        ),
      ],
    );
  }
}
