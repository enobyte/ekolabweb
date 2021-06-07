import 'package:flutter/widgets.dart';

class TextWidget extends StatelessWidget {
  final String txt;
  final Color? color;
  final double? txtSize;
  final String? fontFamily;
  final TextAlign align;
  final int? maxLine;
  final FontWeight? weight;
  final double txtSpacing;

  const TextWidget(
      {required this.txt,
      this.color,
      this.txtSize,
      this.fontFamily,
      this.align = TextAlign.center,
      this.maxLine,
      this.weight,
      this.txtSpacing = 0.0});

  @override
  Widget build(BuildContext context) {
    return Text(txt,
        maxLines: maxLine,
        style: TextStyle(
            color: color,
            fontSize: txtSize,
            fontFamily: fontFamily,
            wordSpacing: txtSpacing,
            fontWeight: weight),
        textAlign: align);
  }
}
