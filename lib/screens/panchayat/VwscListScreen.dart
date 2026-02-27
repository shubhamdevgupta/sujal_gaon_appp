import 'package:flutter/material.dart';

import '../../models/vwsc/vwsc_member_list.dart';

class VwscListScreen extends StatefulWidget {
  const VwscListScreen({super.key});
  @override
  State<VwscListScreen> createState() => _VwscListScreenState();
}

class _VwscListScreenState extends State<VwscListScreen> {
  late List<VwscMember> members;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Receive arguments safely
    final args =
    ModalRoute.of(context)!.settings.arguments as List<VwscMember>;
    members = args;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FB),
      appBar: AppBar(
        title: const Text(
          "List of VWSC Member",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false, // 🔥 This hides back button
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E88E5), Color(0xFF64B5F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      body: members.isEmpty
          ? const Center(
        child: Text("No Members Found"),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final user = members[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFE3F2FD)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [

                /// Avatar
                Container(
                  height: 55,
                  width: 55,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF64B5F6),
                        Color(0xFF1E88E5)
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),

                const SizedBox(width: 16),

                /// Details
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [

                      /// Name
                      Text(
                        user.name ?? "N/A",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      /// Email
                      Text(
                        user.mobile?.isNotEmpty == true
                            ? user.mobile!
                            : "Mobile No",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      /// Email
                      Text(
                        user.functionalDesignation?.isNotEmpty == true
                            ? user.functionalDesignation!
                            : "No Email",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 4),

                      /// Village
                      Text(
                        "Village: ${user.villageName ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}