import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

class DetailResponseNotif extends StatelessWidget {
  final String nameProduct, description, status;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameProductView(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: _descProductView(),
          ),
          _statusProductView()
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

  DetailResponseNotif(this.nameProduct, this.description, this.status);
}
