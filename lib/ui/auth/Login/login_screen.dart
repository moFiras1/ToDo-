import 'package:flutter/material.dart';
import 'package:todo/core/utils/image%20utils.dart';
import 'package:todo/ui/widgets/coustme_text_form_field.dart';

import '../../../core/utils/email validation.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController EmailController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(getImagePathByName(
                'auth_bg_pattern.png',
              )))),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login Screen"),
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                  ),
                  CoustmeTextFormField(
                    controller: EmailController,
                    label: 'E-mail Address',
                    KeyBoardType: TextInputType.emailAddress,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please enter ur email';
                      }
                      if (!isValidEmail(input)) {
                        return 'Invalid e-mail';
                      }
                      return null;
                    },
                  ), //email
                  CoustmeTextFormField(
                    controller: passWordController,
                    label: 'Password',
                    KeyBoardType: TextInputType.visiblePassword,
                    isSecureText: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      if (input.length < 6) {
                        return 'weake password';
                      }
                      return null;
                    },
                  ), //password

                  ElevatedButton(
                      onPressed: () {
                        register();
                      },
                      child: Text('Login')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
