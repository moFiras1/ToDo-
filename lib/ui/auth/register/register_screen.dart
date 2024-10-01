import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/core/utils/image%20utils.dart';
import 'package:todo/ui/widgets/coustme_text_form_field.dart';

import '../../../core/app_routes.dart';
import '../../../core/utils/email validation.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController EmailController = TextEditingController();

  TextEditingController passWordController = TextEditingController();

  TextEditingController ConfirmPassWordController = TextEditingController();

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
          title: Text("Register Screen"),
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
                    controller: fullNameController,
                    label: 'Full Name',
                    KeyBoardType: TextInputType.name,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please Enter Full Name';
                      }
                      if (input is int) {
                        return 'Sorry, Invalid Input';
                      }
                      return null;
                    },
                  ), //Full name
                  CoustmeTextFormField(
                    controller: userNameController,
                    label: 'User Name',
                    KeyBoardType: TextInputType.name,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'Please, Enter user name';
                      }
                      return null;
                    },
                  ), //user name
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
                  CoustmeTextFormField(
                    controller: ConfirmPassWordController,
                    label: 'Confirm Password',
                    KeyBoardType: TextInputType.visiblePassword,
                    isSecureText: true,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return 'please confirm password';
                      }
                      if (input != passWordController.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ), // confirm password
                  ElevatedButton(
                      onPressed: () {
                        register(EmailController.text, passWordController.text);
                      },
                      child: Text('Register')),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have account'),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.LoginRoute);
                          },
                          child: Text(
                            'Login',
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

  void register(String email, String password) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }
    try {
      DialogUtils.ShowLaodingDialog(context, 'Create Account...');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(
        context,
        message: 'Registration Successfully',
        posActionTitle: 'Login',
        posAction: () {
          Navigator.pushReplacementNamed(context, AppRoutes.LoginRoute);
        },
      );
    } on FirebaseAuthException catch (e) {
      DialogUtils.hideDialog(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMessageDialog(context,
            message: 'The password provided is too weak.',
            posActionTitle: 'Try Again');
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMessageDialog(context,
            message:
                'The account already exists for that email, try another account',
            posActionTitle: 'OK');
      }
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          message: e.toString(), posActionTitle: 'OK');
    }
  }
}
