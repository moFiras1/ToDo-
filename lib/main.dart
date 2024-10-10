import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/Theme/app_Theme.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/auth/Login/login_screen.dart';
import 'package:todo/ui/auth/register/register_screen.dart';
import 'package:todo/ui/home/home_screen.dart';
import 'package:todo/ui/splash-screen/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AppAuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.homeRoute:
            {
              return MaterialPageRoute(
                builder: (context) => HomeScreen(),
              );
            }
          case AppRoutes.registerRoute:
            {
              return MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              );
            }
          case AppRoutes.LoginRoute:
            {
              return MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
            }
          case AppRoutes.splashRoute:
            {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(),
              );
            }
        }
      },
      initialRoute: AppRoutes.splashRoute,
    );
  }
}
