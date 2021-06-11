import 'package:ekolabweb/src/widget/text_field_title.dart';
import 'package:flutter/material.dart';

class ProductService extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductServiceState();
  }
}

class _ProductServiceState extends State<ProductService> {
  final _nameProductController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldTitleWidget(_nameProductController,
                hint: "Nama Produk atau Jasa"),
          ],
        ),
      ),
    );
  }
}
