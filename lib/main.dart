import 'package:flutter/material.dart';
import 'package:inflearn/common/component/custom_text-form_field.dart';
import 'package:inflearn/common/view/splash_screen.dart';
import 'package:inflearn/user/view/login_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Notosans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
