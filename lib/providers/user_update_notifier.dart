// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserUpdateNotifier extends ChangeNotifier {
  Future<bool> updateUser(String id, BuildContext context,
      {String? name, String? job}) async {
    try {
      final Map<String, dynamic> updateData = {};
      if (name != null) {
        updateData['name'] = name;
      }
      if (job != null) {
        updateData['job'] = job;
      }

      final response = await http.put(
        Uri.parse('https://reqres.in/api/users/$id'),
        body: json.encode(updateData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final snackBar = SnackBar(
          content: Text("User with ID $id updated successfully"),
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
        content: Text('Failed to update user - $error'),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}
