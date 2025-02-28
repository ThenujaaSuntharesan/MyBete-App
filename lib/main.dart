import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mybete_app/diabete_options.dart';
import 'package:mybete_app/firebase_options.dart';
import 'package:mybete_app/onboarding/onboarding_view.dart';
import 'package:mybete_app/src/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool("onboarding") ?? false;
  final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(Duration(milliseconds: 500));
  FlutterNativeSplash.remove();
  runApp(MyApp(onboarding: onboarding, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  final bool isLoggedIn;
  const MyApp({super.key, this.onboarding = false, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: isLoggedIn
          ? DiabeteOptions()
          : (onboarding ? DiabeteOptions() : OnboardingView()),
    );
  }
}