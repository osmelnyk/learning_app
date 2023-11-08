import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Name: ',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Email: ',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Implement your functionality to delete the account
              },
              child: const Text('Delete Account'),
            ),
          ],
        ),
      ),
    );
  }
}
