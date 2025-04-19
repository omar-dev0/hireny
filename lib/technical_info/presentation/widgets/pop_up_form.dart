import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpButtons.dart';
import 'FormTextPart.dart';


void popUpForm(BuildContext context,Function()? onPressed) {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _startingYear = TextEditingController();
  final _endingYear = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              width: 600,
              height: 340,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                FormTextPart(
                    nameController: _nameController,
                    emailController: _emailController,
                    startingYear: _startingYear,
                    endingYear: _endingYear,
                    formKey: _formKey,
                ),
                  const SizedBox(height: 30),
                  popUpButtons(onPressed: onPressed,),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
