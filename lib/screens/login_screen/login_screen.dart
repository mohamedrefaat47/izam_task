import 'package:flutter/material.dart';
import 'package:izam_task/screens/login_screen/widgets/body.dart';
import 'package:izam_task/theme/styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Body(),
    );
  }
}
