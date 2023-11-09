// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDataNotifier extends ChangeNotifier {
  Future<List<Map<String, dynamic>>?> getAllUsers(BuildContext context) async {
  try {
    final responsePage1 = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    final responsePage2 = await http.get(Uri.parse('https://reqres.in/api/users?page=2'));

    if (responsePage1.statusCode == 200 && responsePage2.statusCode == 200) {
      final List<Map<String, dynamic>> usersPage1 = List<Map<String, dynamic>>.from(json.decode(responsePage1.body)['data']);
      final List<Map<String, dynamic>> usersPage2 = List<Map<String, dynamic>>.from(json.decode(responsePage2.body)['data']);

      return [...usersPage1, ...usersPage2];
    } else {
      const snackBar = SnackBar(
        content: Text('Failed to Load User Data'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  } catch (error) {
    const snackBar = SnackBar(
      content: Text('Error loading user data'),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    return null;
  }
}

  Future<Map<String, dynamic>?> getUserByEmail(String userEmail, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse('https://reqres.in/api/users'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> users = data['data'];
        final user = users.firstWhere(
          (user) => user['email'] == userEmail,
          orElse: () => null,
        );

        if (user != null) {
          return user;
        } else {
          return null;
        }
      } else {
        const snackBar = SnackBar(
          content: Text('Failed to Load User Data'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return null;
      }
    } catch (error) {
      const snackBar = SnackBar(
        content: Text('Error loading user data'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return null;
    }
  }
}
