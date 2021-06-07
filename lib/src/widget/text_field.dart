import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final Color textColor;
  final Color colorHint;
  final TextEditingController controller;
  final Color borderColor;
  final double borderRadius;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color fillColor;

  TextFieldWidget(this.controller,
      {Key? key,
      this.hint = "Type Text Here...",
      this.colorHint = Colors.grey,
      this.borderColor = Colors.black12,
      this.borderRadius = 12.0,
      this.suffixIcon,
      this.textColor = Colors.black54,
      this.obscureText = false,
      this.keyboardType,
      this.fillColor = Colors.white70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: textColor),
      controller: controller,
      autocorrect: true,
      enableSuggestions: false,
      obscureText: obscureText,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hint,
        hintStyle: TextStyle(color: colorHint),
        filled: true,
        fillColor: fillColor,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: Colors.black12, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
