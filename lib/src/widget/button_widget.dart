import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'text_widget.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  final Widget txt;
  final double height;
  final double width;
  final Color btnColor;
  final Function onClick;
  final isFlatBtn;
  final isIconBtn;
  final Icon? btnIcon;
  final borderRedius;

  ButtonWidget(
      {required this.txt,
      required this.height,
      required this.width,
      required this.btnColor,
      required this.onClick,
      this.isFlatBtn,
      this.isIconBtn,
      this.btnIcon,
      this.borderRedius = 0.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ButtonTheme(
        child: ((isFlatBtn == null || !isFlatBtn) &&
                (isIconBtn == null || !isIconBtn))
            ? ElevatedButton(
                child: txt,
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    primary: btnColor,
                    shadowColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRedius),
                        side: BorderSide(color: Colors.transparent))),
                onPressed: () {
                  this.onClick();
                },
              )
            : ((isFlatBtn == null || !isFlatBtn) &&
                    (isIconBtn != null || isIconBtn))
                ? ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        btnIcon ?? Icon(Icons.bookmark_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        txt
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: btnColor,
                        shadowColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRedius),
                            side: BorderSide(color: Colors.transparent))),
                    onPressed: () {
                      this.onClick();
                    },
                  )
                : TextButton(
                    child: txt,
                    style: TextButton.styleFrom(
                        shadowColor: Colors.redAccent[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRedius),
                            side: BorderSide(color: btnColor))),
                    onPressed: () {
                      this.onClick();
                    },
                  ),
        height: height,
      ),
    );
  }
}
