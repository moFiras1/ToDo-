import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/providers/app_auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        navigate(context);
      },
    );
    return Scaffold(
      backgroundColor: Color(0xffDFECDB),
      body: Center(
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }

  void navigate(BuildContext context) async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (authProvider.isLoggedInBefore()) {
      await authProvider.retriveUserFromFirebase();
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.LoginRoute);
    }
  }
}
