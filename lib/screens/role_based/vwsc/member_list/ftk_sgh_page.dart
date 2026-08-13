import 'package:flutter/material.dart';
import 'package:jal_sanchalan/providers/vwsc/vwsc_provider.dart';
import 'package:provider/provider.dart';

import '../../../widgets/user_card.dart';


class FtkSghPage extends StatefulWidget {
  const FtkSghPage({super.key});

  @override
  State<FtkSghPage> createState() => _FtkSghPageState();
}

class _FtkSghPageState extends State<FtkSghPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VwscProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.njmFtkUsers.isEmpty) {
      return const Center(child: Text("No Users Found"));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/SJL_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: provider.njmFtkUsers.length,
          itemBuilder: (context, index) {
            final user = provider.njmFtkUsers[index];

            return UserCard(
              name: "${user.firstName} ${user.lastName}",
              email: user.email ?? "",
              village: user.villageName ?? "",
              phone:  "9599460671",
              trainingLevel:  "State Level",
              address: user.address ?? "",
            );
          },
        ),
      ),
    );
  }
}
