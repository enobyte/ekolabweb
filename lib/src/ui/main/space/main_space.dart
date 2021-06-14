import 'package:ekolabweb/src/utilities/utils.dart';
import 'package:flutter/material.dart';

import 'product_service.dart';

class MainSpace extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainSpaceState();
  }
}

class _MainSpaceState extends State<MainSpace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => routeToWidget(context, ProductService()),
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
    );
  }
}
