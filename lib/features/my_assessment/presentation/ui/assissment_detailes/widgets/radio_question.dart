import 'package:flutter/material.dart';

class RadioQ extends StatefulWidget {
  final int index;
  int? selectedChoices;
  void Function(int?) onChanged;
  String choice;
  RadioQ({
    super.key,
    required this.index,
    required this.selectedChoices,
    required this.choice,
    required this.onChanged,
  });
  @override
  _RadioQState createState() => _RadioQState();
}

class _RadioQState extends State<RadioQ> {
  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      value: widget.index,
      groupValue: widget.selectedChoices,
      title: Text(widget.choice, overflow: TextOverflow.ellipsis, maxLines: 5),
      onChanged: (int? value) {
        widget.onChanged(value);
        setState(() {
          widget.selectedChoices = value;
        });
      },
    );
  }
}
