import 'package:flutter/material.dart';

import '../../widgets/user_card.dart';

class NjmWsoPage extends StatelessWidget {
  const NjmWsoPage({super.key});

  final List<Map<String, String>> dummyUsers = const [
    {
      "name": "Amit Sharma",
      "mobile": "9876543210",
      "email": "amit.sharma@gmail.com"
    },
    {
      "name": "Rohit Verma",
      "mobile": "9123456780",
      "email": "rohit.verma@gmail.com"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _buildUserList(dummyUsers);
  }

  Widget _buildUserList(List<Map<String, String>> users) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];

        return UserCard(user: user);
      },
    );
  }
}