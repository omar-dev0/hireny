import 'package:flutter/material.dart';

class RadioQ extends StatelessWidget {
  final int index; // The index of this radio option
  final int? selectedChoice; // The currently selected index (from parent)
  final void Function(int?) onChanged; // Callback to parent
  final String choice; // The display text

  const RadioQ({
    super.key,
    required this.index,
    required this.selectedChoice,
    required this.choice,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<int>(
      value: index,
      groupValue: selectedChoice,
      title: Text(
        choice,
        overflow: TextOverflow.ellipsis,
        maxLines: 5,
      ),
      onChanged: onChanged,
    );
  }
}
