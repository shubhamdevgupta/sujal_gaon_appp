import 'package:flutter/material.dart';

import '../../widgets/user_card.dart';

class FtkSghPage extends StatelessWidget {
  const FtkSghPage({super.key});

  final List<Map<String, String>> dummyUsers = const [
    {
      "name": "Priya Singh",
      "mobile": "9988776655",
      "email": "priya.singh@gmail.com",
    },
    {
      "name": "Suresh Yadav",
      "mobile": "9012345678",
      "email": "suresh.yadav@gmail.com",
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
