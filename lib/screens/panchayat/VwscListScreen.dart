import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/panchayat/panchayat_provider.dart';
import '../../utils/auth/user_session_manager.dart';
import '../../utils/app_constants.dart';
import '../../service/local_storage_service.dart';

class VwscListScreen extends StatefulWidget {
  const VwscListScreen({super.key});

  @override
  State<VwscListScreen> createState() => _VwscListScreenState();
}

class _VwscListScreenState extends State<VwscListScreen> {
  final session = UserSessionManager();
  final storageService = LocalStorageService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await session.init();

      final provider =
      Provider.of<PanchayatProvider>(context, listen: false);

      await provider.fetchVwscMemberList(
        session.userId,
        int.parse(storageService.getString(AppConstants.prefState)!),
        int.parse(storageService.getString(AppConstants.prefPanchayatId)!),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PanchayatProvider>();
    final members = provider.vwscMember;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FB),
      appBar: AppBar(
        title: const Text(
          "List of VWSC Member",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : members.isEmpty
          ? const Center(child: Text("No Members Found"))
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
                colors: [
                  Colors.white,
                  Color(0xFFE3F2FD)
                ],
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

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name ?? "N/A",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user.mobile ?? "No Mobile",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        user.functionalDesignation ??
                            "No Designation",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Village: ${user.villageName ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}