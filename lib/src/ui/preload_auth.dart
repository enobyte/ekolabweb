import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';

class PreloadAuth extends StatefulWidget {
  final String token;

  @override
  State<StatefulWidget> createState() {
    return _PreloadAuthState();
  }

  PreloadAuth(this.token);
}

class _PreloadAuthState extends State<PreloadAuth> {
  @override
  void initState() {
    super.initState();
    if (Jwt.isExpired(widget.token)) {
      Navigator.pushNamed(context, "/not_found");
    } else {
      Navigator.pushNamed(context, "/action_new_password",
          arguments: widget.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
