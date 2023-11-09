// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:home_test/providers/user_data_fetching.dart';
import 'package:home_test/screens/all_users_data.dart';
import 'package:home_test/screens/create_users.dart';
import 'package:home_test/screens/update_users_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Map<String, dynamic> user = {};
  void fetchUserData() async {
    final userData = await getUserData();
    print('Fetched user data: $userData');
    setState(() {
      user = userData;
      log('FirstName: ${user['first_name']}');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final userDataNotifier = Provider.of<UserDataNotifier>(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
        backgroundColor: const Color(0xFF5490F9),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Card(
            elevation: 10,
            margin: const EdgeInsets.only(top: 50), // Remove margin
            child: SizedBox(
              width: screenWidth * 0.86, // 90% of screen width
              height: screenHeight * 0.7, // 90% of screen height
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(user['avatar'] ??
                            'https://secure.gravatar.com/avatar/7603e48a6e823c2f0326e2326531e1e4/?s=48&d=https://images.binaryfortress.com/General/UnknownUser1024.png'),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome, ${user['first_name']} ${user['last_name']}!',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Email: ${user['email']}'),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5490F9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const UserDataUpdate(),
                            ),
                          );
                        },
                        child: const Text(
                          'Edit User Data',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5490F9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () async {
                          final userData = await userDataNotifier.getAllUsers(
                            context,
                          );
                          if (userData != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AllUsersDataScreen(
                                  user: userData,
                                ),
                              ),
                            );
                          }
                          log(userData.toString());
                        },
                        child: const Text(
                          'Fetch All Users',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5490F9),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const UserCreation(),
                            ),
                          );
                        },
                        child: const Text(
                          'Create New User',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>> getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? email = prefs.getString('email');
  String? firstName = prefs.getString('first_name');
  String? lastName = prefs.getString('last_name');
  String? avatar = prefs.getString('avatar');

  Map<String, dynamic> userData = {
    'email': email,
    'first_name': firstName,
    'last_name': lastName,
    'avatar': avatar,
  };

  print(userData);

  return userData;
}
