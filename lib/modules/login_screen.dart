import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text(
          'LOGIN SCREEN',
          style: TextStyle(
            fontSize: 40,
          ),
        ),
      ),
    );
  }
}
