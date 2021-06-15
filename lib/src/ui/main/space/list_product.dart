import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';

import 'product_service.dart';

class ListProduct extends StatefulWidget {
  final bool isUser;

  @override
  State<StatefulWidget> createState() {
    return _ListProductState();
  }

  ListProduct(this.isUser);
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: TextWidget(
          txt: "List Product",
        ),
      ),
      floatingActionButton: widget.isUser
          ? FloatingActionButton(
              onPressed: () => routeToWidget(context, ProductService()),
              child: Icon(Icons.add),
              backgroundColor: Colors.red,
            )
          : SizedBox(),
    );
  }
}
