import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/core/utils/image%20utils.dart';
import 'package:todo/ui/widgets/coustme_text_form_field.dart';

import '../../../core/utils/email validation.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        login(EmailController.text, passWordController.text);
                      },
                      child: Text('Login')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have account'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.registerRoute);
                          },
                          child: Text(
                            'Create account',
                            style: TextStyle(fontSize: 16),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(String emailAddress, String password) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      DialogUtils.ShowLaodingDialog(context, 'please, wait..');
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: 'User logged in Scussessfully',
          posActionTitle: 'OK', posAction: () {
        Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
      });
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      print('ammmmmm hererererer${e.toString()}');
      if (e.code == 'user-not-found' ||
          e.code == 'No user found for that email.') {
        DialogUtils.showMessageDialog(
          context,
          message: 'Wrong Email or password',
          posActionTitle: 'Try Agian',
        );
      }
    }
  }
}
