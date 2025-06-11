import 'package:flutter/material.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../../../../utils/constants/app_fonts.dart';
import '../../../../utils/lang/lang.dart';

class GenderSelector extends StatefulWidget {
  void Function(String? val) onGenderSelected;
  String? selectedGroup;

  GenderSelector({super.key, required this.onGenderSelected});
  @override
  _GenderSelectorState createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(Lang.gender, style: AppFonts.mainText.copyWith(fontSize: 16.cSp)),
        Row(
          children: [
            Radio<String>(
              value: 'male',
              groupValue: widget.selectedGroup,
              onChanged: (value) {
                setState(() {
                  widget.selectedGroup = value;
                  widget.onGenderSelected.call(value);
                });
              },
            ),
            Text('Male'),
            Radio<String>(
              value: 'female',
              groupValue: widget.selectedGroup,
              onChanged: (value) {
                setState(() {
                  widget.selectedGroup = value;
                  widget.onGenderSelected.call(value);
                });
              },
            ),
            Text('Female'),
          ],
        ),
      ],
    );
  }
}
