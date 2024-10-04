import 'package:flutter/material.dart';
import 'package:tech_shop/screens/init_screen.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  final String successMessage;

  const LoginSuccessScreen({super.key, required this.successMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Image.asset(
            "assets/images/success.png",
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.4, //40%
          ),
          const SizedBox(height: 16),
          Text(
            successMessage,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const InitScreen()), (route) => route.isFirst,
                );
              },
              child: const Text("Back to home page"),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
