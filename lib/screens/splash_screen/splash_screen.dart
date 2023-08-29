import 'package:flutter/material.dart';
import 'package:izam_task/providers/user_provider.dart';
import 'package:izam_task/screens/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  double _width = 0;

  Future<void> navigateToLoginPage() async {
    Provider.of<UserProvider>(context, listen: false).initializeProvider();
    await Future.delayed(const Duration(
      milliseconds: 2000,
    )).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const LoginScreen()));
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Center(
      child: Image.asset(
        'assets/images/dLogo.png',
        fit: BoxFit.fitWidth,
        height: _width / 1.7,
        width: _width / 1.7,
      ),
    ));
  }
}
