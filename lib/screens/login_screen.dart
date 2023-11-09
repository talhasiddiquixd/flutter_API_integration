// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:home_test/providers/auth_notifier.dart';
import 'package:home_test/providers/user_data_fetching.dart';
import 'package:home_test/screens/register_screen.dart';
import 'package:home_test/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
    final authNotifier = Provider.of<AuthNotifier>(context);
    final userDataNotifier = Provider.of<UserDataNotifier>(context);
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
              onPressed: () async {
                final loggedIn = await authNotifier.login(
                  emailController.text,
                  passwordController.text,
                  context,
                );

                if (loggedIn) {
                  // Fetch user data
                  final userData = await userDataNotifier.getUserByEmail(
                    emailController.text,
                    context,
                  );
                  saveUserData(userData);
                  if (userData != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  }
                }
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
                'Login',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(height: 30),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
              ),
              child: const Text(
                "Don't have an Account?",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void saveUserData(Map<String, dynamic>? userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', userData?['email']);
  prefs.setString('first_name', userData?['first_name']);
  prefs.setString('last_name', userData?['last_name']);
  prefs.setString('avatar', userData?['avatar']);
}
