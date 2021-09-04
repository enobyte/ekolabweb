import 'package:flutter/material.dart';

import 'text_widget.dart';

class DropDownTitle extends StatefulWidget {
  final Function(String?) onChange;
  final List<String> data;
  final String hint;
  final chooseValue;

  DropDownTitle(
      {Key? key,
      required this.onChange,
      required this.hint,
      required this.data,
      required this.chooseValue})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DropDownTitleState(chooseValue);
  }
}

class _DropDownTitleState extends State<DropDownTitle> {
  String? chooseValue;

  _DropDownTitleState(this.chooseValue);

  @override
  void didUpdateWidget(DropDownTitle oldWidget) {
    if (this.chooseValue != widget.chooseValue) {
      setState(() {
        this.chooseValue = widget.chooseValue;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

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
            child: DropdownButton<String>(
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
