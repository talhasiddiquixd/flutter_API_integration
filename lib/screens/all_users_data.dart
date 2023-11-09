import 'package:flutter/material.dart';

class AllUsersDataScreen extends StatefulWidget {
  final List<Map<String, dynamic>> user;
  const AllUsersDataScreen({super.key, required this.user});

  @override
  State<AllUsersDataScreen> createState() => _AllUsersDataScreenState();
}

class _AllUsersDataScreenState extends State<AllUsersDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('Users List'),
        centerTitle: true,
        backgroundColor: const Color(0xFF5490F9),
      ),
      body: ListView.builder(
        itemCount: widget.user.length,
        itemBuilder: (context, index) {
          return UserCard(user: widget.user[index]);
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(user['avatar']),
        ),
        title: Text('${user['first_name']} ${user['last_name']}'),
        subtitle: Text(user['email']),
      ),
    );
  }
}
