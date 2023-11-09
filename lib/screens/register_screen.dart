import 'package:flutter/material.dart';
import 'package:home_test/providers/auth_notifier.dart';
import 'package:home_test/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  double logoPosition = 40;

  @override
  void initState() {
    super.initState();
    loadLogoPosition();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        logoPosition = 140;
        saveLogoPosition();
      });
    });
  }

  loadLogoPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      logoPosition = prefs.getDouble('logoPosition') ?? 140;
    });
  }

  saveLogoPosition() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('logoPosition', logoPosition);
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final authNotifier = Provider.of<AuthNotifier>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.easeInOut,
              width: logoPosition,
              child: Image.asset(
                'assets/logo.png',
                height: 120,
              ),
            ),
            const SizedBox(height: 60),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                authNotifier
                    .register(
                        emailController.text, passwordController.text, context)
                    .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen())));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5490F9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              child: const Text(
                'Register',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text(
                'Already Registered?',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
