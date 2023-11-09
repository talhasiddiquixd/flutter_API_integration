import 'package:flutter/material.dart';
import 'package:home_test/providers/auth_notifier.dart';
import 'package:home_test/providers/user_creation_notifier.dart';
import 'package:home_test/providers/user_data_fetching.dart';
import 'package:home_test/providers/user_update_notifier.dart';
import 'package:home_test/screens/login_screen.dart';
import 'package:home_test/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthNotifier()),
        ChangeNotifierProvider(create: (context) => UserDataNotifier()),
        ChangeNotifierProvider(create: (context) => UserCreationNotifier()),
        ChangeNotifierProvider(create: (context) => UserUpdateNotifier()),
      ],
      child: FutureBuilder<bool>(
        future: checkUserDataExist(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return MaterialApp(
                title: 'Home Test',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: const Color(0xFF5490F9)),
                home: const WelcomeScreen(),
              );
            } else {
              return MaterialApp(
                title: 'Home Test',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(primaryColor: const Color(0xFF5490F9)),
                home: const LoginScreen(),
              );
            }
          } else {
            return MaterialApp(
              title: 'Home Test',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primaryColor: const Color(0xFF5490F9)),
              home: const CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

Future<bool> checkUserDataExist() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.containsKey('email');
}
