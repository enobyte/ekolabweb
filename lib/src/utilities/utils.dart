import 'package:ekolabweb/src/bloc/bloc-provider.dart';
import 'package:flutter/material.dart';

Future<dynamic> routeToWidget(BuildContext context, Widget widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) {
      return BlocProvider(
        bloc: null,
        child: widget,
      );
    }),
  );
}
