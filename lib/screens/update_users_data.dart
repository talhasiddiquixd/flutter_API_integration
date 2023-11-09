import 'package:flutter/material.dart';
import 'package:home_test/providers/user_update_notifier.dart';
import 'package:provider/provider.dart';

class UserDataUpdate extends StatefulWidget {
  const UserDataUpdate({Key? key}) : super(key: key);

  @override
  State<UserDataUpdate> createState() => _UserDataUpdateState();
}

class _UserDataUpdateState extends State<UserDataUpdate> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  bool isLoading = false;
  bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF5490F9),
        title: const Text('Update User'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isSuccess ? const Color(0xFF5490F9) : Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_outline_outlined,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 159, 188, 238),
                        borderRadius: BorderRadius.circular(100)),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit button press
                      },
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            const SizedBox(height: 20),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: jobController,
              decoration: const InputDecoration(labelText: 'Job'),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5490F9),
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });

                final userUpdateNotifier =
                    Provider.of<UserUpdateNotifier>(context, listen: false);
                final result = await userUpdateNotifier.updateUser(
                  idController.text,
                  context,
                  name: nameController.text,
                  job: jobController.text,
                );

                setState(() {
                  isLoading = false;
                  isSuccess = result;
                });
              },
              child: const Text(
                'Update User',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
