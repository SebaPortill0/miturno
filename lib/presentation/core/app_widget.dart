import 'package:flutter/material.dart';
import 'package:App/presentation/sign_in/sign_in_page.dart';
import 'package:App/presentation/core/styles.dart';


class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: mainBlack,
      ),
      home: SignInPage(),
    );
  }
}