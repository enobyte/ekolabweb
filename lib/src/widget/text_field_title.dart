import 'package:ekolabweb/src/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTitleWidget extends StatelessWidget {
  final String title;
  final Color textColor;
  final Color colorHint;
  final TextEditingController controller;
  final Color borderColor;
  final double borderRadius;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Color fillColor;
  final bool readOnly;
  final TextInputFormatter? textInputFormat;
  final String hint;

  TextFieldTitleWidget(this.controller,
      {Key? key,
      this.title = "Type Text Here...",
      this.colorHint = Colors.grey,
      this.borderColor = Colors.black12,
      this.borderRadius = 12.0,
      this.suffixIcon,
      this.textColor = Colors.black54,
      this.obscureText = false,
      this.readOnly = false,
      this.keyboardType,
      this.fillColor = Colors.white70,
      this.textInputFormat,
      this.prefixIcon,
      this.hint = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextWidget(txt: title),
        ),
        TextFormField(
          style: TextStyle(color: textColor),
          controller: controller,
          autocorrect: true,
          maxLines: null,
          minLines: 1,
          readOnly: readOnly,
          enableSuggestions: false,
          obscureText: obscureText,
          keyboardType: keyboardType ?? TextInputType.multiline,
          inputFormatters: [
            textInputFormat ??
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9 .]'))
          ],
          decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: colorHint),
            filled: true,
            hintText: hint,
            fillColor: fillColor,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(color: Colors.black12, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: borderColor),
            ),
          ),
        ),
      ],
    );
  }
}
