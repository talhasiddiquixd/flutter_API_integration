// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserCreationNotifier extends ChangeNotifier {
  Future<bool> createUser(Map<String, dynamic> userData, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/users'),
        body: json.encode(userData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final snackBar = SnackBar(
          content: Text("User created successfully with ID: ${responseBody['id']}"),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return true;
      } else {
        final Map<String, dynamic> errorBody = json.decode(response.body);
        final errorMessage = errorBody['error'].toString();
        final snackBar = SnackBar(
          content: Text(errorMessage),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return false;
      }
    } catch (error) {
      final snackBar = SnackBar(
        content: Text('Failed to create user - $error'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}
