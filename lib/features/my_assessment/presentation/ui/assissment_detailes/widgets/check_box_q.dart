import 'package:flutter/material.dart';

class CheckBoxQ extends StatefulWidget {
  final String choice;
  bool isSelected;
  final void Function(bool?) onChanged;

  CheckBoxQ({
    super.key,
    required this.choice,
    required this.isSelected,
    required this.onChanged,
  });

  @override
  _CheckBoxQState createState() => _CheckBoxQState();
}

class _CheckBoxQState extends State<CheckBoxQ> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.choice),
      value: widget.isSelected,
      onChanged: (bool? value) {
        setState(() {
          widget.isSelected = value ?? false;
        });
        widget.onChanged(value);
      },
    );
  }
}
