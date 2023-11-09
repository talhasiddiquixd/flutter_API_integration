// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AuthProvider {
  Future<bool> register(
      String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {'email': email, 'password': password},
      );
      print(response.body);
      if (response.statusCode == 200) {
        const snackBar = SnackBar(
          content: Text('Registration Successful'),
          duration: Duration(seconds: 3),
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
        content: Text('Failed to register - $error'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Future<bool> login(
      String email, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: {'email': email, 'password': password},
      );
      print(response.body);
      if (response.statusCode == 200) {
        const snackBar = SnackBar(
          content: Text('Login Successful'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.blue,
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
        content: Text('$error'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}
