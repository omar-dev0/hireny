import 'package:flutter/material.dart';
import 'package:hireny/utils/shared_widgets/buttons/app_button.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [AppButton(onPress: () {}, text: 'show dialog')],
          ),
        ),
      ),
    );
  }
}
