import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/vwsc/vwsc_provider.dart';
import 'package:provider/provider.dart';

import '../../widgets/user_card.dart';

class FtkSghPage extends StatelessWidget {
  const FtkSghPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VwscProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.njmFtkUsers.isEmpty) {
      return const Center(child: Text("No Users Found"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.njmFtkUsers.length,
      itemBuilder: (context, index) {
        final user = provider.njmFtkUsers[index];

        return UserCard(
          name: "${user.firstName} ${user.lastName}",
          email: user.email ?? "",
          village: user.villageName ?? "",
        );
      },
    );
  }
}
