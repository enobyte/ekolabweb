import 'package:flutter/material.dart';

import 'text_widget.dart';

class DropDownTitle extends StatefulWidget {
  final Function(Object?) onChange;
  final List<String> data;
  final String hint;

  DropDownTitle(
      {required this.onChange, required this.hint, required this.data});

  @override
  State<StatefulWidget> createState() {
    return _DropDownTitleState();
  }
}

class _DropDownTitleState extends State<DropDownTitle> {
  Object? chooseValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: TextWidget(txt: widget.hint),
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.black12,
                width: 1,
              ),
              color: Colors.white),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              itemHeight: 50.0,
              style: TextStyle(fontSize: 15.0, color: Colors.grey[700]),
              items: widget.data.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  chooseValue = value;
                  widget.onChange(value);
                });
              },
              value: chooseValue,
            ),
          ),
        ),
      ],
    );
  }
}
